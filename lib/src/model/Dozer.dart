part of dozergame;

class Dozer extends Entity {

  /** The current score / length of the dozer */
  int score;
  List<int> tail;

  /**
   * Creates a Dozer object with the id  dozer and the given score
   */
  Dozer(int score) {
    this.id = 0;
    this.score = score;
    this.dy = 0;
    // TODO fix this
    this.x = querySelector("body").getBoundingClientRect().width ~/ 2;
    this.y = querySelector("body").getBoundingClientRect().height - 50;
    this.height = 60;
    this.width = 60;
  }

  void update() {
    // TODO Make prettier
    dx = this.dx;
    // Left border

    if (this.x + dx < 0) {
      dx = this.x * -1;
    }
    // TODO bad querySelector
    if (this.x + dx + this.width > querySelector("#lane").getBoundingClientRect().right) {
      dx = querySelector("#lane").getBoundingClientRect().right - this.x + this.width;
    }
    this.dx = dx;
    super.update();
  }

  /**
   * Changes the score of the dozer
   */
  void changeScore(int change) {
    this.score + change;
  }

  /**
   * Returns a string representation of the dozer as an html element
   */
  String toString() {
    return "dozer";
  }

  @override
  void hitBy(Entity e) {
    if (e is Brick) {
      this.score -= e.value;
      return;
    }
    if (e is Dot) {
      this.score += e.value;
      return;
    }
    //TODO other hitBy behaviour
    // For Barrier maybe use tail positions to determine which side of the barrier the dozer is stuck
  }
}