import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_learning_website/modules/backend/course_participant_data.dart';

class CourseData {
  CourseData({
    required this.id,
    this.title = "",
    DateTime? createdTime,
    this.description = "",
    this.audience = "",
    this.environment = "",
    this.members = const [],
    this.imageUrl = "",
    this.outline = "",
    this.participants = const {},
  }) : createdTime = createdTime ?? DateTime.now();

  String id;
  String title;
  DateTime createdTime;
  String description;
  String audience;
  String environment;

  /// Members' uid
  List<String> members;

  /// Firebase Storage file referace path
  String imageUrl;

  /// With MarkDown format
  String outline;

  /// <uid, participants data>
  Map<String, CourseParticipantData> participants;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createdTime": Timestamp.fromDate(createdTime),
        "description": description,
        "audience": audience,
        "environment": environment,
        "members": members,
        "imageUrl": imageUrl,
        "outline": outline,
      };

  factory CourseData.empty() => CourseData(id: "");

  factory CourseData.fromJson(Map<String, dynamic> map) => CourseData(
        id: map["id"],
        title: map["title"],
        createdTime: (map["createdTime"] as Timestamp).toDate(),
        description: map["description"],
        audience: map["audience"],
        environment: map["environment"],
        members: (map["members"] as List).map((e) => e.toString()).toList(),
        imageUrl: map["imageUrl"],
        outline: map["outline"],
      );
}
