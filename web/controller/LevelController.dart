import 'dart:async';
import 'dart:html';

import '../controller/GameController.dart';
import '../model/Level.dart';
import '../views/LevelView.dart';
import '../widgets/IDGenerator.dart';

class LevelController {

  GameController _gameController;
  Level _level;
  LevelView _levelView;

  // ListenerManager _listenerManager;

  static LevelController load(GameController gc, int level) {

    LevelController lc = new LevelController();

    lc._gameController = gc;

    // TODO Provisional
    lc._level = new Level(lc, 1, 100, 50, 100, 3);

    lc._levelView = new LevelView(lc, lc._level);

    return lc;
  }

  void start() {
    enableKeyboardControl();
    enableOrientationControl();

    Timer t;
    // Start the periodic update of the game elements with 50hz
    t = new Timer.periodic(new Duration(milliseconds: 1000 ~/ GameController.framerate), (update) {
      this._level.changeTimeLimit(-1000 ~/ GameController.framerate);
      this._levelView.update();

      // TODO smart?
      this._level.getDozer().checkCollision();
      if (this._level.getDozer().score <= 0) {
        this.stop(t);
        return;
      }

      this._level.getDozer().update();
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
        this._level.getDozer().move(-10, 0);
      }
      // Right pressed
      if (e.keyCode == 39) {
        this._level.getDozer().move(10, 0);
      }
    });
  }

  /**
   * Enables control of the dozer by tilting the phone
   */
  void enableOrientationControl() {
    // Handle the device orientation to move the Dozer
    window.onDeviceOrientation.listen((ev) {
      // No device orientation
      if (ev.alpha == null && ev.beta == null && ev.gamma == null) {
      }
      // Device orientation available
      else {
        // TODO make prettier
        int dx = ev.gamma.toInt();
        this._level.getDozer().move(dx, 0);
      }
    });
  }

  void stop(Timer t) {
    t.cancel();
    this._gameController.showMenu();
  }

  Level getLevel() {
    return this._level;
  }
}