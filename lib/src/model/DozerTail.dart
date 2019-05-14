part of dozergame;

class DozerTail extends Entity {

  DozerTail(int x, int y) {
    this.x = x;
    this.y = y;
  }

  String toString() {
    return "dozertail";
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }
}