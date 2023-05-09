import 'package:service_learning_website/modules/backend/meal_type.dart';

class ActivityParticipantData {
  ActivityParticipantData({
    required this.uid,
    this.name = "",
    this.school = "",
    this.grade = "",
    this.mealType = MealType.none,
    this.maelRemark = "",
    this.parentPhone = "",
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
}
