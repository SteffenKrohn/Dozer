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
  bool _gyroAvailable;

  void startup() {

    // TODO dynamic level
    // Load level 1
    this.showMenu();

    // TODO load levels
    this._nrAvailableLevels = 13; //provisional

    // TODO wait 1s test if gyro is supported, if not showMessageNoSupportForGyro
    this._gyroAvailable = false; //provisional
    this.showMessageNoSupportForGyro();
  }

  void startNextLevel() {
    _levelController = LevelController.load(this, this._reachedLevel);
    _levelController.start();
  }

  void startLevel(int level) {
    _levelController = LevelController.load(this, level);
    _levelController.start();
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

  void listenHelpButton() {
    querySelector("#button_help").onClick.listen((MouseEvent e) {
      this.showMessageHelp();
    });
  }

  void listenQRCodeButton() {
    querySelector("#button_qr_code").onClick.listen((MouseEvent e) {
      this.showMessageQRCode();
    });
  }

  void showMenu() {
    MenuView.show();
    this.listenNextLevelButton();
    this.listenChooseLevelButton();
    this.listenHelpButton();
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
    this.listenQRCodeButton();
  }

  void showMessageQRCode() {
    MessageView.showMessageQRCode();
    this.listenGoToMenuButton();
  }

  void showMessageHelp() {
    MessageView.showMessageHelp(this._gyroAvailable);
    this.listenGoToMenuButton();
  }

  void showMessageCredits() {
    MessageView.showMessageCredits();
    this.listenGoToMenuButton();
  }

  void showMessageChooseLevels(int nrAvailableLevels, int reachedLevel) {
    MessageView.showMessageChooseLevels(nrAvailableLevels, reachedLevel);
    this.listenGoToMenuButton();
    this.listenAllLevelButtons(reachedLevel);
  }
}