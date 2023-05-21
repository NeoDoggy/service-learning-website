import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityCalendarData {
  ActivityCalendarData({
    DateTime? date,
    DateTime? begin,
    DateTime? end,
    this.morning = "",
    this.afternoon = "",
  })  : date = date ?? DateTime.now(),
        begin = begin ?? DateTime.fromMillisecondsSinceEpoch(0),
        end = end ?? DateTime.fromMillisecondsSinceEpoch(0);

  DateTime date;
  DateTime begin;
  DateTime end;
  String morning;
  String afternoon;

  Map<String, dynamic> toJson() => {
    "date": date,
    "begin": begin,
    "end": end,
    "morning": morning,
    "afternoon": afternoon,
  };

  factory ActivityCalendarData.fromJson(Map<String, dynamic> map) => ActivityCalendarData(
    date: (map["date"] as Timestamp?)?.toDate(),
    begin: (map["begin"] as Timestamp?)?.toDate(),
    end: (map["end"] as Timestamp?)?.toDate(),
    morning: map["morning"],
    afternoon: map["afternoon"],
  );
}
