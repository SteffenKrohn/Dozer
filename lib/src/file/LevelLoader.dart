import 'dart:convert';
import 'dart:html';

import 'package:dozergame/model.dart';

/// The [LevelLoader] is responsible for loading the JSON files from the web server
/// and deserialize them to [Level] objects with the corresponding [Entity]'s
class LevelLoader {

  /// The path where the levels are stored
  static const String _levelBasePath = "resources/level/";

  /// The reference to the newly loaded level
  Level _level;

  /// Returns a [Level] with the specific id which is loaded from the web server
  Future<Level> getLevel(int id) async {

    Future<Map> jsonMap = LevelLoader._makeRequest(id);

    // initialise maps
    Map EntitiesMap = await jsonMap;
    Map paramsMap = EntitiesMap.putIfAbsent("params", () => null);

    this._createLevelStump(paramsMap);

    List<dynamic> entities = EntitiesMap.putIfAbsent("entities", () => List());
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
        model.dy = this._level.getVerticalMovementPerUpdate();
        queuedEntities.add(model);
      }
      elementId++;
    });
    this._level.remainingEntities = queuedEntities;
    return this._level;
  }

  /// Returns the loaded json object as a map with keys out of the level properties
  static Future<Map> _makeRequest(int id) async {
    var path= _levelBasePath + 'level' + id.toString() + '.json';
    var r = HttpRequest.getString(path);
    String str = await r;
    return json.decode(str);
  }

  /// Initialises the [_level] of class [Level] with the basic and mandatory
  /// parameters needed to start a level. This includes everything except for
  /// the game entities.
  void _createLevelStump(Map paramsMap) {
    this._level = new Level(
        paramsMap.putIfAbsent("timelimit", () => 100) as int,// Time limit
        paramsMap.putIfAbsent("initialscore", () => 100) as int, // Initial score
        paramsMap.putIfAbsent("targetscore", () => 100) as int, // target Score
        paramsMap.putIfAbsent("lanespeed", () => 100) as double, // lanespeed
        paramsMap.putIfAbsent("level", () => 100) as int,  // level id
        window.innerHeight.floor(),
        window.innerWidth.floor()
    );
  }

  /// Returns a new [Dot] object out of a distinct id and a Map with the
  /// keys and values which have to match with the [Dot]'s constructor.
  Dot _getDot(int eId, Map e) {
    int width = this._level.viewWidth - (this._level.viewWidth * Dot.getStandardRadius()).floor();
    return Dot(
        eId,
        (width * e.putIfAbsent("x", () => 0)), // x
        this._level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
        e.putIfAbsent("value", () => 1) as int,
        (this._level.viewWidth * Dot.getStandardRadius()).floor(),
        (this._level.viewWidth * Dot.getStandardRadius()).floor(),
        this._level
    );
  }

  /// Returns a new [Brick] object out of a distinct id and a Map with the
  /// keys and values which have to match with the [Brick]'s constructor.
  Brick _getBrick(int eId, Map e) {
    int width = this._level.viewWidth - (this._level.viewWidth * Brick.getStandardWidth()).floor();
    return Brick(
        eId,
        (width * e.putIfAbsent("x", () => 0)), // x
        this._level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
        e.putIfAbsent("value", () => 1) as int,
        (this._level.viewWidth * Brick.getStandardWidth()).floor(),
        (this._level.viewHeight * Brick.getStandardHeight()).floor(),
        this._level
    );
  }

  /// Returns a new [Barrier] object out of a distinct id and a Map with the
  /// keys and values which have to match with the [Barrier]'s constructor.
  Barrier _getBarrier(int eId, Map e) {
    int width = this._level.viewWidth - (this._level.viewWidth * Barrier.getStandardWidth()).floor();
    int barrierHeight = -1 * this._level.getRemainingYFromTime(e.putIfAbsent("height", () => 0) as int).floor();
    return Barrier(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this._level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int) - barrierHeight,
        (this._level.viewWidth * Barrier.getStandardWidth()).floor(),
        barrierHeight,
        this._level
    );
  }

  /// Returns a new [DoubleUp] object out of a distinct id and a Map with the
  /// keys and values which have to match with the [DoubleUp]'s constructor.
  DoubleUp _getDoubleUp(int eId, Map e) {
    int width = this._level.viewWidth - (this._level.viewWidth * Dot.getStandardRadius()).floor();
    return DoubleUp(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this._level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int),
        (width * Dot.getStandardRadius()).floor(),
        (width * Dot.getStandardRadius()).floor(),
        this._level
    );
  }

  /// Returns a new [SlowDown] object out of a distinct id and a Map with the
  /// keys and values which have to match with the [SlowDown]'s constructor.
  SlowDown _getSlowDown(int eId, Map e) {
    int width = this._level.viewWidth - (this._level.viewWidth * Dot.getStandardRadius()).floor();
    return SlowDown(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this._level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int),
        (width * Dot.getStandardRadius()).floor(),
        (width * Dot.getStandardRadius()).floor(),
        this._level
    );
  }

  /// Returns a new [Drill] object out of a distinct id and a Map with the
  /// keys and values which have to match with the [Drill]'s constructor.
  Drill _getDrill(int eId, Map e) {
    int width = this._level.viewWidth - (this._level.viewWidth * Dot.getStandardRadius()).floor();
    return Drill(
        eId,
        width * e.putIfAbsent("x", () => 0),
        this._level.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int),
        (width * Dot.getStandardRadius()).floor(),
        (width * Dot.getStandardRadius()).floor(),
        this._level
    );
  }
}