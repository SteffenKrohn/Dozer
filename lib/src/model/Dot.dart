part of dozergame;

/// The model representation of the dot's used to increase the dozer length and score
class Dot extends Entity {

  /// The value displayed in a dot and used to increase the score
  int value;

  /// The constructor to create a [Dot]
  Dot(int id, double x, double y, int value, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  @override
  String toString() {
    return "dot";
  }

  @override
  void hitBy(Entity e) {}

  /// Returns the percent of the view width which one dot will take up
  static double getStandardRadius() {
    return 0.05;
  }
}