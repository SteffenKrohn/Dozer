part of dozergame;

class LevelView {

  LevelController _levelController;
  Level level;
  List<int> dozerTailIds;

  Element lane;
  DivElement _visualBar;

  LevelView(LevelController lc, Level level) {
    this._levelController = lc;
    this.level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this.lane = querySelector("#lane");
  }

  void render() {
    if (null == _visualBar) {
      _createVisualBar();
    }
    _updateVisualBar();

    Map<int, Entity> visibleElements = level.getVisibleEntities();

    lane.querySelectorAll(".entity").forEach((e) {
      int id = int.parse(e.id.substring(1));
      Entity entity;

      // update old DOM Element if its also in visibleElements
      if(visibleElements.containsKey(id)) {
        entity = visibleElements[id];
        updateEntity(e, entity);
        visibleElements.remove(id);
      } else { // otherwise delete it
        e.remove();
      }
    });

    // add new DOM Elements
    visibleElements.forEach((id, value) {
      this.lane.appendHtml(getHtmlRepresentation(value));
      Element e = document.querySelector("#e" + id.toString());
      updateEntity(e, value);
    });
  }

  /**
   * Updates the default view values of a given Element
   */
  static void updateEntity(Element view, Entity model) {
    view.style.top = model.y.toString() + "px";
    view.style.left = model.x.toString() + "px";
    view.style.width = model.width.toString() + "px";
    view.style.height = model.height.toString() + "px";
  }

  static String getHtmlRepresentation(Entity entity) {
    String out = "";

    if(entity.toString() == "dozer"){
      out += "<div class='entity dozer' id='e${entity.id}'></div>";
    } else if(entity.toString() == "dozertail"){
      out += "<div class='entity dozer' id='e${entity.id}'></div>";
    } else if(entity.toString() == "dot") {
      out += "<div class='entity ${entity.toString()}' id='e${entity.id}'> ${(entity as Dot).value} </div>";
    } else if(entity.toString() == "brick") {
      out += "<div class='entity brick' id='e${entity.id}'> ${(entity as Brick).value} </div>";
    } else if (entity.toString() == "barrier") {
      out += "<div class='entity barrier' id='e${entity.id}'></div>";
    }

    return out;
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