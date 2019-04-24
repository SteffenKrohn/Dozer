import 'dart:html';

import '../views/MenuView.dart';
import 'GameController.dart';

class MenuController {

  GameController _gameController;
  MenuView _menuView;


  static MenuController load(GameController gc, int score, int time) {

    MenuController mc = new MenuController();
    mc._gameController = gc;

    mc._menuView = new MenuView(mc, score, time);
    return mc;
  }

  void enableTouchControl() {
    querySelector("#menu").onClick.listen((MouseEvent e) {
      _gameController.startNextLevel();
    });
  }

  void start() {
    _menuView.show();
    enableTouchControl();
  }
}