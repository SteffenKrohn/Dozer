
import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import '../controller/LevelController.dart';
import '../model/Brick.dart';
import '../model/Dot.dart';
import '../model/Element.dart' as prefix0;
import '../model/Level.dart';


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
        querySelector("#lane").getBoundingClientRect().height,
        querySelector("#lane").getBoundingClientRect().width
    );

    List<dynamic> elements = map.putIfAbsent("elements", () => List());

    Queue<prefix0.Element> queuedElements = Queue<prefix0.Element>();

    // Counter to give each element an unique id
    int elementId = 1;

    elements.forEach((e) {
      String type = e.putIfAbsent("type", () => "");

      if (type == "dot") {
        int width = lvl.viewWidth - (lvl.viewWidth * Dot.getStandardRadius()).floor();
        queuedElements.add(Dot(
          elementId,
          (width * e.putIfAbsent("x", () => 0)).floor(), // x
          lvl.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
          e.putIfAbsent("value", () => 1) as int,
          (lvl.viewWidth * Dot.getStandardRadius()).floor(),
          (lvl.viewWidth * Dot.getStandardRadius()).floor()
        ));
      } else if (type == "brick") {
        int width = lvl.viewWidth - (lvl.viewWidth * Brick.getStandardWidth()).floor();
        queuedElements.add(Brick(
            elementId,
            (width * e.putIfAbsent("x", () => 0)).floor(), // x
            lvl.getRemainingYFromTime(e.putIfAbsent("time", () => 0) as int), // y
            e.putIfAbsent("value", () => 1) as int,
            (lvl.viewWidth * Brick.getStandardWidth()).floor(),
            (lvl.viewHeight * Brick.getStandardHeight()).floor()
        ));
      }
      elementId++;
    });
    lvl.remainingElements = queuedElements;
    return lvl;
  }

  static Future<Map> makeRequest(int id) async {
    var path='resources/level'+ id.toString() +'.json';
    var r = HttpRequest.getString(path);
    String str = await r;
    return json.decode(str);
  }
}