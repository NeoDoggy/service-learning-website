import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_learning_website/modules/backend/activity/grade.dart';
import 'package:service_learning_website/modules/backend/activity/meal_type.dart';

class ActivityParticipantData {
  ActivityParticipantData({
    required this.uid,
    this.name = "",
    this.email = "",
    this.school = "",
    this.grade = Grade.other,
    this.mealType = MealType.none,
    this.maelRemark = "",
    this.parentPhone = "",
    DateTime? registrationTime,
    this.registrated = 0,
    Map<String, String>? additional,
  })  : registrationTime = registrationTime ?? DateTime.now(),
        additional = additional ?? {} {
    parentPhone = parentPhone.replaceAll(RegExp(r"[^0-9]"), "");
  }

  String uid;
  String name;
  String email;
  String school;
  Grade grade;
  MealType mealType;
  String maelRemark;
  String parentPhone;
  DateTime registrationTime;

  /// 0：未處理、
  /// 正數：序號、
  /// 負數：候補序位，-1 較 -2 優先
  int registrated;

  /// <question id, response>
  Map<String, String> additional;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "school": school,
        "grade": grade.id,
        "mealType": mealType.id,
        "maelRemark": maelRemark,
        "parentPhone": parentPhone,
        "registrationTime": registrationTime,
        "registrated": registrated,
        "additional": additional,
      };

  factory ActivityParticipantData.fromJson(Map<String, dynamic> map) =>
      ActivityParticipantData(
        uid: map["uid"],
        name: map["name"],
        email: map["email"],
        school: map["school"],
        grade: Grade.fromId(map["grade"]),
        mealType: MealType.fromId(map["mealType"]),
        maelRemark: map["maelRemark"],
        parentPhone: map["parentPhone"],
        registrationTime: (map["registrationTime"] as Timestamp?)?.toDate(),
        registrated: map["registrated"],
        additional: (map["additional"] as LinkedHashMap?)
            ?.map((key, value) => MapEntry(key, value.toString())),
      );
}
