import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/course_chapter_data.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
import 'package:service_learning_website/modules/backend/course_participant_data.dart';
import 'package:service_learning_website/modules/random_id.dart';

class CoursesProvider with ChangeNotifier {
  CoursesProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("courses");
  final _storage = FirebaseStorage.instance.ref("images/courses");

  Map<String, CourseData> _coursesData = {};
  Map<String, CourseData> get coursesData => _coursesData;

  Future<void> _load() async {
    final snapshot = await _collection.get();
    _coursesData = Map.fromIterable(
        snapshot.docs.map((doc) => CourseData.fromJson(doc.data())),
        key: (v) => (v as CourseData).id);
    if (kDebugMode) {
      print("courses_provider -> loaded");
    }
    notifyListeners();
  }

  Future<void> createCourse() async {
    final String id = RandomId.generate();
    final CourseData courseData = CourseData(id: id, title: id);
    await _collection.doc(id).set(courseData.toJson());
    _coursesData[id] = courseData;
    if (kDebugMode) {
      print("courses_provider -> updated");
    }
    notifyListeners();
  }

  Future<void> createChapter(String courseId) async {
    final String id = RandomId.generate();
    final CourseChapterData chapterData = CourseChapterData(
        id: id, title: id, number: _coursesData[courseId]!.chapters.length);
    await _collection
        .doc(courseId)
        .collection("chapters")
        .doc(id)
        .set(chapterData.toJson());
    _coursesData[courseId]!.chapters[id] = chapterData;
    notifyListeners();
  }

  Future<void> deleteChapter(String courseId, String chapterId) async {
    await _collection
        .doc(courseId)
        .collection("chapters")
        .doc(chapterId)
        .delete();
    _coursesData[courseId]!.chapters.remove(chapterId);
    notifyListeners();
  }

  Future<void> loadCourse(String courseId) async {
    final pSnapshot =
        await _collection.doc(courseId).collection("participants").get();
    final cSnapshot =
        await _collection.doc(courseId).collection("chapters").get();

    _coursesData[courseId]!.participants = Map.fromIterable(
        pSnapshot.docs.map((doc) => CourseParticipantData.fromJson(doc.data())),
        key: (v) => (v as CourseParticipantData).uid);
    _coursesData[courseId]!.chapters = Map.fromIterable(
        cSnapshot.docs.map((doc) => CourseChapterData.fromJson(doc.data())),
        key: (v) => (v as CourseChapterData).id);

    notifyListeners();
  }

  Future<void> updateCourse(String courseId, {Uint8List? image}) async {
    if (image != null) {
      await _storage.child(courseId).putData(image);
      _coursesData[courseId]!.imageUrl =
          await _storage.child(courseId).getDownloadURL();
    }
    await _collection.doc(courseId).update(_coursesData[courseId]!.toJson());
    notifyListeners();
  }

  Future<void> addParticipant(String courseId, String uid) async {
    _coursesData[courseId]!.participants[uid] = CourseParticipantData(uid: uid);
    await _collection
        .doc(courseId)
        .collection("participants")
        .doc(uid)
        .set(_coursesData[courseId]!.participants[uid]!.toJson());
    notifyListeners();
  }

  Future<void> updateChapter(String courseId, String chapterId) async {
    await _collection
        .doc(courseId)
        .collection("chapters")
        .doc(chapterId)
        .update(_coursesData[courseId]!.chapters[chapterId]!.toJson());
    notifyListeners();
  }
}
