import 'dart:html';

import 'package:dozergame/model.dart';

/// This is the View representation of the game itself.
/// It gives the ability to dynamically represent the model [Entity]'s and is
/// rendered several times a second when the level is running.
class LevelView {
  /// The reference to the level which is currently running
  Level _level;

  /// The main DOM Element in which all level [Entity]'s are displayed
  Element _lane;

  /// A simple div which contains the visual bar for displaying the players
  /// score and remaining time and the back button.
  /// It's within the lane.
  DivElement _visualBar;

  /// A map with all Elements which are currently in the lane and so in the view
  Map<String, Element> _laneElements = Map<String, Element>();

  /// Boolean. true if the [PowerUp] - [Drill] is active
  bool _drillActive = false;

  /// Boolean. true if the [PowerUp] - [DoubleUp] is active
  bool _doubleUpActive = false;

  /// Constructor creates and returns new [LevelView] with a lane element
  LevelView(Level level) {
    this._level = level;

    this._lane = DivElement()..setAttribute("id", "lane");
    querySelector("body")
      ..setInnerHtml("")
      ..append(this._lane);
  }

  /// The method will change the DOM-Tree according to the [_lane] content
  void render() async {
    _updateVisualBar();
    _handlePowerUps();

    Map<int, Entity> visibleElements = _level.getVisibleEntities();

    Map<String, Element>.from(this._laneElements).forEach((id, e) async {
      int id = int.parse(e.id.substring(1));
      Entity entity;

      // update old DOM Element if its also in visibleElements
      if (visibleElements.containsKey(id)) {
        entity = visibleElements[id];
        _updateEntityElement(e, entity);
      } else {
        // otherwise delete it from [laneElements]
        e.remove();
        this._laneElements.remove(e.id);
      }
      // Remove handled entries
      visibleElements.remove(id);
    });

    // add new DOM Elements
    visibleElements.forEach((id, value) async {
      DivElement e = this._getEntityRepresentation(value);
      this._lane.append(e);
      this._laneElements.putIfAbsent("e" + id.toString(), () => e);
      _updateEntityElement(e, value);
    });
  }

  /// Handles all PowerUp Animations
  void _handlePowerUps() {
    if (this._drillActive != this._level.getDozer().drillActive) {
      this._drillActive = !this._drillActive;
      this._updateDozerEntityElement();
    }
    if (this._doubleUpActive != this._level.getDozer().doubleUpActive) {
      this._doubleUpActive = !this._doubleUpActive;
      this._updateDotEntityElement();
    }
  }

  /// Updates DoubleUp PowerUp Animation by toggling it on/off
  void _updateDotEntityElement() async {
    this._laneElements.forEach((id, e) async {
      if (e.classes.contains("dot")) {
        e.classes.toggle("has-doubleup");
      }
    });
  }

  /// Updates Drill PowerUp Animation by toggling it on/off
  void _updateDozerEntityElement() async {
    this._laneElements.forEach((id, e) async {
      if (e.classes.contains("dozer")) {
        e.classes.toggle("has-drill");
      }
    });
  }

  /// Updates the default view values of a given Element
  /// corresponding to the model [Entity]
  static void _updateEntityElement(Element elem, Entity model) async {
    elem.style.cssText =
        "top:${model.y}px;" + "left:${model.x}px;" + "width:${model.width}px;" + "height:${model.height}px;";
  }

  /// Returns a [DivElement] with the correct css classes, ids and content
  DivElement _getEntityRepresentation(Entity entity) {
    if (entity.toString() == "dozer") {
      return DivElement()
        ..setAttribute("class", "entity dozer head")
        ..setAttribute("id", "e" + entity.id.toString())
        ..append(DivElement()..setAttribute("class", "eye left-eye"))
        ..append(DivElement()..setAttribute("class", "eye right-eye"));
    } else if (entity.toString() == "dozertail") {
      return DivElement()
        ..setAttribute("class", "entity dozer ${this._drillActive ? "has-drill" : ""}")
        ..setAttribute("id", "e" + entity.id.toString());
    } else if (entity.toString() == "dot") {
      return DivElement()
        ..setAttribute("class", "entity dot ${this._doubleUpActive ? "has-doubleup" : ""}")
        ..setAttribute("id", "e" + entity.id.toString())
        ..appendText((entity as Dot).value.toString());
    } else if (entity.toString() == "brick") {
      return DivElement()
        ..setAttribute("class", "entity brick ${_getBrickColorClass((entity as Brick).value)}")
        ..setAttribute("id", "e" + entity.id.toString())
        ..appendText((entity as Brick).value.toString());
    } else if (entity.toString() == "barrier") {
      return DivElement()..setAttribute("class", "entity barrier")..setAttribute("id", "e" + entity.id.toString());
    } else if (entity.toString() == "doubleup" || entity.toString() == "drill" || entity.toString() == "slowdown") {
      return DivElement()
        ..setAttribute("class", "entity powerup ${entity.toString()}")
        ..setAttribute("id", "e" + entity.id.toString());
    }
    // This should not be reached
    // If this is reached an entity has not been implemented above
    return DivElement();
  }

  /// Returns the specific color class for css for one brick value
  static String _getBrickColorClass(int value) {
    if (value < 4) {
      return "c1";
    } else if (value < 7) {
      return "c2";
    } else if (value < 11) {
      return "c3";
    } else if (value < 16) {
      return "c4";
    } else {
      return "c5";
    }
  }

  /// Create the initial [_visualBar] and append it in the [_lane]
  /// This is called in [LevelController]
  void createVisualBar() {
    _visualBar = DivElement()..setAttribute("class", "visual-bar");

    ImageElement menuButton = ImageElement(src: "resources/back.svg")..setAttribute("id", "button_back_in_level");

    DivElement progressBar = DivElement()..setAttribute("class", "progress-bar");

    DivElement currentLevel = DivElement()
      ..setAttribute("class", "level first-level")
      ..appendText(_level.getLevel().toString());

    ProgressElement scoreProgress = ProgressElement()
      ..setAttribute("class", "score-progress")
      ..setAttribute("min", "0")
      ..setAttribute("max", _level.targetScore.toString());

    DivElement nextLevel = DivElement()
      ..setAttribute("class", "level next-level")
      ..appendText((_level.getLevel() + 1).toString());

    SpanElement timer = SpanElement()
      ..setAttribute("class", "countdown")
      ..appendText((_level.timeLimit / 1000).toStringAsFixed(2));

    progressBar.append(currentLevel);
    progressBar.append(scoreProgress);
    progressBar.append(nextLevel);

    _visualBar.append(menuButton);
    _visualBar.append(progressBar);
    _visualBar.append(timer);

    _lane.append(_visualBar);
  }

  /// Updates the visual bar with values taken from [_level]
  void _updateVisualBar() async {
    // Score Progress
    _visualBar.children.elementAt(1).children.elementAt(1).setAttribute("value", _level.getDozer().score.toString());
    // Countdown
    _visualBar.children.elementAt(2).setInnerHtml((_level.timeLimit / 1000).toStringAsFixed(2));
  }
}
