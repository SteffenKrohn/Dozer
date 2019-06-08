part of dozergame;

/// The model representation of the Slowdown's used to give the player the
/// ability to move the dozer slower through the virtual earth.
/// It extends of the [PowerUp] class.
class SlowDown extends PowerUp {

  /// The power of the effect of this power up
  /// 0.1 means a speed of 10%
  /// 0.5 means a speed of 50%
  static const double POWER = 0.5;

  /// The constructor to create a [SlowDown]
  SlowDown(int id, double x, double y, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  @override
  void hitBy(Entity e) {}

  @override
  String toString() {
    return "slowdown";
  }
}