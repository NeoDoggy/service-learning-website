abstract class Swapable {
  static void swapList(List<dynamic> list, int i, int j) {
    var tmp = list[i];
    list[i] = list[j];
    list[j] = tmp;
  }
}
