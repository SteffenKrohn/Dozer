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

      if(visibleElements.containsKey(id)) {
        element = visibleElements[id];
        updateElement(e, element);
        visibleElements.remove(id);
        if (element is Dozer) {
          e.text = element.score.toString();
        }
      } else {
        e.remove();
      }
    });

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
    String out;

    /*if(type == "Dozer" || type == "Dot" || type == "Brick") { // TODO Dozer kommt später raus, da es eine Schlange werden soll
      out = "<div class='element ${type.toLowerCase()}' id='e${element.id}'> ${element.toString()} </div>";
    } /*else if() { // Power ups

    }*/ else { // Barrier
      out = "<div class='element ${type.toLowerCase()}' id='e${element.id}'></div>";
    }*/

    if(element is Dozer){
      out += "<div class='element dozer' id='e${element.id}'> ${element.toString()} </div>"; // TODO toString is provisional
    } else if(element is Dot) {
      out += "<div class='element dot' id='e${element.id}'> ${element.toString()} </div>";
    } else if(element is Brick) {
      out += "<div class='element brick' id='e${element.id}'> ${element.toString()} </div>";
    }

    return out;
  }
}