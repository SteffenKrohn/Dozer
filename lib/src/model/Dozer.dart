part of dozergame;

class Dozer extends Entity {

  static final double MAXIMUM_DOZER_HEIGHT = 0.7;

  /** The current score / length of the dozer */
  int score;
  List<Coordinates> _tailRoute = new List<Coordinates>();
  List<DozerTail> tailEntities = new List<DozerTail>();
  double _tailGap;

  /// Fields that track if a power up is active
  List<Future> drillFutures = List();
  List<Future> doubleUpFutures = List();
  bool drillActive = false;
  bool doubleUpActive = false;

  /**
   * Creates a Dozer object with the id  dozer and the given score
   */
  Dozer(Level level) {
    this.id = 0;
    this.score = level.initialScore;
    this.dy = 0;
    this.level = level;

    this.height = (this.level.viewWidth * 0.05).floor();
    this.width = (this.level.viewWidth * 0.05).floor();
    this.x = this.level.viewWidth / 2 - this.width;
    this.y = this._getYAccordingToScore();

    // initialise tailRoute list with straight tail
    this._tailGap = this.height * 0.5;


    for(int i = 0; i <= this.level.targetScore * AppController.framerate; i++) {
      this._tailRoute.add(Coordinates(this.x, this.y + (i * this._tailGap * this.level.laneSpeed)));
    }
    // Add the tail entities according to initial score
    this._removeAndAddTailEntities();
  }

  void update() async {
    double dx = this.dx;

    // Left border
    if (this.x + dx < 0) {
      dx = this.x * -1;
    }
    // Right border
    if (this.x + dx + this.width > level.viewWidth) {
      dx = level.viewWidth - this.x - this.width;
    }

    this.dx = dx;
    super.update();

    // Dozer Tail

    // Add new Route Coordinate to List and update existing ones
    this._tailRoute.removeLast();
    double movedDistance = this._tailRoute[1].y - this.y;
    this._tailRoute.forEach((c) => c.y += movedDistance);
    this._tailRoute.insert(0, Coordinates(this.x, this.y));


    this._updateExistingTailEntities();
    this._updateVerticalDozerPlacement();
  }

  /// Change certical [Dozer] placement Y-Coordinate according to the score
  void _updateVerticalDozerPlacement() {
    // dozer grows in height
    if(this._getYAccordingToScore() < this.y) {
      this._tailRoute.forEach((c) => c.y -= 1);
      this.y -= 1;
      return;
    }
    // dozer shrinks in height
    if(this._getYAccordingToScore() > this.y) {
      this._tailRoute.forEach((c) => c.y += 1);
      this.y += 1;
      return;
    }
  }

  /// Adds or removes [DozerTail] according to the current score
  void _removeAndAddTailEntities() {
    // Remove Tail Entities after score decreases
    while(this.tailEntities.length >= this.score && this.tailEntities.length > 0) {
      this.tailEntities.removeLast();
    }

    // Add Tail Entities after score increase
    while(this.tailEntities.length + 1 < this.score) {
      this.tailEntities.add(DozerTail(-1 * (this.tailEntities.length + 1), this.x, this.y, this.level));
    }
  }

  /// Update existing [DozerTail] entities
  /// TODO this seems unnecessary unperformant by going through the same Coordinates multiple times
  void _updateExistingTailEntities() {
    Coordinates lastCoordinates = this._tailRoute.first;
    for(int i = 0; i < this.tailEntities.length; i++) {
      // theorem of pythagoras
      Coordinates nextCoordinates = this._tailRoute.skip(i).firstWhere(
        (c) =>
          // Next Coordinate must be above old one
          c.y > lastCoordinates.y
          &&
          sqrt(pow(lastCoordinates.y - c.y, 2) + pow(lastCoordinates.x - c.x, 2)) >= this._tailGap
      );

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
      change = 0;
    }
    this.score += change;
    this._removeAndAddTailEntities();
  }

  /**
   * Returns a string representation of the dozer
   */
  String toString() {
    return "dozer";
  }

  @override
  void hitBy(Entity e) async {
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
    // PowerUp´s
    // If the power up is already active we have a future for that powerup
    // in [drillFutures]. So start a new Future when the previous power up
    // has ended.
    if (e is DoubleUp) {
      if (this.doubleUpFutures.length > 0) {
        this.doubleUpFutures.first.then((t) {
          this.doubleUpActive = true;
          Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
          delay.then((d) {
            this.doubleUpActive = false;
          });
          this.doubleUpFutures.insert(0, delay);
          this.doubleUpFutures.removeLast();
        });
      } else {
        Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
        delay.then((d) {
          this.doubleUpActive = false;
        });
        this.doubleUpFutures.insert(0, delay);
      }
      this.doubleUpActive = true;
      return;
    }
    if (e is Drill) {
      if (this.drillFutures.length > 0) {
        this.drillFutures.first.then((t) {
          this.drillActive = true;
          Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
          delay.then((d) {
            this.drillActive = false;
          });
          this.drillFutures.insert(0, delay);
          this.drillFutures.removeLast();
        });
      } else {
        Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
        delay.then((d) {
          this.drillActive = false;
        });
        this.drillFutures.insert(0, delay);
      }
      this.drillActive = true;
      return;
    }
    if (e is SlowDown) {
      if (this.level.slowDownFutures.length > 0) {
        this.level.slowDownFutures.first.then((t) {
          this.level.slowDownActive = true;
          Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
          delay.then((d) {
            this.level.slowDownActive = false;
          });
          this.level.slowDownFutures.insert(0, delay);
          this.level.slowDownFutures.removeLast();
        });
      } else {
        Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
        delay.then((d) {
          this.level.slowDownActive = false;
        });
        this.level.slowDownFutures.insert(0, delay);
      }
      this.level.slowDownActive = true;
      return;
    }
    //TODO other hitBy behaviour
  }

  /// Gets the height for the head of the dozer
  double _getYAccordingToScore() {
    return max(this.level.viewHeight * (1 - (this.score * 1.5 / 100)) - 10, this.level.viewHeight * Dozer.MAXIMUM_DOZER_HEIGHT);
  }

  @override
  double getDy() {
    return 0;
  }
}