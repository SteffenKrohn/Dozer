import 'LevelController.dart';
import 'MenuController.dart';

class GameController {

  /** The target framerate in hz */
  static const int framerate = 50;

  // ConfigLoader _configLoader;
  // LevelLoader _levelloader;

  MenuController _menucontroller;
  LevelController _levelController;

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
    _menucontroller = MenuController.load(this, _levelController.getLevel().getScore(), (100 - _levelController.getLevel().getTimeLimit()).floor());
    _menucontroller.start();
  }
}