enum Grade {
  e1(1),
  e2(2),
  e3(3),
  e4(4),
  e5(5),
  e6(6),
  j7(7),
  j8(8),
  j9(9),
  s1(10),
  s2(11),
  s3(12),
  other(0);

  const Grade(this.id);
  final int id;

  String get name {
    switch (id) {
      case 1:
        return "小一";
      case 2:
        return "小二";
      case 3:
        return "小三";
      case 4:
        return "小四";
      case 5:
        return "小五";
      case 6:
        return "小六";
      case 7:
        return "國七";
      case 8:
        return "國八";
      case 9:
        return "國九";
      case 10:
        return "高一";
      case 11:
        return "高二";
      case 12:
        return "高三";
      case 0:
      default:
        return "大學以上";
    }
  }

  factory Grade.fromId(int id) =>
      values.firstWhere((element) => element.id == id);
}
