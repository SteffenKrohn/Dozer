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

    dx = this.dx;
    // Left border
    if (querySelector("#dozer").getBoundingClientRect().left + dx < 0) {
      dx = querySelector("#dozer").getBoundingClientRect().left * -1;
    }
    if (this.x + dx + this.width > querySelector("#field").getBoundingClientRect().right) {
      dx = querySelector("#field").getBoundingClientRect().right - querySelector("#dozer").getBoundingClientRect().right;
    }
    this.x += dx;
  }

  //TODO
  String toString() {
    return "<div class='element dozer' id=${this.id}> ${this.value.toString()} </div>";
  }
}