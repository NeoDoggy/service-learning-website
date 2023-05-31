import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/user/user_data.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    _authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((newUser) async {
      _user = newUser;
      await _load();
      notifyListeners();
    });
  }

  User? _user;
  UserData? _userData;
  StreamSubscription<User?>? _authSubscription;

  bool get isAuthed => _userData != null;
  // User? get user => _user;
  UserData? get userData => _userData;

  final _collection = FirebaseFirestore.instance.collection("users");

  @override
  void dispose() {
    if (_authSubscription != null) {
      _authSubscription!.cancel();
      _authSubscription = null;
    }
    super.dispose();
  }

  Future<void> _load() async {
    if (_user != null) {
      final doc = _collection.doc(_user!.uid);
      final spanshot = await doc.get();
      final data = spanshot.data();
      _userData =
          (data == null) ? UserData.fromUser(_user!) : UserData.fromJson(data);
      _userData!.combine(UserData.fromUser(_user!));
      await doc.set(_userData!.toJson());
      if (kDebugMode) {
        print("auth_provider -> loaded");
      }
    } else {
      _userData = null;
      if (kDebugMode) {
        print("auth_provider -> updated");
      }
    }
  }

  Future<void> updateUser(String uid) async {
    await _collection.doc(uid).update(_userData!.toJson());
    notifyListeners();
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
