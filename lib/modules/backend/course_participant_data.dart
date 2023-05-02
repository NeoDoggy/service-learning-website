class CourseParticipantData {
  CourseParticipantData({
    required this.uid,
    List<String>? completed,
  }) : completed = completed ?? [];

  String uid;
  List<String> completed;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "completed": completed,
      };

  factory CourseParticipantData.fromJson(Map<String, dynamic> map) =>
      CourseParticipantData(
        uid: map["uid"],
        completed: (map["completed"] as List).map((e) => e.toString()).toList(),
      );
}
