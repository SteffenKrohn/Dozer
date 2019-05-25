part of dozergame;

class LevelController {

  AppController _appController;
  Level level;
  LevelView _levelView;
  final Storage _localStorage = window.localStorage;

  static void loadAndStart(AppController ac, int level) async {
    Future<LevelController> dlc = LevelController.load(ac, level);
    LevelController lc = await dlc;
    lc.start();
  }

  static Future<LevelController> load(AppController ac, int level) async {

    LevelController lc = new LevelController();

    lc._appController = ac;

    lc._levelView = new LevelView(lc, lc.level);

    Level lvl = await LevelLoader.getLevel(lc, level);
    lc.level = lvl;
    lc._levelView.level = lvl;
    return lc;
  }

  void start() {
    // Enable the appropriate control
    if (this._appController.gyroAvailable) {
      enableOrientationControl();
    } else {
      enableKeyboardControl();
    }

    Timer t;
    // Start the periodic update of the game elements with 50hz
    t = new Timer.periodic(new Duration(milliseconds: 1000 ~/ AppController.framerate), (update) {
      this.level.changeTimeLimit(-1000 / AppController.framerate);

      if (this.level.gameLost()) {
        t.cancel();
        this._appController.showMessageLoose(this.level.timeLimit <= 0);
        return;
      }

      this._levelView.render();

      // TODO smart?
      this.level.update();
      if (this.level.gameWon()) {
        t.cancel();

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
        this._appController._sendScoreStats(this.level._level, this.level.getScore());

        this._appController.showMessageWin(this.level.getScore(), isNewHighscore);
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
      this.level.getDozer().move(ev.gamma / 4, 0);
    });
  }
}