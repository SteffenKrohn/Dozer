part of dozergame;

/// The model representation of the Double Up's used to give the player the
/// ability to increase his score by double the amount of the dot's values
class DoubleUp extends PowerUp {

  /// The constructor to create a [DoubleUp]
  DoubleUp(int id, double x, double y, int width, int height, Level level) {
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

  @override
  String toString() {
    return "doubleup";
  }
}