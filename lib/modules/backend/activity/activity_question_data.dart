import 'package:service_learning_website/modules/random_id.dart';

class ActivityQuestionData {
  ActivityQuestionData({
    String? id,
    this.title = "",
    List<String>? choices,
  })  : id = id ?? RandomId.generate(),
        choices = choices ?? [];

  String id;
  String title;

  /// 如果 [choices] 中沒有任何選項或 [choices] 為 null，
  /// 這題為問答題，否則為選擇題。
  List<String> choices;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "choices": choices,
      };

  factory ActivityQuestionData.fromJson(Map<String, dynamic> map) =>
      ActivityQuestionData(
        id: map["id"],
        title: map["title"],
        choices: (map["choices"] as List?)?.map((e) => e.toString()).toList(),
      );
}
