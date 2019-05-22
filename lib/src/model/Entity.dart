part of dozergame;

abstract class Entity {

  int id;

  /** The current movement of the entity for the next view update */
  double dx = 0;
  double dy = 5;

  double x;
  double y = 0;

  int width;
  int height;

  void move(double dx, double dy) {
    this.dx = dx;
    this.dy = dy;
  }

  void update() {
    this.x += this.dx;
    this.y += this.dy;
  }

  String toString();

  /**
   * Called when Entity e collides with this Entity
   */
  void hitBy(Entity e);
}