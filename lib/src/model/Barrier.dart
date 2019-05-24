part of dozergame;

class Barrier extends Entity {

  Barrier(int id, double x, double y, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  String toString() {
    return "barrier";
  }

  static double getStandardWidth() {
    return 0.01;
  }

  @override
  void hitBy(Entity e) {
    // The Barrier does nothing when hit
  }
}