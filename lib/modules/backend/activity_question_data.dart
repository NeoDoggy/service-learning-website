class ActivityQuestionData {
  ActivityQuestionData({
    required this.id,
    this.number = 0,
    this.title = "",
    List<String>? choices,
  }) : choices = choices ?? [];

  String id;
  int number = 0;
  String title;

  /// 如果 [choices] 中沒有任何選項或 [choices] 為 null，
  /// 這題為問答題，否則為選擇題。
  List<String> choices;
}
