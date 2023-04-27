import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';

class UsersProvider with ChangeNotifier {
  UsersProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("users");

  String _keyword = "";
  Map<String, UserData> _usersData = {};
  Map<String, UserData> get usersData {
    if (_keyword == "") {
      return _usersData;
    }

    Map<String, UserData> queryUsers = {};
    for (var data in _usersData.values
        .where((element) => (element.uid.contains(_keyword) ||
            element.name.contains(_keyword) ||
            element.email.contains(_keyword) ||
            element.studentId.toString().contains(_keyword) ||
            element.permission.name.contains(_keyword)))
        .toList()) {
      queryUsers[data.uid] = data;
    }
    return queryUsers;
  }

  void _load() {
    _collection.get().then((snapshot) {
      _usersData = Map.fromIterable(
          snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList(),
          key: (v) => (v as UserData).uid);
      if (kDebugMode) {
        print("admin_page_users_provider -> loaded");
      }
      // _usersData.sort((x, y) {
      //   if (x.permission < y.permission) {
      //     return -1;
      //   } else if (x.permission > y.permission) {
      //     return 1;
      //   }
      //   return x.name.compareTo(y.name);
      // });
      // _usersData = _usersData.reversed.toList();
      notifyListeners();
    });
  }

  void _update(String uid, String column, dynamic data) {
    try {
      _collection.doc(uid).update({column: data}).then((_) {
        _collection.doc(uid).get().then((value) {
          final data = value.data();
          usersData[uid] = UserData.fromJson(data!);
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
