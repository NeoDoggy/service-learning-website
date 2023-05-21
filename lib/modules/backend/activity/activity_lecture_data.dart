class ActivityLectureData {
  ActivityLectureData({
    required this.id,
    this.number = 0,
    this.title = "",
    this.mdContent = "",
  });

  String id;
  int number;
  String title;
  String mdContent;

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "title": title,
    "mdContent": mdContent,
  };

  factory ActivityLectureData.fromJson(Map<String, dynamic> map) => ActivityLectureData(
    id: map["id"],
    number: map["number"],
    title: map["title"],
    mdContent: map["mdContent"],
  );
}