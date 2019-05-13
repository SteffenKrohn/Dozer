part of dozergame;

class Barrier extends Entity {

  int height;

  Barrier(int id, int x, int height) {
    this.id = id;
    this. x = x;
    this.height = height;
    this.width = 5;
  }

  String toString() {
    return "barrier";
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }
}