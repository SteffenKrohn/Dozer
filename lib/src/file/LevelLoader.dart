part of dozergame;

class LevelLoader {

  static final levelBasePath = "resources/level/";

  LevelController levelController;
  Map params;

  Level level;
  
  Future<Level> getLevel(LevelController lc, int id) async {
    this.levelController = lc;

    Future<Map> fmap = makeRequest(id);
    
    Map map = await fmap;
    this.params = map.putIfAbsent("params", () => null);

    this._createLevelStump();

    List<dynamic> entities = map.putIfAbsent("entities", () => List());
    List<Entity> queuedEntities = List<Entity>();

    // Counter to give each element an unique id
    int elementId = 1;

    entities.forEach((e) {
      String type = e.putIfAbsent("type", () => "");
      Entity model;

      if (type == "dot") {
        model = this._getDot(elementId, e);
      } else if (type == "brick") {
        model = this._getBrick(elementId, e);
      } else if (type == "barrier") {
        model = this._getBarrier(elementId, e);
      } else if (type == "doubleup") {
        model = this._getDoubleUp(elementId, e);
      } else if (type == "drill") {
        model = this._getDrill(elementId, e);
      } else if (type == "slowdown") {
        model = this._getSlowDown(elementId, e);
      }

      if (model != null) {
        model.dy = this.level.getVerticalMovementPerUpdate();
        queuedEntities.add(model);
      }
      elementId++;
    });
    this.level.remainingEntities = queuedEntities;
    return this.level;
  }

  static Future<Map> makeRequest(int id) async {
    var path= levelBasePath + 'level'+ id.toString() +'.json';
    var r = HttpRequest.getString(path);
    String str = await r;
    return json.decode(str);
  }

  void _createLevelStump() {
    this.level = new Level(
        this.params.putIfAbsent("timelimit", () => 100) as int,// Time limit
        this.params.putIfAbsent("initialscore", () => 100) as int, // Initial score
        this.params.putIfAbsent("targetscore", () => 100) as int, // target Score
        this.params.putIfAbsent("lanespeed", () => 100) as double, // lanespeed
        this.params.putIfAbsent("level", () => 100) as int,  // level id
        window.innerHeight.floor(),
        window.innerWidth.floor()
    );
  }

  Dot _getDot(int eId, Map e) {
    int width = this.level.viewWidth - (this.level.viewWidth * Dot.getStandardRadius()).floor();
    return Dot(
        eId,
        (width * e.putIfAbsent("x", () => 0)), // x
        this.level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
        e.putIfAbsent("value", () => 1) as int,
        (this.level.viewWidth * Dot.getStandardRadius()).floor(),
        (this.level.viewWidth * Dot.getStandardRadius()).floor(),
        this.level
    );
  }

  Brick _getBrick(int eId, Map e) {
    int width = this.level.viewWidth - (this.level.viewWidth * Brick.getStandardWidth()).floor();
    return Brick(
        eId,
        (width * e.putIfAbsent("x", () => 0)), // x
        this.level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
        e.putIfAbsent("value", () => 1) as int,
        (this.level.viewWidth * Brick.getStandardWidth()).floor(),
        (this.level.viewHeight * Brick.getStandardHeight()).floor(),
        this.level
    );
  }

  Barrier _getBarrier(int eId, Map e) {
    int width = this.level.viewWidth - (this.level.viewWidth * Barrier.getStandardWidth()).floor();
    int barrierHeight = -1 * this.level.getRemainingYFromTime(e.putIfAbsent("height", () => 0) as int).floor();
    return Barrier(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this.level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int) - barrierHeight,
        (this.level.viewWidth * Barrier.getStandardWidth()).floor(),
        barrierHeight,
        this.level
    );
  }

  DoubleUp _getDoubleUp(int eId, Map e) {
    int width = this.level.viewWidth - (this.level.viewWidth * Dot.getStandardRadius()).floor();
    return DoubleUp(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this.level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int),
        (width * Dot.getStandardRadius()).floor(),
        (width * Dot.getStandardRadius()).floor(),
        this.level
    );
  }

  SlowDown _getSlowDown(int eId, Map e) {
    int width = this.level.viewWidth - (this.level.viewWidth * Dot.getStandardRadius()).floor();
    return SlowDown(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this.level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int),
        (width * Dot.getStandardRadius()).floor(),
        (width * Dot.getStandardRadius()).floor(),
        this.level
    );
  }

  Drill _getDrill(int eId, Map e) {
    int width = this.level.viewWidth - (this.level.viewWidth * Dot.getStandardRadius()).floor();
    return Drill(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this.level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int),
        (width * Dot.getStandardRadius()).floor(),
        (width * Dot.getStandardRadius()).floor(),
        this.level
    );
  }
}