part of dozergame;

class SlowDown extends PowerUp {

  /// The power of the effect of this power up
  /// 0.1 means a speed of 10%
  /// 0.5 means a speed of 50%
  static final double POWER = 0.5;

  SlowDown(int id, double x, double y, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }

  String toString() {
    return "slowdown";
  }
}