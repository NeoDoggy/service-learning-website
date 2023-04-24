class CourseParticipantData {
  
  CourseParticipantData({
    required this.uid,
  });

  String uid;

  Map<String, dynamic> toJson() => {
    "uid": uid,
  };

  factory CourseParticipantData.fromJson(Map<String, dynamic> map) => CourseParticipantData(
    uid: map["uid"],
  );

}