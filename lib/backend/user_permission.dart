enum UserPermission {
  none(0),
  normal(10),
  student(20),
  ta(30);

  const UserPermission(this.id);
  final int id;

  String get name {
    switch (id) {
      case 10:
        return "一般";
      case 20:
        return "學生";
      case 30:
        return "助教";
      default:
        return "無";
    }
  }

  factory UserPermission.fromId(int id)
    => values.firstWhere((element) => element.id == id);

  bool operator<(UserPermission other) => id < other.id;
  bool operator>(UserPermission other) => id > other.id;
}