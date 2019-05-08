import 'dart:html';
import 'dart:math';

import '../model/Element.dart' as m;

class CollisionChecker {

  /**
   * Checks if two elements with rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool rectangles(m.Element a, m.Element b) {
    // TODO make pretty
    var av = querySelector("#e"+a.id.toString());
    var bv = querySelector("#e"+b.id.toString());

    int aTop = av.getBoundingClientRect().top.toInt();
    int aLeft = av.getBoundingClientRect().left.toInt();
    int aBot = av.getBoundingClientRect().bottom.toInt();
    int aRight = av.getBoundingClientRect().right.toInt();

    int bTop = bv.getBoundingClientRect().top.toInt();
    int bLeft = bv.getBoundingClientRect().left.toInt();
    int bBot = bv.getBoundingClientRect().bottom.toInt();
    int bRight = bv.getBoundingClientRect().right.toInt();

    bool v = false;
    bool h = false;
    if (aTop >= bTop && aTop <= bBot) {
      v = true;
    }
    if (aBot >= bTop && aBot <= bBot) {
      v = true;
    }
    if (aLeft >= bLeft && aLeft <= bRight) {
      h = true;
    }
    if (aRight >= bLeft && aRight <= bRight) {
      h = true;
    }
    return v;
  }

  /**
   * Checks if two elements with circle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool circles(m.Element a, m.Element b) {
    int x1, x2, y1, y2;
    x1 = (a.x + (a.width / 2)) as int;
    x2 = (b.x + (b.width / 2)) as int;
    y1 = (a.y + (a.height / 2)) as int;
    y2 = (b.y + (b.height / 2)) as int;

    if (y1 > y2) {
      int tmp = y1;
      y1 = y2;
      y2 = tmp;
    }
    if (x1 > x2) {
      int tmp = x1;
      x1 = x2;
      x2 = tmp;
    }

    if (sqrt((x2 - x1)^2 + (y2 - y1)^2) <= (a.height / 2) + (b. height / 2)) {
      return true;
    }
    return false;
  }

  /**
   * Checks if two elements with circle and rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool recCir(m.Element rectangle, m.Element circle) {

    int x = (circle.x + (circle.width / 2)) as int;
    int y = (circle.y + (circle.height / 2)) as int;

    return CollisionChecker.rectangles(rectangle, circle);
    /*
    // Upper left
    if (sqrt((rectangle.x - x)^2 + (rectangle.y - y)^2) <= (circle.height / 2)
        && !(sqrt((x - rectangle.x)^2 + (y - rectangle.y)^2) <= (circle.height / 2))) {
      return true;
    }
    // Upper right
    if (sqrt((x - rectangle.x)^2 + (rectangle.y - y)^2) <= (circle.height / 2)
        && !(sqrt((rectangle.x - x)^2 + (y - rectangle.y)^2) <= (circle.height / 2))) {
      return true;
    }
    // Lower Left
    if (sqrt((rectangle.x - x)^2 + (y - rectangle.y)^2) <= (circle.height / 2)
        && !(sqrt((x - rectangle.x)^2 + (rectangle.y - y)^2) <= (circle.height / 2))) {
      return true;
    }
    // Lower right
    if (sqrt((x - rectangle.x)^2 + (y - rectangle.y)^2) <= (circle.height / 2)
        && !(sqrt((rectangle.x - x)^2 + (rectangle.y - y)^2) <= (circle.height / 2))) {
      return true;
    }
    return false;
     */
  }
}