import 'package:service_learning_website/modules/backend/course/course_question_data.dart';

class CourseChapterData {
  CourseChapterData({
    required this.id,
    this.number = 0,
    this.title = "",
    this.mdContent = "",
    this.videoUrl = "",
    List<CourseQuestionData>? questions,
  }) : questions = questions ?? [];

  String id;
  int number;
  String title;
  String mdContent;
  String videoUrl;
  List<CourseQuestionData> questions;

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "title": title,
        "mdContent": mdContent,
        "videoUrl": videoUrl,
        "questions": questions.map((e) => e.toJson()).toList(),
      };

  factory CourseChapterData.fromJson(Map<String, dynamic> map) =>
      CourseChapterData(
        id: map["id"],
        number: map["number"],
        title: map["title"],
        mdContent: map["mdContent"],
        videoUrl: map["videoUrl"],
        questions: (map["questions"] as List?)
            ?.map((e) => CourseQuestionData.fromJson(e))
            .toList(),
      );
}
