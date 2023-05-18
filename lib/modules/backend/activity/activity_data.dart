import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_learning_website/modules/backend/activity/activity_calendar_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_file_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_participant_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_question_data.dart';

class ActivityData {
  ActivityData({
    required this.id,
    DateTime? createdTime,
    this.title = "",
    this.place = "",
    this.audience = "",
    this.fee = "",
    DateTime? deadline,
    this.goal = "",
    this.description = "",
    this.imageUrl = "",
    List<String>? members,
    List<ActivityFileData>? files,
    List<ActivityCalendarData>? calendar,
    List<ActivityQuestionData>? questions,
    Map<String, ActivityParticipantData>? participants,
  })  : createdTime = createdTime ?? DateTime.now(),
        // holdingTime = holdingTime ?? [],
        deadline = deadline ?? DateTime.now(),
        members = members ?? [],
        files = files ?? [],
        calendar = calendar ?? [],
        questions = questions ?? [],
        participants = participants ?? {};

  String id;
  DateTime createdTime;
  String title;
  String place;
  String audience;
  String fee;
  DateTime deadline;
  String goal;
  String description;
  String imageUrl;
  List<String> members;
  List<ActivityFileData> files;
  List<ActivityCalendarData> calendar;
  List<ActivityQuestionData> questions;

  /// <uid, participant data>
  Map<String, ActivityParticipantData> participants;

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdTime": createdTime,
        "title": title,
        "place": place,
        "audience": audience,
        "fee": fee,
        "deadline": deadline,
        "goal": goal,
        "description": description,
        "imageUrl": imageUrl,
        "members": members,
        "files": files.map((e) => e.toJson()).toList(),
        "calendar": calendar.map((e) => e.toJson()).toList(),
        "questions": questions.map((e) => e.toJson()).toList(),
      };

  factory ActivityData.fromJson(Map<String, dynamic> map) => ActivityData(
      id: map["id"],
      createdTime: (map["createdTime"] as Timestamp?)?.toDate(),
      title: map["title"],
      place: map["place"],
      audience: map["audience"],
      fee: map["fee"],
      deadline: (map["deadline"] as Timestamp?)?.toDate(),
      goal: map["goal"],
      description: map["description"],
      imageUrl: map["imageUrl"],
      members: (map["members"] as List?)?.map((e) => e.toString()).toList(),
      files: (map["files"] as List?)
          ?.map((e) => ActivityFileData.fromJson(e))
          .toList(),
      calendar: (map["calendar"] as List?)
          ?.map((e) => ActivityCalendarData.fromJson(e))
          .toList(),
      questions: (map["questions"] as List?)
          ?.map((e) => ActivityQuestionData.fromJson(e))
          .toList());
}
