import 'dart:collection';

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
    this.registrated = false,
    Map<String, String>? additional,
  }) : additional = additional ?? {} {
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
  bool registrated;

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
        registrated: map["registrated"],
        additional: (map["additional"] as LinkedHashMap?)
            ?.map((key, value) => MapEntry(key, value.toString())),
      );
}
