part of dozergame;

class DozerTail extends Entity {

  DozerTail(int id, double x, double y, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.height = (level.viewWidth * 0.05).floor();
    this.width = (level.viewWidth * 0.05).floor();
    this.level = level;
  }

  String toString() {
    return "dozertail";
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }

  @override
  double getDy() {
    return 0;
  }
}