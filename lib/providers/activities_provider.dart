import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/activity/activity_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_file_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_lecture_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_participant_data.dart';
import 'package:service_learning_website/modules/random_id.dart';

class ActivitiesProvider with ChangeNotifier {
  ActivitiesProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("activities");
  final _imgStorage = FirebaseStorage.instance.ref("images/activities");
  final _fileStorage = FirebaseStorage.instance.ref("files/activities");

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

  Future<void> updateActivity(String activityId, {Uint8List? image}) async {
    if (image != null) {
      await _imgStorage.child("$activityId/preview").putData(image);
      _activitiesData[activityId]!.imageUrl =
          await _imgStorage.child("$activityId/preview").getDownloadURL();
    }
    await _collection
        .doc(activityId)
        .set(_activitiesData[activityId]!.toJson());
    notifyListeners();
  }

  Future<void> loadActivity(String activityId) async {
    final pSnapshot =
        await _collection.doc(activityId).collection("participants").get();
    final fSnapshot =
        await _collection.doc(activityId).collection("files").get();
    final iSnapshot =
        await _collection.doc(activityId).collection("photos").get();
    final lSnapshot =
        await _collection.doc(activityId).collection("lectures").get();
    _activitiesData[activityId]!.participants = Map.fromIterable(
        pSnapshot.docs
            .map((doc) => ActivityParticipantData.fromJson(doc.data())),
        key: (v) => (v as ActivityParticipantData).uid);
    _activitiesData[activityId]!.files = Map.fromIterable(
        fSnapshot.docs.map((doc) => ActivityFileData.fromJson(doc.data())),
        key: (v) => (v as ActivityFileData).id);
    _activitiesData[activityId]!.photos = Map.fromIterable(
        iSnapshot.docs.map((doc) => ActivityFileData.fromJson(doc.data())),
        key: (v) => (v as ActivityFileData).id);
    _activitiesData[activityId]!.lectures = Map.fromIterable(
        lSnapshot.docs.map((doc) => ActivityLectureData.fromJson(doc.data())),
        key: (v) => (v as ActivityLectureData).id);
    notifyListeners();
  }

  Future<void> addParticipant(String activityId, String uid) async {
    await _collection
        .doc(activityId)
        .collection("participants")
        .doc(uid)
        .set(_activitiesData[activityId]!.participants[uid]!.toJson());
    notifyListeners();
  }

  Future<void> uploadFile(
      String activityId, String filename, Uint8List file) async {
    final fileId = RandomId.generate();
    final fileRef = _fileStorage.child("$activityId/$fileId");
    await fileRef.putData(file);
    final fileUrl = await fileRef.getDownloadURL();
    _activitiesData[activityId]!.files[fileId] =
        (ActivityFileData(id: fileId, filename: filename, url: fileUrl));
    await _collection
        .doc(activityId)
        .collection("files")
        .doc(fileId)
        .set(_activitiesData[activityId]!.files[fileId]!.toJson());
    notifyListeners();
  }

  Future<void> updateFile(String activityId, String fileId) async {
    await _collection
        .doc(activityId)
        .collection("files")
        .doc(fileId)
        .update(_activitiesData[activityId]!.files[fileId]!.toJson());
    notifyListeners();
  }

  Future<void> deleteFile(String activityId, String fileId) async {
    _activitiesData[activityId]!.files.remove(fileId);
    await _fileStorage.child("$activityId/$fileId").delete();
    await _collection.doc(activityId).collection("files").doc(fileId).delete();
    notifyListeners();
  }

  Future<String> uploadPhoto(
      String activityId, String filename, Uint8List file) async {
    final fileId = RandomId.generate();
    final fileRef = _imgStorage.child("$activityId/$fileId");
    await fileRef.putData(file);
    final fileUrl = await fileRef.getDownloadURL();
    _activitiesData[activityId]!.photos[fileId] =
        (ActivityFileData(id: fileId, filename: filename, url: fileUrl));
    await _collection
        .doc(activityId)
        .collection("photos")
        .doc(fileId)
        .set(_activitiesData[activityId]!.photos[fileId]!.toJson());
    notifyListeners();
    return fileId;
  }

  Future<void> updatePhoto(String activityId, String fileId) async {
    await _collection
        .doc(activityId)
        .collection("photos")
        .doc(fileId)
        .update(_activitiesData[activityId]!.photos[fileId]!.toJson());
    notifyListeners();
  }

  Future<void> deletePhoto(String activityId, String fileId) async {
    _activitiesData[activityId]!.photos.remove(fileId);
    await _imgStorage.child("$activityId/$fileId").delete();
    await _collection.doc(activityId).collection("photos").doc(fileId).delete();
    notifyListeners();
  }

  Future<void> createLecture(String activityId) async {
    final String id = RandomId.generate();
    final lectureData = ActivityLectureData(
        id: id, title: id, number: _activitiesData[activityId]!.lectures.length);
    await _collection
        .doc(activityId)
        .collection("lectures")
        .doc(id)
        .set(lectureData.toJson());
    _activitiesData[activityId]!.lectures[id] = lectureData;
    notifyListeners();
  }

  Future<void> deleteLecture(String activityId, String lectureId) async {
    await _collection
        .doc(activityId)
        .collection("lectures")
        .doc(lectureId)
        .delete();
    _activitiesData[activityId]!.lectures.remove(lectureId);
    notifyListeners();
  }

  Future<void> updateLecture(String courseId, String chapterId) async {
    await _collection
        .doc(courseId)
        .collection("lectures")
        .doc(chapterId)
        .update(_activitiesData[courseId]!.lectures[chapterId]!.toJson());
    notifyListeners();
  }
}
