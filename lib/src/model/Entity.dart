part of dozergame;

abstract class Entity {

  Level level;

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

  /// Updates the [Entity] with it´s dy and dx values
  void update() {
    this.x += this.getDx();
    this.y += this.getDy();
    return;
  }

  String toString();

  /// Called when [Entity] e collides with this Entity
  void hitBy(Entity e);

  /// Gets the vertical movement for next update
  double getDy() {
    if (this.level.slowDownActive) {
      return this.dy * SlowDown.POWER;
    }
    return this.dy;
  }

  /// Gets the vertical movement for next update
  double getDx() {
    return this.dx;
  }
}