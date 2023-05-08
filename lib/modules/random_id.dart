import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RandomId {
  static String generate() {
    return FirebaseFirestore.instance.collection("tmp").doc().id;
  }
}