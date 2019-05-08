import 'Element.dart' as elem;

class Dot extends elem.Element {

  int value;

  Dot(int id, int x, int value) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
  }

  String toString() {
    return "<div class='element dot' id=${this.id}> ${this.value.toString()} </div>";
  }

  @override
  void hitBy(elem.Element e) {
    // TODO: implement hitBy
  }
}