class ActivityLectureData {
  ActivityLectureData({
    required this.id,
    this.title = "",
    this.mdContent = "",
  });

  String id;
  String title;
  String mdContent;

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "mdContent": mdContent,
  };

  factory ActivityLectureData.fromJson(Map<String, dynamic> map) => ActivityLectureData(
    id: map["id"],
    title: map["title"],
    mdContent: map["mdContent"],
  );
}