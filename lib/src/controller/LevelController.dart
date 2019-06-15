import 'dart:async';
import 'dart:html';

import 'package:dozergame/controller.dart';
import 'package:dozergame/model.dart';
import 'package:dozergame/view.dart';
import 'package:dozergame/file.dart';

/// The [LevelController] can be instantiated to control a specific level
/// It automatically calls methods of the [LevelLoader] and the [Level] to load
/// and start a level.
class LevelController {

  /// It is the sensitivity with which the Dozer is controlled.
  /// High value means less sensitivity and faster movement and vice versa.
  static const sensitivity = 4;

  /// Reference of the [AppController]
  AppController _appController;
  /// Reference to the model implementation of the level
  Level level;
  /// Reference to the view implementation of the level
  LevelView _levelView;
  /// The reference of the local storage
  final Storage _localStorage = window.localStorage;
  /// A timer used for counting down the level duration
  Timer timer;

  /// Loads a new [LevelController] and starts the specific [level]
  static void loadAndStart(AppController ac, int level) async {
    Future<LevelController> dlc = LevelController._load(ac, level);
    LevelController lc = await dlc;
    await lc._start();
    lc._increaseNrOfTries();
  }

  /// Factory method of the [LevelController]
  static Future<LevelController> _load(AppController ac, int levelNr) async {
    LevelController lc = new LevelController();
    lc._appController = ac;

    // get level from [LevelLoader] and initialise [lc]
    Level lvl = await LevelLoader().getLevel(levelNr);
    lc.level = lvl;

    // create the [LevelView]
    lc._levelView = new LevelView(lvl)
      ..createVisualBar();

    return lc;
  }

  /// Starts the loaded level
  void _start() {
    // Enable the appropriate control
    if (this._appController.gyroAvailable) {
      this._enableOrientationControl();
    } else {
      this._enableKeyboardControl();
    }

    // start listener for the abort/back button
    this._listenBackButton();

    // Start the periodic update of the game elements with the [AppController.framerate]
    this.timer = new Timer.periodic(new Duration(milliseconds: 1000 ~/ AppController.framerate), (update) {
      this.level.changeTimeLimit(-1000 / AppController.framerate);

      // update all entities on screen
      this._levelView.render();
      this.level.update();

      // check if player looses
      if (this.level.gameLost()) {
        this.timer.cancel();

        // show loose message
        this._appController.showMessageLoose(this.level.timeLimit <= 0);
        return;
      }

      // check if player wins
      if (this.level.gameWon()) {
        this.timer.cancel();

        // TODO will be deleted later
        // send score stats
        this._appController.sendCompetitionStats(this.level.level, this.level.getScore(), this.level.tries);

        // show win message
        this._appController.showMessageWin(this.level.getScore(), this._updateHighscore(), this.level.tries);
        return;
      }
    });
  }

  /// Enables control of the dozer by keyboard namely the left, right and upper arrow keys
  void _enableKeyboardControl(){
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

  /// Enables control of the dozer by tilting the phone
  void _enableOrientationControl() {
    window.onDeviceOrientation.listen((ev) {
      this.level.getDozer().move(ev.gamma / LevelController.sensitivity, 0);
    });
  }

  /// Increases the number of tries for the current level in the local storage
  Future _increaseNrOfTries() async {
    int tries = 0;
    String key = AppController.triesLevelKey + this.level.level.toString();
    if(this._localStorage.containsKey(key)) {
      tries = int.parse(this._localStorage[key]);
    }
    tries += 1;
    this._localStorage[key] = tries.toString();
    this.level.tries = tries;
    return;
  }

  /// Listens to the back (or abort) button to get back to the menu
  void _listenBackButton() {
    querySelector("#button_back_in_level").onClick.listen((MouseEvent e) {
      this.timer.cancel();
      this._appController.showLevelOverview();
    });
  }

  /// Updates the highscore in local storage and returns true if the player
  /// reached a new highscore. Else if no update took place it returns false.
  bool _updateHighscore() {
    int oldHighscore = 0;
    bool isNewHighscore = true;
    String key = AppController.highscoreLevelKey + this.level.level.toString();

    if(this._localStorage.containsKey(key)) {
      oldHighscore = int.parse(this._localStorage[key]);
      isNewHighscore = oldHighscore < this.level.getScore() ? true : false;
    }
    if(oldHighscore < this.level.getScore()){
      this._localStorage[key] = this.level.getScore().toString();
    }

    return isNewHighscore;
  }
}