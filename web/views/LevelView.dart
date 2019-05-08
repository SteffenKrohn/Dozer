import 'dart:html';

import '../controller/LevelController.dart';
import '../model/Level.dart';

class LevelView {

  LevelController _levelController;
  Level _level;

  Element _view;

  //List<m.Element> elements = new List<m.Element>();

  LevelView(LevelController lc, Level level) {
    this._levelController = lc;
    this._level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this._view = querySelector("#lane");
    this._view.appendHtml(level.getDozer().toString());
    level.getDozer().y = this._view.getBoundingClientRect().height - 100;
  }

  void render() {

    // TODO remove obejcts
  }
}