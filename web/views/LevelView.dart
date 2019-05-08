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
    /*this._levelController = lc;
    this._level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this._view = querySelector("#lane");
    this._view.appendHtml(level.getDozer().toString());
    level.getDozer().y = this._view.getBoundingClientRect().height - 100;*/

    this._level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this._lane = querySelector("#lane");
  }

  void render() {
    /*List<int> removeObject = new List<int>();

    _level.getVisibleElements().forEach((id, e) {
      if (e.y > _view.getBoundingClientRect().bottom) {
        querySelector("#"+id.toString()).remove();
        removeObject.add(id);
        return;
      }
      e.move(0, _level.laneSpeed);
      e.update();
    });*/

    Map<int, elem.Element> visibleElements = _level.getVisibleElements();

    _lane.querySelectorAll(".element").forEach((e) {
      int id = int.parse(e.id.substring(1));
      elem.Element element;

      if(visibleElements.containsKey(id)) {
        element = visibleElements[id];
        String dy = element.y.toString() + "px";
        e.style.top = dy;
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
      this._lane.appendHtml(value.toString());
      Element e = document.querySelector("#e" + id.toString());
      e.style.top = value.y.toString() + "px";
      e.style.left = value.x.toString() + "px";
    });
  }

  String getHtmlRepresentation(elem.Element element) {
    String type = element.runtimeType.toString();
    String out;

    if(type == "Dozer" || type == "Dot" || type == "Brick") { // Dozer kommt später raus, da es eine Schlange werden soll
      out = "<div class='element ${type}' id='e${element.id}'> ${element.toString()} </div>";
    } /*else if() { // Power ups

    }*/ else { // Brick
      out = "<div class='element ${type}' id='e${element.id}'></div>";
    }

    return out;
  }
}