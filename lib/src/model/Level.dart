part of dozergame;

class Level {

  /// The always available entity reference of the [Dozer]
  Dozer _dozer;

  /// The number of this level
  int _level;
  /// The remaining time to accomplish this level in ms
  double timeLimit;
  /// The initial time limit of this level
  int initialTimeLimit;
  /// The initial score of this level
  int initialScore;
  /// The target score a user has to reach to win this level
  int targetScore;
  /// The number of tries a user already tried this level
  int tries;
  /// The lanespeed equals the percentage which [Entity]'s (such as [Brick], [Dot]) move per second
  double laneSpeed;

  /// The map which contains all the [Entity]'s which are visible within the screen
  Map<int, Entity> visibleEntities = new Map<int, Entity>();
  /// The List which contains all remaining [Entity]'s ordered ascending to the displayed time
  List<Entity> remainingEntities;

  // TODO probably provisional
  int viewWidth;
  int viewHeight;

  /// Fields to keep track of power up´s
  List<Future> slowDownFutures = List();
  bool slowDownActive = false;

  /// Creates a new [Level]
  Level(int timeLimit, int initialScore, int targetScore, double laneSpeed, int level, int height, int width) {
    this._level = level;
    this.timeLimit = timeLimit.toDouble();
    this.initialTimeLimit = timeLimit;
    this.initialScore = initialScore;
    this.targetScore = targetScore;
    this.laneSpeed = laneSpeed;
    this.viewHeight = height;
    this.viewWidth = width;

    this._dozer = new Dozer(this);
    this.visibleEntities.putIfAbsent(this._dozer.id, () => this._dozer);
  }

  /// Changes the time limit of the level.
  /// The provided change is in seconds.
  /// Provide a positive change to increase the time limit,
  /// a negative change to decrease the time limit.
  void changeTimeLimit(double change) {
    // If the game is slowed the time is also slowed
    if (this.slowDownActive) {
      change = change * SlowDown.POWER;
    }
    this.timeLimit += change;
  }

  /// Changes the lane speed of the level.
  /// Provide a positive change to increase the lane speed,
  /// a negative change to decrease the lane speed.
  void changeLaneSpeed(int change) {
    this.laneSpeed += change;
  }

  /// Returns the current score, which is ofc scientifically proved ;)
  int getScore() {
    return (this.timeLimit * 1.357).floor() + this._dozer.score * 537;
  }

  /// Return the current level
  int getLevel() {
    return this._level;
  }

  /// Returns the [Dozer] object reference
  Dozer getDozer() {
    return this._dozer;
  }

  /// Returns a new map of all currently visible [Entity]'s.
  /// The key value pair of a map entry is:
  /// <ID of entity | entity>
  Map<int, Entity> getVisibleEntities() {
    return Map<int, Entity>.from(this.visibleEntities);
  }

  /// Updates all visible, newly visible and not-visible-anymore [Entity]'s.
  /// Also checks for collisions.
  void update() async {
    this.visibleEntities.forEach((id, e) => e.update());
    this.addNewlyVisibleEntities();
    this.removeInvisibleEntities();
    this.updateDozerTailInVisibleEntities();
    this.checkCollisions();
    this._dozer.update();
  }

  /// Checks collision of all visible [Entity]'s with the [Dozer].
  void checkCollisions() async {
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

  /// Adds all [Entity]'s that became visible since the last update.
  void addNewlyVisibleEntities() async {
    Entity next;
    double scrolled = this.viewHeight * this.laneSpeed * (this.initialTimeLimit - this.timeLimit) / 1000;

    List<Entity> remEnt = List.from(remainingEntities);

    double lastY;
    int lastH;

    remEnt.forEach((e) {

      if (lastY != null && e.y < lastY && e.y + e.height < lastY + lastH) {
        return;
      }

      lastY = e.y;
      lastH = e.height;

      if (e.y + e.height + scrolled >= 0) {
        e.y = e.y + scrolled.floor();
        visibleEntities.putIfAbsent(e.id, () => e);
        remainingEntities.remove(e);
      }

    });
  }

  /// Removes invisible [Entity]'s mainly entities that scrolled past the viewport
  /// from the [visibileEntities] Map.
  void removeInvisibleEntities() async {
    this.getVisibleEntities().forEach((id, e) {
      if (this.viewHeight < e.y) {
        this.visibleEntities.remove(id);
      }
    });
  }

  /// Gets the distance in pixel depending on duration and [laneSpeed]
  double getRemainingYFromTime(int ms) {
    return this.viewHeight * laneSpeed * ms / -1000;
  }

  /// Gets the distance a scrolling [Entity] (like a [Brick] or [Dot]) moves per frame
  double getVerticalMovementPerUpdate() {
    return this.viewHeight * this.laneSpeed / AppController.framerate;
  }

  /// Returns true if the game is won, false otherwise
  bool gameWon() {
    return this.getDozer().score >= this.targetScore;
  }

  /// Returns true if the game is lost, false otherwise
  bool gameLost() {
    return this.timeLimit <= 0 || this.getDozer().score <= 0;
  }

  /// Adds or removes [DozerTail] - [Entity]'s depending on the current score
  void updateDozerTailInVisibleEntities() async {
    // add tail entities to visible entities list
    this._dozer.tailEntities.forEach((e) {
      this.visibleEntities.putIfAbsent(e.id, () => e);
    });

    // remove
    for(int i = this._dozer.tailEntities.length + 1; this.visibleEntities.containsKey(-1 * i); i++){
      this.visibleEntities.remove(-1*i);
    }
  }
}