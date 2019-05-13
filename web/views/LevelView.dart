import 'dart:html';

import '../controller/LevelController.dart';
import '../model/Brick.dart';
import '../model/Dot.dart';
import '../model/Dozer.dart';
import '../model/Level.dart';
import '../model/Element.dart' as elem;

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
    Map<int, elem.Element> visibleElements = level.getVisibleElements();

    lane.querySelectorAll(".element").forEach((e) {
      int id = int.parse(e.id.substring(1));
      elem.Element element;

      // update old DOM Element if its also in visibleElements
      if(visibleElements.containsKey(id)) {
        element = visibleElements[id];
        updateElement(e, element);
        visibleElements.remove(id);
      } else { // otherwise delete it
        e.remove();
      }
    });

    // add new DOM Elements
    visibleElements.forEach((id, value) {
      this.lane.appendHtml(getHtmlRepresentation(value));
      Element e = document.querySelector("#e" + id.toString());
      updateElement(e, value);
    });
  }

  /**
   * Updates the default view values of a given Element
   */
  static void updateElement(Element view, elem.Element model) {
    view.style.top = model.y.toString() + "px";
    view.style.left = model.x.toString() + "px";
    view.style.width = model.width.toString() + "px";
    view.style.height = model.height.toString() + "px";
  }

  static String getHtmlRepresentation(elem.Element element) {
    String out = "";


    if(element.toString() == "dozer"){
      out += "<div class='element dozer' id='e${element.id}'></div>";
    } else if(element.toString() == "dot") {
      out += "<div class='element dot' id='e${element.id}'> ${(element as Dot).value} </div>";
    } else if(element.toString() == "brick") {
      out += "<div class='element brick' id='e${element.id}'> ${(element as Brick).value} </div>";
    }

    return out;
  }
}