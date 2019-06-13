import 'package:dozergame/model.dart';

/// Model Representation of a [Brick].
/// This is used to build obstacles for the player.
/// Upon hitting the Brick, the score will be decreased.
class Brick extends Entity {

  /// The value is displayed and used to decrease the score
  int value;

  /// Constructs a new Brick with all necessary information
  Brick(int id, double x, double y, int value, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  /// Returns a string representing of this Brick
  String toString() {
    return "brick";
  }

  @override
  void hitBy(Entity e) {
    if (e is Dozer) {
      this.value = 0;
    }
  }

  /// Returns the percentage of the view width which one [Brick] will take up
  static double getStandardWidth() {
    return 0.25;
  }

  /// Returns the percentage of the view height which one [Brick] will take up
  static double getStandardHeight() {
    return 0.07;
  }
}