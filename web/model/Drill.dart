import 'Element.dart';
import 'PowerUp.dart';

class Drill extends PowerUp {

  Drill(int id) {
      this.id = id;
  }

  @override
  void hitBy(Element e) {
    // TODO: implement hitBy
  }

  String toString() {
    return "drill";
  }
}