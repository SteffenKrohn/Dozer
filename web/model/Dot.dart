import 'Dozer.dart';
import 'Element.dart' as elem;

class Dot extends elem.Element {

  int value;

  Dot(int id, int x, int y, int value, int width, int height) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
    this.width = width;
    this.height = height;
  }

  String toString() {
    return "dot";
  }

  @override
  void hitBy(elem.Element e) {
    if (e is Dozer) {
      this.value = 0;
    }
  }

  static double getStandardRadius() {
    return 0.05;
  }
}