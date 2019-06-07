part of dozergame;

abstract class Entity {

  /// Reference of the [Level] the entity is used in
  Level level;
  /// The distinct id of an entity
  int id;

  /// The horizontal movement the [Entity] wants to make in the next update.
  double dx = 0;
  /// The vertical movement the [Entity] wants to make in the next update.
  double dy = 0;
  /// The horizontal coordinate of the [Entity]
  double x;
  /// The vertical coordinate of the [Entity]
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