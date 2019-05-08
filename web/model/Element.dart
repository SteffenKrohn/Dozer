import 'dart:html' as html;

abstract class Element {

  int id;

  /** The current movement of the element for the next view update */
  int dx = 0;
  int dy = 0;

  int x = 0;
  int y = 0;

  int width = 0;
  int height = 0;

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

  String toString();

  /**
   * Called when Element e collides with this element
   */
  void hitBy(Element e) {
    //TODO
  }
}