part of dozergame;

class Drill extends PowerUp {

  Drill(int id, double x, double y, int width, int height, Level level) {
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
    return "drill";
  }
}