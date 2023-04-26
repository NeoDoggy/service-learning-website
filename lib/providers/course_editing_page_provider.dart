import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
import 'package:service_learning_website/modules/backend/course_participant_data.dart';

class CourseEditingPageProvider with ChangeNotifier {
  final _collection = FirebaseFirestore.instance.collection("courses");

  CourseData _courseData = CourseData.empty();
  CourseData get courseData => _courseData;

  void loadCourse(String id) {
    _collection.doc(id).get().then((doc) {
      _courseData = CourseData.fromJson(doc.data()!);
      _collection.doc(id).collection("participants").get().then((snapshot) {
        _courseData.participants = snapshot.docs
            .map((doc) => CourseParticipantData.fromJson(doc.data()))
            .toList();
        if (kDebugMode) {
          print("course_editing_page_provider -> loaded");
        }
        notifyListeners();
      });
    });
  }

  Future<String?> getUidFromStudentId(int studentId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("studentId", isEqualTo: studentId)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs.first.data()["uid"];
  }
}
