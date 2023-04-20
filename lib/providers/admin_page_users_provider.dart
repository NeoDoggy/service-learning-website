import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_learning_website/backend/user_data.dart';

class AdminPageUsersProvider with ChangeNotifier {

  final _collection = FirebaseFirestore.instance.collection("users");

  List<UserData> _usersData = [];
  get usersData => _usersData;

  void load() {
    _collection.get().then((snapshot) {
      _usersData = snapshot.docs.map(
        (doc) => UserData.fromJson(doc.data())).toList();
      notifyListeners();
    });
  }

}