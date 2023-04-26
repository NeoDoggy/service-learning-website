import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
import 'package:service_learning_website/modules/random_id.dart';

class AdminPageCoursesProvider with ChangeNotifier {

  AdminPageCoursesProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("courses");

  List<CourseData> _coursesData = [];
  List<CourseData> get coursesData => _coursesData;


  void _load() {
    _collection.get().then((snapshot) {
      _coursesData = snapshot.docs.map(
        (doc) => CourseData.fromJson(doc.data())).toList();
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
      _coursesData.add(courseData);
      if (kDebugMode) {
        print("admin_page_courses_provider -> updated");
      }
      notifyListeners();
    });
  }
}