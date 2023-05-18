class CourseChapterData {
  
  CourseChapterData({
    required this.id,
    this.number = 0,
    this.title = "",
    this.mdContent = "",
    this.videoUrl = "",
  });

  String id;
  int number;
  String title;
  String mdContent;
  String videoUrl;

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "title": title,
    "mdContent": mdContent,
    "videoUrl": videoUrl,
  };

  factory CourseChapterData.fromJson(Map<String, dynamic> map) => CourseChapterData(
    id: map["id"],
    number: map["number"],
    title: map["title"],
    mdContent: map["mdContent"],
    videoUrl: map["videoUrl"],
  );
}