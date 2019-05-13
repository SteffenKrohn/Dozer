part of dozergame;

/**
 * Representation of a Brick
 * This is used to build obstacles for the player
 * Upon hitting the Brick, the score will be decreased
 */
class Brick extends Entity {

  /** The value is displayed and used to decrease the score */
  int value;

  /**
   * Constructs a new Brick with all necessary information
   */
  Brick(int id, int x, int y, int value, int width, int height) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
    this.width = width;
    this.height = height;
  }

  /**
   * Returns a string representing of this Brick
   */
  String toString() {
    return "brick";
  }

  @override
  void hitBy(Entity e) {
    if (e is Dozer) {
      this.value = 0;
    }
  }

  static double getStandardWidth() {
    return 0.25;
  }

  static double getStandardHeight() {
    return 0.1;
  }
}