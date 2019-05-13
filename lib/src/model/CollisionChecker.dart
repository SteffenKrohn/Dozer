part of dozergame;

class CollisionChecker {

  /**
   * Checks if two elements with rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool rectangles(Entity a, Entity b) {

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
  static bool circles(Entity a, Entity b) {

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
  static bool recCir(Entity rectangle, Entity circle) {

    if (!CollisionChecker.rectangles(rectangle, circle)) {
      return false;
    }

    double r = (circle.width / 2);
    int x = circle.x + r.floor();
    int y = circle.y + r.floor();

    // This will be set to true when the circle is outside the corner of the rectangle
    bool edgeCase = false;

    // Upper left
    if (x < rectangle.x && y < rectangle.y) {
      if ((r < sqrt(pow(x - rectangle.x, 2) + pow(y - rectangle.y, 2)))) {
        edgeCase = true;
      }
    }

    // Upper right
    if (x > rectangle.x + rectangle.width && y < rectangle.y) {
      if ((r < sqrt(pow(x - (rectangle.x + rectangle.width), 2) + pow(y - rectangle.y, 2)))) {
        edgeCase = true;
      }
    }

    // Lower left
    if (x < rectangle.x && y > rectangle.y + rectangle.height) {
      if ((r < sqrt(pow(x - rectangle.x, 2) + pow(y - (rectangle.y + rectangle.height), 2)))) {
        edgeCase = true;
      }
    }

    // Lower right
    if (x > rectangle.x + rectangle.width && y > rectangle.y + rectangle.height) {
      // Radius is greater than the distance to the corner
      if ((r < sqrt(pow(x - (rectangle.x + rectangle.width), 2) + pow(y - (rectangle.y + rectangle.height), 2)))) {
        edgeCase = true;
      }
    }

    if (!edgeCase) {
      return true;
    }
    return false;
  }
}