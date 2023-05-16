import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleData {
  ArticleData({
    required this.id,
    this.title = "",
    this.introduction = "",
    this.mdContent = "",
    this.imageUrl = "",
    DateTime? createdTime,
    List<String>? tags,
    this.authorUid = "",
    this.authorName = "",
  })  : createdTime = createdTime ?? DateTime.now(),
        tags = tags ?? [];

  String id;
  String title;
  String introduction;
  String mdContent;
  String imageUrl;
  DateTime createdTime;
  List<String> tags;
  String authorUid;
  String authorName;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "introduction": introduction,
        "mdContent": mdContent,
        "imageUrl": imageUrl,
        "createdTime": createdTime,
        "tags": tags,
        "authorUid": authorUid,
        "authorName": authorName,
      };

  factory ArticleData.fromJson(Map<String, dynamic> map) => ArticleData(
        id: map["id"],
        title: map["title"],
        introduction: map["introduction"],
        mdContent: map["mdContent"],
        imageUrl: map["imageUrl"],
        createdTime: (map["createdTime"] as Timestamp?)?.toDate(),
        tags: (map["tags"] as List?)?.map((e) => e.toString()).toList(),
        authorUid: map["authorUid"],
        authorName: map["authorName"],
      );
}
