import 'dart:html';

import '../controller/LevelController.dart';
import '../model/Dozer.dart';
import '../model/Level.dart';
import '../model/Element.dart' as elem;

class LevelView {

  LevelController _levelController;
  Level _level;

  Element _lane;

  //List<m.Element> elements = new List<m.Element>();

  LevelView(LevelController lc, Level level) {
    this._levelController = lc;
    this._level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this._lane = querySelector("#lane");
    this._lane.appendHtml(level.getDozer().toString());
    level.getDozer().y = this._lane.getBoundingClientRect().height - 100;

    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this._lane = querySelector("#lane");
  }

  void render() {
    Map<int, elem.Element> visibleElements = _level.getVisibleElements();

    _lane.querySelectorAll(".element").forEach((e) {
      int id = int.parse(e.id.substring(1));
      elem.Element element;

      if(visibleElements.containsKey(id)) {
        element = visibleElements[id];
        e.style.top = element.y.toString() + "px";
        e.style.left = element.x.toString() + "px";
        visibleElements.remove(id);
        if (element is Dozer) {
          e.text = element.score.toString();
        }
      } else {
        e.remove();
      }
    });

    visibleElements.forEach((id, value) {
      this._lane.appendHtml(getHtmlRepresentation(value));
      Element e = document.querySelector("#e" + id.toString());
      e.style.top = value.y.toString() + "px";
      e.style.left = value.x.toString() + "px";
    });
  }

  String getHtmlRepresentation(elem.Element element) {
    String type = element.runtimeType.toString();
    String out;

    if(type == "Dozer" || type == "Dot" || type == "Brick") { // TODO Dozer kommt später raus, da es eine Schlange werden soll
      out = "<div class='element ${type.toLowerCase()}' id='e${element.id}'> ${element.toString()} </div>";
    } /*else if() { // Power ups

    }*/ else { // Barrier
      out = "<div class='element ${type.toLowerCase()}' id='e${element.id}'></div>";
    }

    return out;
  }
}