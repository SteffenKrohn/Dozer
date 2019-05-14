part of dozergame;

class Dozer extends Entity {

  /** The current score / length of the dozer */
  int score;
  List<int> _tailMovement;
  List<DozerTail> tailEntities;

  /**
   * Creates a Dozer object with the id  dozer and the given score
   */
  Dozer(int score) {
    this.id = 0;
    this.score = score;
    this.dy = 0;
    // TODO fix this (streng genommen gehören querySelector... width/height in den View als membervariablen, die man sich dann hier getted?)
    // und im Level wird doch auch schon Height und Width gespeichert?
    this.x = querySelector("body").getBoundingClientRect().width ~/ 2;
    this.y = (querySelector("body").getBoundingClientRect().height * 0.5).toInt();
    this.height = (querySelector("body").getBoundingClientRect().width * 0.05).floor();
    this.width = (querySelector("body").getBoundingClientRect().width * 0.05).floor();

    // initialise tailMovement list with straight tail
    for(int i = 0; i <= 25 * 50; i++) { // target score * update rate
      this._tailMovement.add(0);
    }
  }

  void update() {
    // TODO Make prettier
    int dx = this.dx;

    // Left border
    if (this.x + dx < 0) {
      dx = this.x * -1;
    }
    // Right border
    // TODO bad querySelector
    if (this.x + dx + this.width > querySelector("#lane").getBoundingClientRect().width) {
      dx = querySelector("#lane")
          .getBoundingClientRect()
          .width - this.x - this.width;
    }

    this.dx = dx;
    super.update();

    // Add Tail Movement
    this._tailMovement.insert(0, this.dx);
    this._tailMovement.removeLast();

    // Remove Tail Entity
    if(this.tailEntities.length > this.score) {
      while(this.tailEntities.length != this.score) {
        this.tailEntities.removeLast();
      }
    }

    // Add Tail Entity
    if(this.tailEntities.length < this.score) {
      this.tailEntities.add(DozerTail(this.tailEntities.length + 1, this.tailEntities.last.x, this.tailEntities.last.y + 5)); // x wert ist falsch
    }

    // Update existing Tail Entities
    for(int i = 0; i < this.tailEntities.length; i++) {
      this.tailEntities[i].move(this._tailMovement[(i + 1) * 50], 5);
      this.tailEntities[i].update();
    }
  }

  /**
   * Changes the score of the dozer
   */
  void changeScore(int change) {
    this.score + change;
  }

  /**
   * Returns a string representation of the dozer
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