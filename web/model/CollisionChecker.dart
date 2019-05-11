import 'dart:html';
import 'dart:math';

import '../model/Element.dart' as m;

class CollisionChecker {

  /**
   * Checks if two elements with rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool rectangles(m.Element a, m.Element b) {

    // Upper left of a and not lower left of a
    if (
          (a.y <= b.y + b.height && a.x <= b.x + b.width)
          &&
          !(a.y + a.height < b.y || a.x + a.width < b.x)
        ) {
      return true;
    }
    return false;
  }

  /**
   * Checks if two elements with circle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool circles(m.Element a, m.Element b) {

    double ra = (a.width / 2);
    double rb = (b.width / 2);

    double xa = a.x + ra;
    double ya = a.y + ra;

    double xb = b.x + rb;
    double yb = b.y + rb;

    if (ra + rb >= sqrt(pow(xa - xb, 2) + pow(ya - yb, 2)) ) {
      return true;
    }
    return false;
  }

  /**
   * Checks if two elements with circle and rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool recCir(m.Element rectangle, m.Element circle) {

    if (!CollisionChecker.rectangles(rectangle, circle)) {
      return false;
    }

    double r = (circle.width / 2);
    int x = circle.x + r.floor();
    int y = circle.y + r.floor();

    // FIXME this only checks the corners of the rectangle against the circle

    // Upper left
    if (r <= sqrt(pow(x - rectangle.x, 2) + pow(y - rectangle.y, 2))) {
      return true;
    }
    // Upper right
    if (r <= sqrt(pow(x - rectangle.x + rectangle.width, 2) + pow(y - rectangle.y, 2))) {
      return true;
    }
    // Lower left
    if (r <= sqrt(pow(x - rectangle.x, 2) + pow(y - rectangle.y + rectangle.height, 2))) {
      return true;
    }
    // Lower right
    if (r <= sqrt(pow(x - rectangle.x + rectangle.width, 2) + pow(y - rectangle.y + rectangle.height, 2))) {
      return true;
    }
    return false;
  }
}