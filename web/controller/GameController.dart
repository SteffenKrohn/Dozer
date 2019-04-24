import 'LevelController.dart';

class GameController {

  /** The target framerate in hz */
  static const int framerate = 50;

  // ConfigLoader _configLoader;
  // LevelLoader _levelloader;

  // MenuConroller _menucontroller;
  LevelController _levelController;

  void startup() {

    // TODO dynamic level
    // Load level 1
    LevelController.load(this, 1).start();
  }

  void startNextLevel() {

  }

  void showMenu() {

  }
}