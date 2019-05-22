part of dozergame;

class DozerTail extends Entity {

  DozerTail(int id, double x, double y) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.height = (querySelector("body").getBoundingClientRect().width * 0.05).floor();
    this.width = (querySelector("body").getBoundingClientRect().width * 0.05).floor();
  }

  String toString() {
    return "dozertail";
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }
}