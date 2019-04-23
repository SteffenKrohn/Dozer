import 'dart:html';

import 'Element.dart' as elem;

class Dot extends elem.Element {

  int value;


  Dot(String id, int x, int y, int height, int width, int value) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.height = height;
    this.width = width;
    this.value = value;
  }

  //wird bei Dot nicht gebraucht
  /*void update() {
    super.update();
    querySelector('#'+this.id).text = this.value.toString();
  }*/

  String toString() {
    return "<div class='element dot' id=${this.id}> ${this.value.toString()} </div>";
  }
}