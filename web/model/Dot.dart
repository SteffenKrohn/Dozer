import 'Dozer.dart';
import 'Element.dart' as elem;

class Dot extends elem.Element {

  int value;

  Dot(int id, int x, int value) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
    this.width = 50;
    this.height = 50;
  }

  String toString() {
    return this.value.toString();
  }

  @override
  void hitBy(elem.Element e) {
    if (e is Dozer) {
      this.value = 0;
    }
  }
}