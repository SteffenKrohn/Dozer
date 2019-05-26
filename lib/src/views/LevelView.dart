part of dozergame;

class LevelView {

  LevelController _levelController;
  Level level;
  List<int> dozerTailIds;

  Element lane;
  DivElement _visualBar;

  Map<String, Element> laneElements = Map<String, Element>();

  LevelView(LevelController lc, Level level) {
    this._levelController = lc;
    this.level = level;
    
    this.lane = DivElement()
      ..setAttribute("id", "lane");
    querySelector("body")
        ..setInnerHtml("")
        ..append(this.lane);
  }

  void render() {
    if (null == _visualBar) {
      _createVisualBar();
    }
    _updateVisualBar();

    Map<int, Entity> visibleElements = level.getVisibleEntities();

    Map<String, Element>.from(this.laneElements).forEach((id, e) {
      int id = int.parse(e.id.substring(1));
      Entity entity;

      // update old DOM Element if its also in visibleElements
      if(visibleElements.containsKey(id)) {
        entity = visibleElements[id];
        if (entity is Dozer || entity is DozerTail) {
          updateDozerEntityElement(e, entity);
        } else if(entity is Dot) {
          updateDotEntityElement(e, entity);
        }
        updateEntityElement(e, entity);
      } else { // otherwise delete it
        e.remove();
        this.laneElements.remove(e.id);
      }
      // Remove handles entries
      visibleElements.remove(id);
    });

    // add new DOM Elements
    visibleElements.forEach((id, value) {
      DivElement e = getEntityRepresentation(value);
      this.lane.append(e);
      this.laneElements.putIfAbsent("e"+id.toString(), () => e);
      updateEntityElement(e, value);
    });
  }

  void updateDotEntityElement(Element view, Entity model) {
    // DoubleUp PowerUp Animation
    if (this.level._dozer.doubleUpActive) {
      view.classes.add("has-doubleup");
    }
    else {
      view.classes.remove("has-doubleup");
    }
  }

  void updateDozerEntityElement(Element view, Entity model) {
    // Drill PowerUp Animation
    if (this.level._dozer.drillActive) {
      view.classes.add("has-drill");
    }
    else {
      view.classes.remove("has-drill");
    }
  }

  /**
   * Updates the default view values of a given Element
   */
  static void updateEntityElement(Element view, Entity model) {
    view.style.top = model.y.toString() + "px";
    view.style.left = model.x.toString() + "px";
    view.style.width = model.width.toString() + "px";
    view.style.height = model.height.toString() + "px";
  }

  static DivElement getEntityRepresentation(Entity entity) {

    if(entity.toString() == "dozer"){
      return DivElement()
          ..setAttribute("class", "entity dozer head")
          ..setAttribute("id", "e"+entity.id.toString())
          ..append(DivElement()
              ..setAttribute("class", "eye left-eye")
          )
          ..append(DivElement()
              ..setAttribute("class", "eye right-eye")
          );
    } else if(entity.toString() == "dozertail"){
      return DivElement()
        ..setAttribute("class", "entity dozer")
        ..setAttribute("id", "e"+entity.id.toString());
    } else if(entity.toString() == "dot") {
      return DivElement()
        ..setAttribute("class", "entity dot")
        ..setAttribute("id", "e"+entity.id.toString())
        ..appendText((entity as Dot).value.toString());
    } else if(entity.toString() == "brick") {
      return DivElement()
        ..setAttribute("class", "entity brick ${_getBrickColorClass((entity as Brick).value)}")
        ..setAttribute("id", "e"+entity.id.toString())
        ..appendText((entity as Brick).value.toString());
    } else if (entity.toString() == "barrier") {
      return DivElement()
        ..setAttribute("class", "entity barrier")
        ..setAttribute("id", "e"+entity.id.toString());
    } else if (entity.toString() == "doubleup" || entity.toString() == "drill" || entity.toString() == "slowdown") {
      return DivElement()
        ..setAttribute("class", "entity powerup ${entity.toString()}")
        ..setAttribute("id", "e"+entity.id.toString());
    }
    // This should not be reached
    // If this is reached an entity has not been implemented above
    return DivElement();
  }

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

  /// Create the initial Visual Bar
  void _createVisualBar() {

    _visualBar = DivElement()
      ..setAttribute("class", "visual-bar");

    DivElement progressBar = DivElement()
      ..setAttribute("class", "progress-bar");
    
    DivElement currentLevel = DivElement()
      ..setAttribute("class", "level first-level")
      ..appendText(level.getLevel().toString());
    
    ProgressElement scoreProgress = ProgressElement()
      ..setAttribute("class", "score-progress")
      ..setAttribute("min", "0")
      ..setAttribute("max", level.targetScore.toString());

    DivElement nextLevel = DivElement()
      ..setAttribute("class", "level next-level")
      ..appendText((level.getLevel() + 1).toString());

    SpanElement timer = SpanElement()
      ..setAttribute("class", "countdown")
      ..appendText((level.timeLimit / 1000).toStringAsFixed(2));

    progressBar.append(currentLevel);
    progressBar.append(scoreProgress);
    progressBar.append(nextLevel);
    
    _visualBar.append(progressBar);
    _visualBar.append(timer);
    

    lane.append(_visualBar);
  }

  /// Updates the visual bar with values taken from [level]
  void _updateVisualBar() {
    // Score Progress
    _visualBar.children.elementAt(0).children.elementAt(1).setAttribute("value", level.getDozer().score.toString());
    // Countdown
    _visualBar.children.elementAt(1).setInnerHtml((level.timeLimit / 1000).toStringAsFixed(2));
  }
}