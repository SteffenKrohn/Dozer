part of dozergame;

class Drill extends PowerUp {

  Drill(int id) {
      this.id = id;
  }

  @override
  void hitBy(Entity e) {
    // TODO: implement hitBy
  }

  String toString() {
    return "drill";
  }
}