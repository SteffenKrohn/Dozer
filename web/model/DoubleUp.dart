
import 'Element.dart';
import 'PowerUp.dart';

class DoubleUp extends PowerUp {

  DoubleUp(int id) {
    this.id = id;
  }

  @override
  void hitBy(Element e) {
    // TODO: implement hitBy
  }

  String toString() {
    return "doubleup";
  }
}