import 'dart:math';
import 'package:dozergame/model.dart';

/// This class is used to check collisions between [Entity]'s and the [Dozer]
class CollisionChecker {
  /// Checks if two entities with rectangle shape overlap or touch
  /// by checking the boundaries of both entities
  static bool rectangles(Entity a, Entity b) {
    // Upper left of a and not lower left of a
    if ((a.y <= b.y + b.height && a.x <= b.x + b.width) && !(a.y + a.height < b.y || a.x + a.width < b.x)) {
      return true;
    }
    return false;
  }

  /// Checks if two entities with circle shape overlap or touch
  /// by checking the boundaries of both entities
  static bool circles(Entity a, Entity b) {
    double ra = (a.width / 2);
    double rb = (b.width / 2);

    double xa = a.x + ra;
    double ya = a.y + ra;

    double xb = b.x + rb;
    double yb = b.y + rb;

    if (ra + rb >= sqrt(pow(xa - xb, 2) + pow(ya - yb, 2))) {
      return true;
    }
    return false;
  }

  /// Checks if two entities with circle and rectangle shape overlap or touch
  /// by checking the boundaries of both entities
  static bool recCir(Entity rectangle, Entity circle) {
    if (!CollisionChecker.rectangles(rectangle, circle)) {
      return false;
    }

    double r = (circle.width / 2);
    double x = circle.x + r;
    double y = circle.y + r;

    // This will return false when the circle is outside the corner of the rectangle

    // Upper left
    if (x < rectangle.x && y < rectangle.y) {
      if ((r < sqrt(pow(x - rectangle.x, 2) + pow(y - rectangle.y, 2)))) {
        return false;
      }
    }

    // Upper right
    if (x > rectangle.x + rectangle.width && y < rectangle.y) {
      if ((r < sqrt(pow(x - (rectangle.x + rectangle.width), 2) + pow(y - rectangle.y, 2)))) {
        return false;
      }
    }

    // Lower left
    if (x < rectangle.x && y > rectangle.y + rectangle.height) {
      if ((r < sqrt(pow(x - rectangle.x, 2) + pow(y - (rectangle.y + rectangle.height), 2)))) {
        return false;
      }
    }

    // Lower right
    if (x > rectangle.x + rectangle.width && y > rectangle.y + rectangle.height) {
      // Radius is greater than the distance to the corner
      if ((r < sqrt(pow(x - (rectangle.x + rectangle.width), 2) + pow(y - (rectangle.y + rectangle.height), 2)))) {
        return false;
      }
    }
    return true;
  }
}
