class ActivityCalendarData {
  ActivityCalendarData({
    DateTime? date,
    DateTime? begin,
    DateTime? end,
    this.morning = "",
    this.afternoon = "",
  })  : date = date ?? DateTime.now(),
        begin = begin ?? DateTime.fromMillisecondsSinceEpoch(0),
        end = end ?? DateTime.fromMillisecondsSinceEpoch(0);

  DateTime date;
  DateTime begin;
  DateTime end;
  String morning;
  String afternoon;
}
