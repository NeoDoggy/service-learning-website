import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_learning_website/modules/backend/activity/activity_calendar_data.dart';
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
    List<ActivityCalendarData>? calendar,
    List<ActivityQuestionData>? questions,
    Map<String, ActivityParticipantData>? participants,
  })  : createdTime = createdTime ?? DateTime.now(),
        // holdingTime = holdingTime ?? [],
        deadline = deadline ?? DateTime.now(),
        members = members ?? [],
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
        "calendar": [
          for (var e in calendar)
            {
              "date": e.date,
              "begin": e.begin,
              "end": e.end,
              "morning": e.morning,
              "afternoon": e.afternoon,
            },
        ],
        "questions": [
          for (var e in questions)
            {
              "title": e.title,
              "choices": e.choices,
            }
        ]
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
      calendar: (map["calendar"] as List?)
          ?.map((e) => ActivityCalendarData(
              date: (e?["date"] as Timestamp?)?.toDate(),
              begin: (e?["begin"] as Timestamp?)?.toDate(),
              end: (e?["end"] as Timestamp?)?.toDate(),
              morning: e?["morning"],
              afternoon: e?["afternoon"]))
          .toList(),
      questions: (map["questions"] as List?)
          ?.map((e) => ActivityQuestionData(
                title: e?["title"],
                choices:
                    (e?["choices"] as List?)?.map((e) => e.toString()).toList(),
              ))
          .toList());
}
