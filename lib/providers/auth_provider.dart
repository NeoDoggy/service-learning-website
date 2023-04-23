import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';

class AuthProvider with ChangeNotifier {

  AuthProvider() {

    _authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((newUser) {
      _user = newUser;
      _updateUser();
    });
  }

  User? _user;
  UserData? _userData;
  StreamSubscription<User?>? _authSubscription;

  bool get isAuthed => _user != null;
  User? get user => _user;
  UserData? get userData => _userData;

  @override
  void dispose() {
    if (_authSubscription != null) {
      _authSubscription!.cancel();
      _authSubscription = null;
    }
    super.dispose();
  }

  void _updateUser() {
    if (_user != null) {
      final doc =
          FirebaseFirestore.instance.collection("users").doc(_user!.uid);
      doc.get().then((value) {
        final data = value.data();
        _userData = (data == null)
            ? UserData.fromUser(_user!)
            : UserData.fromJson(data);
        _userData!.combine(UserData.fromUser(_user!));
        doc.set(_userData!.toJson());
        notifyListeners();
      });
    }
    else {
      _userData = null;
      notifyListeners();
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
