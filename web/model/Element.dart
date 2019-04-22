
import 'dart:html';

import '../widgets/Hitbox.dart';

abstract class Element extends HitBox {

  String id;

  int x;
  int y;

  int height;
  int width;

  void move(int dx, int dy) {
    this.x += dx;
    this.y += dy;
  }

  void update() {
    querySelector('#'+this.id).style.width = "${this.width}px";
    querySelector('#'+this.id).style.height = "${this.height}px";
    querySelector('#'+this.id).style.top = "${this.y}px";
    querySelector('#'+this.id).style.left = "${this.x}px";
  }

  String toString();
}