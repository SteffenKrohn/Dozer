import 'dart:async';
import 'dart:html';

import '../file/ConfigLoader.dart';
import '../views/MenuView.dart';
import 'LevelController.dart';
import '../views/MessageView.dart';

class GameController {

  LevelController _levelController;
  ConfigLoader _configLoader;

  /** The target framerate in hz */
  static const int framerate = 50;

  int _highscore = 0;
  int _reachedLevel = 2; // TODO Web Storage
  int _nrAvailableLevels;
  bool _gyroAvailable = true;

  void startup() {

    // TODO dynamic level
    // Load level 1
    this.showMenu();

    // TODO load levels
    this._nrAvailableLevels = 13; //provisional

    // Check Gyrosensor Support
    window.onDeviceOrientation.first.then((e) {
      this._gyroAvailable = e.gamma != null ? true : false;
      if(!this._gyroAvailable) {
        this.showMessageNoSupportForGyro();
      }
    });

  }

  void startNextLevel() {
    LevelController.loadAndStart(this, this._reachedLevel);
  }

  void startLevel(int level) {
    LevelController.loadAndStart(this, level);
  }

  void listenGoToMenuButton() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showMenu();
    });
  }

  void listenNextLevelButton() {
    querySelector("#button_next_level").onClick.listen((MouseEvent e) {
      this.startNextLevel();
    });
  }

  void listenChooseLevelButton() {
    querySelector("#button_choose_levels").onClick.listen((MouseEvent e) {
      this.showMessageChooseLevels(this._nrAvailableLevels, this._reachedLevel);
    });
  }

  void listenAllLevelButtons(int reachedLevel) {
    for(int i = 1; i <= this._reachedLevel; i++) {
      querySelector("#button_level_$i").onClick.listen((MouseEvent e) {
        this.startLevel(i);
      });
    }
  }

  void listenCreditsButton() {
    querySelector("#button_credits").onClick.listen((MouseEvent e) {
      this.showMessageCredits();
    });
  }

  void showMenu() {
    MenuView.show(this._reachedLevel, "Catch The Dots To Grow The Dozer"); // this._levelController.level.instructions TODO waiting for dependency
    this.listenNextLevelButton();
    this.listenChooseLevelButton();
    this.listenCreditsButton();
  }

  void showMessageWin(int score, int seconds) {
    MessageView.showMessageWin(score, seconds);
    this.listenGoToMenuButton();
    this.listenNextLevelButton();
  }

  void showMessageLoose(int score) {
    MessageView.showMessageLoose(score);
    this.listenGoToMenuButton();
    this.listenNextLevelButton();
  }

  void showMessageNoSupportForGyro() {
    MessageView.showMessageNoSupportForGyro();
    this.listenGoToMenuButton();
  }

  void showMessageChooseLevels(int nrAvailableLevels, int reachedLevel) {
    MessageView.showMessageChooseLevels(nrAvailableLevels, reachedLevel);
    this.listenGoToMenuButton();
    this.listenAllLevelButtons(reachedLevel);
  }

  void showMessageCredits() {
    MessageView.showMessageCredits();
    this.listenGoToMenuButton();
  }

}