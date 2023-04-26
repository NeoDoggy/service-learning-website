import 'package:service_learning_website/modules/backend/course_participant_data.dart';

class CourseData {
  CourseData({
    required this.id,
    this.title = "",
    this.semester = "",
    this.description = "",
    this.audience = "",
    this.environment = "",
    this.leader = "",
    this.members = const [],
    this.imageRef = "",
    this.outline = "",
    this.participants = const [],
  });

  String id;
  String title;
  String semester;
  String description;
  String audience;
  String environment;

  /// Leader's uid
  String leader;

  /// Members' uid
  List<String> members;

  /// Firebase Storage file referace path
  String imageRef;

  /// With MarkDown format
  String outline;

  List<CourseParticipantData> participants;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "semester": semester,
        "description": description,
        "audience": audience,
        "environment": environment,
        "leader": leader,
        "members": members,
        "imageRef": imageRef,
        "outline": outline,
      };

  factory CourseData.empty() => CourseData(id: "");

  factory CourseData.fromJson(Map<String, dynamic> map) => CourseData(
        id: map["id"],
        title: map["title"] ?? "",
        semester: map["semester"] ?? "",
        description: map["description"] ?? "",
        audience: map["audience"] ?? "",
        environment: map["environment"] ?? "",
        leader: map["leader"] ?? "",
        members: (map["members"] != null)
            ? (map["members"] as List).map((e) => e.toString()).toList()
            : <String>[],
        imageRef: map["imageRef"] ?? "",
        outline: map["outline"] ?? "",
      );
}
