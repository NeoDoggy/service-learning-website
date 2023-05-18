import 'package:service_learning_website/modules/backend/activity/meal_type.dart';

class ActivityParticipantData {
  ActivityParticipantData({
    required this.uid,
    this.name = "",
    this.school = "",
    this.grade = "",
    this.mealType = MealType.none,
    this.maelRemark = "",
    this.parentPhone = "",
    this.registrated = false,
  }) {
    parentPhone = parentPhone.replaceAll(RegExp(r"[^0-9]"), "");
  }

  String uid;
  String name;
  String school;
  String grade;
  MealType mealType;
  String maelRemark;
  String parentPhone;
  bool registrated;

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "school": school,
    "grade": grade,
    "mealType": mealType,
    "maelRemark": maelRemark,
    "parentPhone": parentPhone,
    "registrated": registrated,
  };

  factory ActivityParticipantData.fromJson(Map<String, dynamic> map) => ActivityParticipantData(
    uid: map["uid"],
    name: map["name"],
    school: map["school"],
    grade: map["grade"],
    mealType: MealType.fromId(map["mealType"]),
    maelRemark: map["maelRemark"],
    parentPhone: map["parentPhone"],
    registrated: map["registrated"],
  );
}
