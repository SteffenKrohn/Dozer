import '../file/ConfigLoader.dart';
import 'LevelController.dart';
import 'MenuController.dart';

class GameController {

  MenuController _menucontroller;
  LevelController _levelController;
  ConfigLoader _configLoader;

  /** The target framerate in hz */
  static const int framerate = 50;

  int _highscore = 0;

  void startup() {

    // TODO dynamic level
    // Load level 1
    startNextLevel();
  }

  void startNextLevel() {

    _levelController = LevelController.load(this, 1);
    _levelController.start();
  }

  void showMenu() {
    // TODO magic number for time
    _menucontroller = MenuController.load(
        this,
        _levelController.level.getScore(),
        (100 - _levelController.level.timeLimit).floor()
    );
    _menucontroller.start();
  }
}