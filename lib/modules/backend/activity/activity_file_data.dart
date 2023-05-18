import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityFileData {
  ActivityFileData({
    required this.id,
    this.filename = "",
    this.url = "",
    DateTime? uploadedTime,
  }) : uploadedTime = uploadedTime ?? DateTime.now();

  String id;
  String filename;
  String url;
  DateTime uploadedTime;

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "url": url,
    "uploadedTime": uploadedTime,
  };

  factory ActivityFileData.fromJson(Map<String, dynamic> map) => ActivityFileData(
    id: map["id"],
    filename: map["filename"],
    url: map["url"],
    uploadedTime: (map["uploadedTime"] as Timestamp?)?.toDate(),
  );
}