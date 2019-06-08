part of dozergame;

/// The model representation of the Drill's used to give the player the
/// ability to break through bricks without decreasing his score/length.
/// It extends of the [PowerUp] class.
class Drill extends PowerUp {

  /// The constructor to create a [Drill]
  Drill(int id, double x, double y, int width, int height, Level level) {
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
    return "drill";
  }
}