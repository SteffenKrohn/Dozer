import 'package:dozergame/model.dart';

/// The model representation of the Double Up's used to give the player the
/// ability to increase his score by double the amount of the dot's values.
/// It extends of the [PowerUp] class.
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
  void hitBy(Entity e) {}

  @override
  String toString() {
    return "doubleup";
  }
}
