part of dozergame;

class LevelController {

  AppController _appController;
  Level level;
  LevelView _levelView;
  final Storage _localStorage = window.localStorage;
  Timer timer;

  static void loadAndStart(AppController ac, int level) async {
    Future<LevelController> dlc = LevelController.load(ac, level);
    LevelController lc = await dlc;
    await lc.start();
    lc._increaseNrOfTries();
  }

  static Future<LevelController> load(AppController ac, int level) async {

    LevelController lc = new LevelController();

    lc._appController = ac;

    lc._levelView = new LevelView(lc, lc.level);

    Level lvl = await LevelLoader().getLevel(lc, level);
    lc.level = lvl;
    lc._levelView.level = lvl;
    lc._levelView.createVisualBar();
    return lc;
  }

  void start() {
    // Enable the appropriate control
    if (this._appController.gyroAvailable) {
      this._enableOrientationControl();
    } else {
      this._enableKeyboardControl();
    }

    this._listenBackButton();

    // Start the periodic update of the game elements with 50hz
    this.timer = new Timer.periodic(new Duration(milliseconds: 1000 ~/ AppController.framerate), (update) {
      this.level.changeTimeLimit(-1000 / AppController.framerate);

      if (this.level.gameLost()) {
        timer.cancel();

        // send score stats
        this._appController.sendScoreStats(this.level._level, this.level.timeLimit.toInt(), this.level.tries, false, false);

        // show loose message
        this._appController.showMessageLoose(this.level.timeLimit <= 0);
        return;
      }

      this._levelView.render();

      // TODO smart?
      this.level.update();

      if (this.level.gameWon()) {
        timer.cancel();

        // check highscore from local storage
        int oldHighscore = 0;
        bool isNewHighscore = true;
        if(this._localStorage.containsKey('highscore_level_${this.level._level}')) {
          oldHighscore = int.parse(this._localStorage['highscore_level_${this.level._level}']);
          isNewHighscore = oldHighscore < this.level.getScore() ? true : false;
        }
        if(oldHighscore < this.level.getScore()){
          this._localStorage['highscore_level_${this.level._level}'] = this.level.getScore().toString();
        }

        // send score stats
        this._appController.sendScoreStats(this.level._level, this.level.getScore(), this.level.tries, true, false);

        // show win message
        this._appController.showMessageWin(this.level.getScore(), isNewHighscore, this.level.tries);
        return;
      }

      this.level.getDozer().update();
    });
  }

  /**
   * Enables control of the dozer by keyboard
   * namely the left and right arrow button
   */
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

  /**
   * Enables control of the dozer by tilting the phone
   */
  void _enableOrientationControl() {
    // Handle the device orientation to move the Dozer
    window.onDeviceOrientation.listen((ev) {
      this.level.getDozer().move(ev.gamma / 4, 0);
    });
  }

  Future _increaseNrOfTries() async {
    int tries = 0;
    if(this._localStorage.containsKey('tries_level_${this.level._level}')) {
      tries = int.parse(this._localStorage['tries_level_${this.level._level}']);
    }
    tries += 1;
    this._localStorage['tries_level_${this.level._level}'] = tries.toString();
    this.level.tries = tries;
    return;
  }

  void _listenBackButton() {
    querySelector("#button_back_in_level").onClick.listen((MouseEvent e) {
      this.timer.cancel();
      this._appController.showLevelOverview();

      // send score stats
      this._appController.sendScoreStats(this.level._level, this.level.timeLimit.toInt(), this.level.tries, false, true);
    });
  }
}