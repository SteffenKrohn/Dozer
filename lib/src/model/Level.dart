part of dozergame;

class Level {

  LevelController _levelController;
  Dozer _dozer;

  /** Time limit in seconds */
  double timeLimit;
  int _initialScore;
  int targetScore;

  /** Equals the percentage which certain elements (such as Brick, Dot) move per second */
  double laneSpeed;
  int _level;

  Map<int, Entity> visibleElements = new Map<int, Entity>();
  Queue<Entity> remainingElements;

  int initialTime;
  String instructions = "Catch The Dots To Grow The Dozer"; // provisional

  // TODO probably provisional
  int viewWidth;
  int viewHeight;

  /**
   * Creates a new level
   */
  Level(LevelController lc, int timeLimit, int initialScore, int targetScore, double laneSpeed, int level, int height, int width) {
    this._levelController = lc;
    this._level = level;
    this.timeLimit = timeLimit.toDouble();
    this.initialTime = timeLimit;
    this._initialScore = initialScore;
    this.targetScore = targetScore;
    this.laneSpeed = laneSpeed;
    this.viewHeight = height;
    this.viewWidth = width;

    this._dozer = new Dozer(initialScore);
    this.visibleElements.putIfAbsent(this._dozer.id, () => this._dozer);
  }

  /**
   * Changes the time limit of the level.
   * The provided change is in seconds.
   * Provide a positive change to increase the time limit,
   * a negative change to decrease the time limit.
   */
  void changeTimeLimit(double change) {
    this.timeLimit += change;
  }

  /**
   * Changes the lane speed of the level.
   * Provide a positive change to increase the lane speed,
   * a negative change to decrease the lane speed.
   */
  void changeLaneSpeed(int change) {
    this.laneSpeed += change;
  }

  /**
   * Returns the current score
   */
  int getScore() {
    return this._dozer.score;
  }

  /**
   * Return the current level
   */
  int getLevel() {
    return this._level;
  }

  /**
   * Returns the Dozer object
   */
  Dozer getDozer() {
    return this._dozer;
  }

  /**
   * Returns an immutable map of all currently visible elements
   * The key value pair of a map entry is:
   * <ID of element | element>
   */
  Map<int, Entity> getVisibleElements() {
    return Map<int, Entity>.from(this.visibleElements);
  }

  /**
   * Updates all necessary elements
   * This will probably be called every 50ms
   */
  void update() {
    this.visibleElements.forEach((id, e) => e.update());
    this.addNewlyVisibleElements();
    this.removeInvisibleElements();
    this.checkCollisions();
  }

  /**
   * Checks collision of all visible elements with the dozer
   * This will probably be called every 50ms
   */
  void checkCollisions() {
    this.getVisibleElements().forEach((id, e) {
      if (e is Brick || e is Barrier) {
        if(CollisionChecker.recCir(e, this._dozer)) {
          this._dozer.hitBy(e);
          e.hitBy(this._dozer);
          if (e is Brick) {
            visibleElements.remove(id);
          }
        }
      } else if (e is Dot || e is PowerUp) {
        if(CollisionChecker.circles(e, this._dozer)) {
          this._dozer.hitBy(e);
          e.hitBy(this._dozer);
          visibleElements.remove(id);
        }
      }
    });
  }

  /**
   * Adds all elements that became visible since the last update
   * This will probably be called every 50ms
   */
  void addNewlyVisibleElements() {
    Entity next;
    double scrolled;
    while (remainingElements.length > 0 &&
           (scrolled = (next = remainingElements.first).y + next.height +
           (this.viewHeight * this.laneSpeed * (this.initialTime - this.timeLimit))) >= next.height * -1
          ) {
      next.y = scrolled.floor();
      visibleElements.putIfAbsent(next.id, () => next);
      remainingElements.removeFirst();
    }
  }

  /**
   * Removes invisible elements mainly elements that scrolled past the viewport
   * from the visibileElements Map
   */
  void removeInvisibleElements() {
    this.getVisibleElements().forEach((id, e) {
      if (this.viewHeight < e.y) {
        this.visibleElements.remove(id);
      }
    });
  }

  int getRemainingYFromTime(int ms) {
    return this.viewHeight * laneSpeed * ms ~/ -1000;
  }

}