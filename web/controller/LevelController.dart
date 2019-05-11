import 'dart:async';
import 'dart:html';

import '../controller/GameController.dart';
import '../file/LevelLoader.dart';
import '../model/Level.dart';
import '../views/LevelView.dart';

class LevelController {

  GameController _gameController;
  Level level;
  LevelView _levelView;
  LevelLoader _levelLoader;

  static LevelController load(GameController gc, int level) {

    LevelController lc = new LevelController();

    lc._gameController = gc;

    lc._levelView = new LevelView(lc, lc.level);
    // TODO Provisional
    lc.level = new Level(
        lc,
        100,// Time limit
        10, // Initial score
        50, // target Score
        250, // lanespeed
        1,  // level id
        querySelector("#lane").getBoundingClientRect().height,
        querySelector("#lane").getBoundingClientRect().width
    );
    lc._levelView.level = lc.level;
    return lc;
  }

  void start() {
    enableKeyboardControl();
    enableOrientationControl();

    Timer t;
    // Start the periodic update of the game elements with 50hz
    t = new Timer.periodic(new Duration(milliseconds: 1000 ~/ GameController.framerate), (update) {
      this.level.changeTimeLimit(-1000 / GameController.framerate / 1000);

      if (this.level.timeLimit <= 0) {
        this.stop(t);
        return;
      }

      this._levelView.render();

      // TODO smart?
      this.level.update();
      if (this.level.getScore() <= 0 || this.level.getDozer().score >= level.targetScore) {
        this.stop(t);
        return;
      }

      this.level.getDozer().update();
    });
  }

  /**
   * Enables control of the dozer by keyboard
   * namely the left and right arrow button
   */
  void enableKeyboardControl(){
    window.onKeyDown.listen((KeyboardEvent e) {
      //Left pressed
      if (e.keyCode == 37) {
        this.level.getDozer().move(-10, 0);
      }
      // Right pressed
      if (e.keyCode == 39) {
        this.level.getDozer().move(10, 0);
      }
      // Upper pressed
      if (e.keyCode == 38) {
        this.level.getDozer().move(0, 0);
      }
    });
  }

  /**
   * Enables control of the dozer by tilting the phone
   */
  void enableOrientationControl() {
    // Handle the device orientation to move the Dozer
    window.onDeviceOrientation.listen((ev) {
      // TODO make prettier
      int dx = ev.gamma ~/ 1.6;
      this.level.getDozer().move(dx, 0);
    });
  }

  void stop(Timer t) {
    t.cancel();
    this._gameController.showMessageWin(this.level.getScore(), this.level.initialTime - this.level.timeLimit.toInt());
  }
}