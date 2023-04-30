import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  void _load() {
    _collection.get().then((snapshot) {
      _coursesData = Map.fromIterable(
          snapshot.docs.map((doc) => CourseData.fromJson(doc.data())).toList(),
          key: (v) => (v as CourseData).id);
      if (kDebugMode) {
        print("admin_page_courses_provider -> loaded");
      }
      notifyListeners();
    });
  }

  void create() {
    final String id = RandomId.generate();
    final CourseData courseData = CourseData(id: id, title: id);
    _collection.doc(id).set(courseData.toJson()).then((_) {
      _coursesData[id] = courseData;
      if (kDebugMode) {
        print("admin_page_courses_provider -> updated");
      }
      notifyListeners();
    });
  }

  void createChapter(String courseId) {
    final String id = RandomId.generate();
    final CourseChapterData chapterData = CourseChapterData(
        id: id, title: id, number: _coursesData[courseId]!.chapters.length);
    _collection
        .doc(courseId)
        .collection("chapters")
        .doc(id)
        .set(chapterData.toJson())
        .then((_) {
      _coursesData[courseId]!.chapters[id] = chapterData;
      notifyListeners();
    });
  }

  void loadCourse(String id) {
    _collection.doc(id).collection("participants").get().then((snapshot) {
      _coursesData[id]!.participants = Map.fromIterable(
          snapshot.docs
              .map((doc) => CourseParticipantData.fromJson(doc.data()))
              .toList(),
          key: (v) => (v as CourseParticipantData).uid);
    });
    _collection.doc(id).collection("chapters").get().then((snapshot) {
      _coursesData[id]!.chapters = Map.fromIterable(
          snapshot.docs
              .map((doc) => CourseChapterData.fromJson(doc.data()))
              .toList(),
          key: (v) => (v as CourseChapterData).id);
    });
  }

  void updateCourse(String id, {Uint8List? image}) async {
    if (image != null) {
      await _storage.child(id).putData(image);
      _coursesData[id]!.imageUrl = await _storage.child(id).getDownloadURL();
    }
    await _collection.doc(id).update(coursesData[id]!.toJson());
    notifyListeners();
  }
}
