part of dozergame;

class LevelLoader {
  
  static Future<Level> getLevel(LevelController lc, int id) async {
    Future<Map> fmap = makeRequest(id);
    
    Map map = await fmap;
    Map params = map.putIfAbsent("params", () => null);

    Level lvl = new Level(
        lc,
        params.putIfAbsent("timelimit", () => 100) as int,// Time limit
        params.putIfAbsent("initialscore", () => 100) as int, // Initial score
        params.putIfAbsent("targetscore", () => 100) as int, // target Score
        params.putIfAbsent("lanespeed", () => 100) as double, // lanespeed
        params.putIfAbsent("level", () => 100) as int,  // level id
        querySelector("#lane").getBoundingClientRect().height.floor(),
        querySelector("#lane").getBoundingClientRect().width.floor()
    );

    if (params.containsKey("instructions")) {
      lvl.instructions = params.putIfAbsent("instructions", () => "");
    }


    List<dynamic> entities = map.putIfAbsent("entities", () => List());
    List<Entity> queuedEntities = List<Entity>();

    // Counter to give each element an unique id
    int elementId = 60;


    entities.forEach((e) {
      String type = e.putIfAbsent("type", () => "");
      Entity model;

      if (type == "dot") {
        int width = lvl.viewWidth - (lvl.viewWidth * Dot.getStandardRadius()).floor();
        model = Dot(
          elementId,
          (width * e.putIfAbsent("x", () => 0)), // x
          lvl.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
          e.putIfAbsent("value", () => 1) as int,
          (lvl.viewWidth * Dot.getStandardRadius()).floor(),
          (lvl.viewWidth * Dot.getStandardRadius()).floor()
        );
      } else if (type == "brick") {
        int width = lvl.viewWidth - (lvl.viewWidth * Brick.getStandardWidth()).floor();
        model = Brick(
            elementId,
            (width * e.putIfAbsent("x", () => 0)), // x
            lvl.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
            e.putIfAbsent("value", () => 1) as int,
            (lvl.viewWidth * Brick.getStandardWidth()).floor(),
            (lvl.viewHeight * Brick.getStandardHeight()).floor()
        );
      } else if (type == "barrier") {
        int width = lvl.viewWidth - (lvl.viewWidth * Barrier.getStandardWidth()).floor();
        int barrierHeight = -1 * lvl.getRemainingYFromTime(e.putIfAbsent("height", () => 0) as int).floor();
        model = Barrier(
            elementId,
            width * e.putIfAbsent("x", () => 0),
            lvl.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int) - barrierHeight,
            (lvl.viewWidth * Barrier.getStandardWidth()).floor(),
            barrierHeight
        );
      }
      if (model != null) {
        model.dy = lvl.viewHeight * lvl.laneSpeed / AppController.framerate;
        queuedEntities.add(model);
      }
      elementId++;
    });
    lvl.remainingEntities = queuedEntities;
    return lvl;
  }
  static Future<Map> makeRequest(int id) async {
    var path='resources/level'+ id.toString() +'.json';
    var r = HttpRequest.getString(path);
    String str = await r;
    return json.decode(str);
  }
}