import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';

class AdminPageUsersProvider with ChangeNotifier {

  AdminPageUsersProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("users");

  String _keyword = "";
  List<UserData> _usersData = [];
  List<UserData> get usersData {
    if (_keyword == "") {
      return _usersData;
    }

    return _usersData.where((element) => (
      element.uid.contains(_keyword) ||
      (element.name != null ? element.name!.contains(_keyword) : false) ||
      (element.email != null ? element.email!.contains(_keyword) : false) ||
      element.studentId.toString().contains(_keyword) ||
      element.permission.name.contains(_keyword)
    )).toList();
  }

  void _load() {
    _collection.get().then((snapshot) {
      _usersData = snapshot.docs.map(
        (doc) => UserData.fromJson(doc.data())).toList();
      if (kDebugMode) {
        print("admin_page_users_provider -> loaded");
      }
      _usersData.sort((x, y) {
        if (x.permission < y.permission) {
          return -1;
        } else if (x.permission > y.permission) {
          return 1;
        }
        if (x.name != null && y.name != null) {
          return x.name!.compareTo(y.name!);
        }
        return 0;
      });
      _usersData = _usersData.reversed.toList();
      notifyListeners();
    });
  }


  void _update(String uid, String column, dynamic data) {
    try {
      _collection.doc(uid).update({column: data}).then((_) {
        _collection.doc(uid).get().then((value) {
          final data = value.data();
          final index = usersData.indexWhere((element) => element.uid == uid);
          usersData[index] = UserData.fromJson(data!);
          if (kDebugMode) {
            print("admin_page_users_provider -> updated");
          }
          notifyListeners();
        });
      });
    } on Exception {
      return;
    }
  }

  void filter(String? keyword) {
    _keyword = keyword ?? "";
    notifyListeners();
  }

  void updatePermission(String uid, UserPermission permission) {
    _update(uid, "permission", permission.id);
  }

  void updateStudentId(String uid, int studentId) {
    _update(uid, "studentId", studentId);
  }

}