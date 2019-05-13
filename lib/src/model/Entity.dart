part of dozergame;

abstract class Entity {

  int id;

  /** The current movement of the entity for the next view update */
  int dx = 0;
  int dy = 5;

  int x;
  int y = 0;

  int width;
  int height;

  void move(int dx, int dy) {
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