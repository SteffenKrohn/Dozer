import 'dart:html';

import '../controller/MenuController.dart';

class MenuView {

  MenuController _menuController;
  int _score;
  int _time;

  MenuView(MenuController mc, int score, int time) {
    this._menuController = mc;
    this._score = score;
    this._time = time;
  }

  void show() {
    String html;
    if (_score <= 0) {
      html = "<div id='menu'><h1>It took you $_time seconds lose!</h1></div>";
    } else {
      html = "<div id='menu'><h1>It took you $_time seconds to reach 50 points!</h1></div>";
    }
    querySelector("body").setInnerHtml(html);
  }
}