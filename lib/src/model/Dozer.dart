part of dozergame;

class Dozer extends Entity {

  static final double MAXIMUM_DOZER_HEIGHT = 0.7;

  /** The current score / length of the dozer */
  int score;
  List<Coordinates> _tailRoute = new List<Coordinates>();
  List<DozerTail> tailEntities = new List<DozerTail>();
  int _tailGap;
  double _entityDy;

  /// Height of the lane in pixel
  int laneHeight;
  /// Width of the lane in pixel
  int laneWidth;

  /// Fields that track if a power up is active
  bool drillActive = false;
  bool doubleUpActive = false;

  /**
   * Creates a Dozer object with the id  dozer and the given score
   */
  Dozer(int score, double entityDy, int laneHeight, int laneWidth) {
    this.id = 0;
    this.score = score;
    this.dy = 0;
    this.laneHeight = laneHeight;
    this.laneWidth = laneWidth;
    // TODO fix this (streng genommen gehören querySelector... width/height in den View als membervariablen, die man sich dann hier getted?)
    // und im Level wird doch auch schon Height und Width gespeichert?
    this.x = laneWidth / 2;
    this.y = this._getYAccordingScore();
    this.height = (laneWidth * 0.05).floor();
    this.width = (laneWidth * 0.05).floor();

    // initialise tailRoute list with straight tail
    this._tailGap = (this.height * 0.4).toInt();
    this._entityDy = entityDy;
    for(int i = 0; i <= 50 * this._tailGap; i++) { // target score * gap
      this._tailRoute.add(Coordinates(this.x, this.y + i));
    }
  }

  void update() {
    // TODO Make prettier
    double dx = this.dx;

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

    // Change dozer height (y) according to the score
    // dozer grows in height
    if(this._getYAccordingScore() < this.y) {
      this._tailRoute.forEach((c) => c.y -= 1);
      this.y -= 1;
    }
    // dozer shrinks in height
    if(this._getYAccordingScore() > this.y) {
      this._tailRoute.forEach((c) => c.y += 1);
      this.y += 1;
    }

    // Add new Route Coordinates to List and update existing ones
    this._tailRoute.insert(0, Coordinates(this.x, this.y));
    this._tailRoute.removeLast();
    this._tailRoute.forEach((c) => c.y += (this._entityDy * 0.6).toInt()); // dy movement from entity

    // Remove Tail Entities after score decreases
    while(this.tailEntities.length >= this.score) {
        this.tailEntities.removeLast();
    }

    // Add Tail Entities
    while(this.tailEntities.length + 1 < this.score) {
      this.tailEntities.add(DozerTail(-1 * (this.tailEntities.length + 1), this.x, this.y));
    }

    // Update existing Tail Entities
    Coordinates lastCoordinates = this._tailRoute.first;
    for(int i = 0; i < this.tailEntities.length; i++) {
      // theorem of pythagoras
      Coordinates nextCoordinates = this._tailRoute.firstWhere((nextCoordinates) => nextCoordinates.y > lastCoordinates.y
          && sqrt(pow(lastCoordinates.y - nextCoordinates.y, 2) + pow(lastCoordinates.x - nextCoordinates.x, 2)) >= this._tailGap);

      this.tailEntities[i].x = nextCoordinates.x;
      this.tailEntities[i].y = nextCoordinates.y;

      lastCoordinates = nextCoordinates;
    }

  }

  /**
   * Changes the score of the [Dozer]
   * Depending on the power up´s behaviour will be different
   */
  void changeScore(int change) {
    if (this.doubleUpActive && change > 0) {
      change = change * 2;
    }

    if (this.drillActive && change < 0) {
      return;
    }
    this.score += change;
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
      this.changeScore(-1 * e.value);
      return;
    }
    if (e is Dot) {
      this.changeScore(e.value);
      return;
    }
    if (e is Barrier) {
      // Right Side
      if (this.dx < 0) {
        this.x = e.x + e.width - this.dx;
      } else if (this.dx > 0) {
        // Left Side
        this.x = e.x - this.width - this.dx;
      }
      return;
    }
    if (e is DoubleUp) {
      Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
      delay.then((d) {
        this.doubleUpActive = false;
      });
      this.doubleUpActive = true;
      return;
    }
    if (e is Drill) {
      Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
      delay.then((d) {
        this.drillActive = false;
      });
      this.drillActive = true;
      return;
    }
    //TODO other hitBy behaviour
    // For Barrier maybe use tail positions to determine which side of the barrier the dozer is stuck
    if (e is SlowDown) {
      // TODO SlowDown behaviour
    }
  }

  /// Gets the height for the head of the dozer
  double _getYAccordingScore() {
    return max(this.laneHeight * (1 - (this.score * 1.5 / 100)) - 10, this.laneHeight * Dozer.MAXIMUM_DOZER_HEIGHT);
  }
}