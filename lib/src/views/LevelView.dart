part of dozergame;

class LevelView {

  LevelController _levelController;
  Level level;

  Element lane;

  LevelView(LevelController lc, Level level) {
    this._levelController = lc;
    this.level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this.lane = querySelector("#lane");
  }

  void render() {
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
    } else if(entity.toString() == "dot") {
      out += "<div class='entity dot' id='e${entity.id}'> ${(entity as Dot).value} </div>";
    } else if(entity.toString() == "brick") {
      out += "<div class='entity brick' id='e${entity.id}'> ${(entity as Brick).value} </div>";
    }

    return out;
  }
}