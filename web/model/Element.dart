import 'dart:html' as html;

import '../widgets/Hitbox.dart';

abstract class Element extends HitBox {

  // TODO should all be private, but results in many getters and setter.
  String id;
  html.Element _view;

  /** The current movement of the element for the next view update */
  int dx = 0;
  int dy = 0;

  int x = 0;
  int y = 0;

  void move(int dx, int dy) {
    this.dx = dx;
    this.dy = dy;
  }

  void update() {
    this.x += this.dx;
    this.y += this.dy;
    this._view.style.left = "${this.x}px";
    this._view.style.top = "${this.y}px";
  }

  html.Element getView() {
    return this._view;
  }

  void created() {
    this._view = html.querySelector("#" + this.id);
  }

  String toString();
}