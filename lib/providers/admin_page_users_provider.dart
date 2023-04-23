import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';

class AdminPageUsersProvider with ChangeNotifier {

  final _collection = FirebaseFirestore.instance.collection("users");

  List<UserData> _usersData = [];
  List<UserData> get usersData => _usersData;

  void load() {
    _collection.get().then((snapshot) {
      _usersData = snapshot.docs.map(
        (doc) => UserData.fromJson(doc.data())).toList();
      notifyListeners();
    });
  }


  void _update(String uid, String column, dynamic data) {
    try {
      _collection.doc(uid).update({column: data});
    } on Exception {
      return;
    }
    notifyListeners();
  }

  void updatePermission(String uid, UserPermission permission) {
    _update(uid, "permission", permission.id);
  }

  void updateStudentId(String uid, int studentId) {
    _update(uid, "studentId", studentId);
  }

}