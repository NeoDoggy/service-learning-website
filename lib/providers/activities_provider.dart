import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/activity_data.dart';
import 'package:service_learning_website/modules/random_id.dart';

class ActivitiesProvider with ChangeNotifier {
  ActivitiesProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("activities");
  final _storage = FirebaseStorage.instance.ref("images/activities");

  Map<String, ActivityData> _activitiesData = {};
  Map<String, ActivityData> get activitiesData => _activitiesData;

  Future<void> _load() async {
    final snapshot = await _collection.get();
    _activitiesData = Map.fromIterable(
        snapshot.docs.map((doc) => ActivityData.fromJson(doc.data())),
        key: (v) => (v as ActivityData).id);
    if (kDebugMode) {
      print("activities_provider -> loaded");
    }
    notifyListeners();
  }

  Future<void> createActivity() async {
    final String id = RandomId.generate();
    final ActivityData activityData = ActivityData(id: id, title: id);
    await _collection.doc(id).set(activityData.toJson());
    _activitiesData[id] = activityData;
    if (kDebugMode) {
      print("activities_provider -> updated");
    }
    notifyListeners();
  }

  Future<void> updateActivity(String activityId) async {
    await _collection
        .doc(activityId)
        .set(_activitiesData[activityId]!.toJson());
    notifyListeners();
  }
}
