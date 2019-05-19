part of dozergame;

class Level {

  LevelController _levelController;
  Dozer _dozer;

  /** Time limit in ms */
  double timeLimit;
  int _initialScore;
  int targetScore;

  /** Equals the percentage which certain entities (such as Brick, Dot) move per second */
  double laneSpeed;
  int _level;

  Map<int, Entity> visibleEntities = new Map<int, Entity>();
  Queue<Entity> remainingEntities;

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

    this._dozer = new Dozer(initialScore, laneSpeed);
    this.visibleEntities.putIfAbsent(this._dozer.id, () => this._dozer);
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
    return (this.timeLimit * 1.357).floor();
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
   * Returns an immutable map of all currently visible entities
   * The key value pair of a map entry is:
   * <ID of entity | entity>
   */
  Map<int, Entity> getVisibleEntities() {
    return Map<int, Entity>.from(this.visibleEntities);
  }

  /**
   * Updates all necessary entities
   * This will probably be called every 50ms
   */
  void update() {
    this.visibleEntities.forEach((id, e) => e.update());
    this.addNewlyVisibleEntities();
    this.removeInvisibleEntities();
    this.updateDozerTailInVisibleEntities();
    this.checkCollisions();
  }

  /**
   * Checks collision of all visible entities with the dozer
   * This will probably be called every 50ms
   */
  void checkCollisions() {
    this.getVisibleEntities().forEach((id, e) {
      if (e is Brick || e is Barrier) {
        if(CollisionChecker.recCir(e, this._dozer)) {
          this._dozer.hitBy(e);
          e.hitBy(this._dozer);
          if (e is Brick) {
            visibleEntities.remove(id);
          }
        }
      } else if (e is Dot || e is PowerUp) {
        if(CollisionChecker.circles(e, this._dozer)) {
          this._dozer.hitBy(e);
          e.hitBy(this._dozer);
          visibleEntities.remove(id);
        }
      }
    });
  }

  /**
   * Adds all entities that became visible since the last update
   * This will probably be called every 50ms
   */
  void addNewlyVisibleEntities() {
    Entity next;
    double scrolled;
    while (remainingEntities.length > 0 &&
           (scrolled = (next = remainingEntities.first).y + next.height +
           (this.viewHeight * this.laneSpeed * (this.initialTime - this.timeLimit))) >= next.height * -1
          ) {
      next.y = scrolled.floor();
      visibleEntities.putIfAbsent(next.id, () => next);
      remainingEntities.removeFirst();
    }
  }

  /**
   * Removes invisible entities mainly entities that scrolled past the viewport
   * from the visibileEntities Map
   */
  void removeInvisibleEntities() {
    this.getVisibleEntities().forEach((id, e) {
      if (this.viewHeight < e.y) {
        this.visibleEntities.remove(id);
      }
    });
  }

  int getRemainingYFromTime(int ms) {
    return this.viewHeight * laneSpeed * ms ~/ -1000;
  }

  bool gameWon() {
    return this.getDozer().score >= this.targetScore;
  }

  bool gameLost() {
    return this.timeLimit <= 0 || this.getDozer().score <= 0;
  }

  void updateDozerTailInVisibleEntities() {
    // add tail entities to visible entities list
    this._dozer.tailEntities.forEach((e) {
      this.visibleEntities.putIfAbsent(e.id, () => e);
    });

    // remove
    for(int i = this._dozer.score; i < 60; i++){ // magic value aus LevelLoader (max. possible score)
      this.visibleEntities.remove(i);
    }
  }


}