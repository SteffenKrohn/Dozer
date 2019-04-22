import '../model/Element.dart';
import 'CollisionChecker.dart';

abstract class HitBox {

  Map<Element, Function(Element, Element)> collisionObjects = new Map();

  void addCollisionObject(Element e, Function(Element, Element) f) {
    if (e == null || f == null) {
      return;
    }
    collisionObjects.putIfAbsent(e, () => f);
  }

  void removeCollisionObject(Element e) {
    if (e == null) {
      return;
    }
    collisionObjects.remove(e);
  }

  void checkCollision() {
    collisionObjects.forEach((e, f) {
      if (CollisionChecker.collide(this, e)) {
        f(this, e);
      }
    });
  }
}