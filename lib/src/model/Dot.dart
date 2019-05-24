part of dozergame;

class Dot extends Entity {

  int value;

  Dot(int id, double x, double y, int value, int width, int height, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
    this.width = width;
    this.height = height;
    this.level = level;
  }

  String toString() {
    return "dot";
  }

  @override
  void hitBy(Entity e) {
    if (e is Dozer) {
      this.value = 0;
    }
  }

  static double getStandardRadius() {
    return 0.05;
  }
}