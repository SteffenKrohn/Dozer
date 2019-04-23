import 'dart:html';

import 'Element.dart' as elem;

class Dozer extends elem.Element {

  int value;
  int dx = 0;


  Dozer(String id, int x, int y, int height, int width, int value) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.height = height;
    this.width = width;
    this.value = value;
  }

  void setDerivation(int dx) {
    this.dx = dx;
  }

  void update() {
    super.update();
    querySelector('#'+this.id).text = this.value.toString();
    this.x += this.dx;
  }

  //TODO
  String toString() {
    return "<div class='element dozer' id=${this.id}> ${this.value.toString()} </div>";
  }
}