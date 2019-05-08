import 'dart:html';

import '../controller/LevelController.dart';
import '../model/Element.dart' as m;
import '../model/Level.dart';
import '../widgets/LevelGenerator.dart';

class LevelView {

  LevelController _levelController;
  // List<LaneView> _lanes;
  Level level;

  Element _view;

  List<m.Element> elements = new List<m.Element>();

  LevelView(LevelController lc, Level level) {
    this._levelController = lc;
    this.level = level;
    querySelector("body").setInnerHtml("<div id='lane'></div>");
    this._view = querySelector("#lane");
    this._view.appendHtml(level.getDozer().toString());
    level.getDozer().created();
    level.getDozer().y = this._view.getBoundingClientRect().height - 100;

    LevelGenerator lg = new LevelGenerator(this, new List<String>(), level.getDozer());
    lg.start();
  }

  void update() {
    elements.forEach((e) {
      if (e.y > _view.getBoundingClientRect().bottom) {
        querySelector("#"+e.id).remove();
        elements.remove(e);
        e = null;
        return;
      }
      e.move(0, _levelController.getLevel().getLaneSpeed());
      e.update();
    });
    level.getDozer().y = this._view.getBoundingClientRect().height - 100;
  }
}