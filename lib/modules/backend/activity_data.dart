import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_learning_website/modules/backend/activity_calendar_data.dart';
import 'package:service_learning_website/modules/backend/activity_participant_data.dart';
import 'package:service_learning_website/modules/pair.dart';

class ActivityData {
  ActivityData({
    required this.id,
    DateTime? createdTime,
    this.title = "",
    List<Pair<DateTime, DateTime>>? holdingTime,
    this.place = "",
    this.audience = "",
    this.fee = "",
    DateTime? deadline,
    this.goal = "",
    this.description = "",
    this.imageUrl = "",
    List<String>? members,
    List<ActivityCalendarData>? calendar,
    Map<String, ActivityParticipantData>? participants,
  })  : createdTime = createdTime ?? DateTime.now(),
        holdingTime = holdingTime ?? [],
        deadline = deadline ?? DateTime.now(),
        members = members ?? [],
        calendar = calendar ?? [],
        participants = participants ?? {};

  String id;
  DateTime createdTime;
  String title;
  List<Pair<DateTime, DateTime>> holdingTime;
  String place;
  String audience;
  String fee;
  DateTime deadline;
  String goal;
  String description;
  String imageUrl;
  List<String> members;
  List<ActivityCalendarData> calendar;

  /// <uid, participant data>
  Map<String, ActivityParticipantData> participants;

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdTime": createdTime,
        "title": title,
        "holdingTime": [
          for (var range in holdingTime)
            {
              "begin": range.first,
              "end": range.second,
            }
        ],
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
              "morning": e.morning,
              "afternoon": e.afternoon,
            },
        ],
      };

  factory ActivityData.fromJson(Map<String, dynamic> map) => ActivityData(
        id: map["id"],
        createdTime: (map["createdTime"] as Timestamp?)?.toDate(),
        title: map["title"],
        holdingTime: (map["holdingTime"] as List?)?.map((e) {
          return Pair(
            (e?["begin"] as Timestamp?)?.toDate() ?? DateTime.now(),
            (e?["end"] as Timestamp?)?.toDate() ?? DateTime.now(),
          );
        }).toList(),
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
                morning: e?["morning"],
                afternoon: e?["afternoon"]))
            .toList(),
      );
}
