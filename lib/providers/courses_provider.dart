import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
    String id = RandomId.generate();
    CourseData courseData = CourseData(id: id, title: id);
    _collection.doc(id).set(courseData.toJson()).then((_) {
      _coursesData[id] = courseData;
      if (kDebugMode) {
        print("admin_page_courses_provider -> updated");
      }
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
    // _storage
    //     .child("$id.jpg")
    //     .getDownloadURL()
    //     .then((url) => _coursesData[id]!.imageUrl = url)
    //     .catchError((_) => _coursesData[id]!.imageUrl = "");
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
