enum MealType {
  none(0),
  meat(1),
  vegetarian(2);

  const MealType(this.id);
  final int id;

  String get name {
    switch (id) {
      case 1:
        return "葷";
      case 2:
        return "素";
      case 0:
      default:
        return "自行準備";
    }
  }

  factory MealType.fromId(int? id)
    => values.firstWhere((element) => element.id == (id ?? 0));
}