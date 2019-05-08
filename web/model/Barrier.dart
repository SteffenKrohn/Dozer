import 'Element.dart';

class Barrier extends Element {

  int height;

  Barrier(int id, int x, int height) {
    this.id = id;
    this. x = x;
    this.height = height;
  }

  String toString() {
    return "<div class='element barrier' id=${this.id}></div>";
  }

  @override
  void hitBy(Element e) {
    // TODO: implement hitBy
  }
}