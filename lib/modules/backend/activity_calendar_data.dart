class ActivityCalendarData {
  ActivityCalendarData({
    DateTime? date,
    this.morning = "",
    this.afternoon = "",
  }) : date = date ?? DateTime.now();

  DateTime date;
  String morning;
  String afternoon;
}
