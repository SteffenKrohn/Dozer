part of dozergame;

/// Model Representation of a [Barrier].
/// This is used to build obstacles for the player.
/// Upon hitting the Barrier, the [Dozer] can't move in this direction any further.
class Barrier extends Entity {

  /// The constructor to create a [Barrier]
  Barrier(int id, double x, double y, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  /// Returns the percent of the view width which one [Barrier] will take up
  static double getStandardWidth() {
    return 0.01;
  }

  @override
  String toString() {
    return "barrier";
  }

  @override
  void hitBy(Entity e) {
    // The Barrier does nothing when hit
  }
}