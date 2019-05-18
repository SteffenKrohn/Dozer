part of dozergame;

class Dozer extends Entity {

  /** The current score / length of the dozer */
  int score;
  List<Coordinates> _tailRoute = new List<Coordinates>();
  List<DozerTail> tailEntities = new List<DozerTail>();
  final int _tailGap = 5;

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

    // initialise tailRoute list with straight tail
    for(int i = 0; i <= 25 * this._tailGap; i++) { // target score * gap
      this._tailRoute.add(Coordinates(this.x, this.y + i));
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

    // Add new Route Coordinates to List and update existing ones
    this._tailRoute.insert(0, Coordinates(this.x, this.y));
    this._tailRoute.removeLast();
    this._tailRoute.forEach((c) => c.y += 5);

    // Remove Tail Entities after score decreases
    while(this.tailEntities.length >= this.score) {
        this.tailEntities.removeLast();
    }

    // Add Tail Entities
    while(this.tailEntities.length + 1 < this.score) {
      this.tailEntities.add(DozerTail(this.tailEntities.length + 1,
          this._tailRoute[(this.tailEntities.length + 1) * this._tailGap].x,
          this._tailRoute[(this.tailEntities.length + 1) * this._tailGap].y));
    }

    // Update existing Tail Entities
    for(int i = 0; i < this.tailEntities.length; i++) {
      this.tailEntities[i].x = this._tailRoute[i * this._tailGap].x;
      this.tailEntities[i].y = this._tailRoute[i * this._tailGap].y;
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