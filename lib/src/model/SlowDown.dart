part of dozergame;

class SlowDown extends PowerUp {

  SlowDown(int id, double x, double y, int width, int height) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }

  String toString() {
    return "slowdown";
  }
}