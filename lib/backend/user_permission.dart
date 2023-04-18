enum UserPermission {
  none(0),
  normal(10),
  student(20),
  ta(30);

  const UserPermission(this.id);
  final int id;

  factory UserPermission.fromId(int id)
    => values.firstWhere((element) => element.id == id);

  bool operator<(UserPermission other) => id < other.id;
  bool operator>(UserPermission other) => id > other.id;
}