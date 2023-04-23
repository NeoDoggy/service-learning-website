import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';

class AdminPageUsersProvider with ChangeNotifier {

  AdminPageUsersProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("users");

  List<UserData> _usersData = [];
  List<UserData> get usersData => _usersData;

  void _load() {
    _collection.get().then((snapshot) {
      _usersData = snapshot.docs.map(
        (doc) => UserData.fromJson(doc.data())).toList();
      if (kDebugMode) {
        print("admin_page_users_provider -> loaded");
      }
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
            print("admin_page_users_provider -> update");
          }
          notifyListeners();
        });
      });
    } on Exception {
      return;
    }
  }

  void updatePermission(String uid, UserPermission permission) {
    _update(uid, "permission", permission.id);
  }

  void updateStudentId(String uid, int studentId) {
    _update(uid, "studentId", studentId);
  }

}