class CourseQuestionData {
  CourseQuestionData({
    this.title = "",
    List<String>? choices,
    this.correct = -1,
  }) : choices = choices ?? [];

  String title;
  List<String> choices;
  int correct;

  Map<String, dynamic> toJson() => {
        "title": title,
        "choices": choices,
        "correct": correct,
      };

  factory CourseQuestionData.fromJson(Map<String, dynamic> map) =>
      CourseQuestionData(
        title: map["title"],
        choices: (map["choices"] as List?)?.map((e) => e.toString()).toList(),
        correct: map["correct"] ?? -1,
      );
}
