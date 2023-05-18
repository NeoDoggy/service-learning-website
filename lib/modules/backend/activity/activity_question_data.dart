class ActivityQuestionData {
  ActivityQuestionData({
    this.title = "",
    List<String>? choices,
  }) : choices = choices ?? [];

  String title;

  /// 如果 [choices] 中沒有任何選項或 [choices] 為 null，
  /// 這題為問答題，否則為選擇題。
  List<String> choices;

  Map<String, dynamic> toJson() => {
        "title": title,
        "choices": choices,
      };

  factory ActivityQuestionData.fromJson(Map<String, dynamic> map) =>
      ActivityQuestionData(
        title: map["title"],
        choices: (map["choices"] as List?)?.map((e) => e.toString()).toList(),
      );
}
