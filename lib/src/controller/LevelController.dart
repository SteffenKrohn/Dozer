part of dozergame;

/// The [LevelController] can be instantiated to control a specific level
/// It automatically calls methods of the [LevelLoader] and the [Level] to load
/// and start a level.
class LevelController {

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
    Future<LevelController> dlc = LevelController.load(ac, level);
    LevelController lc = await dlc;
    await lc.start();
    lc._increaseNrOfTries();
  }

  /// Factory method of the [LevelController]
  static Future<LevelController> load(AppController ac, int level) async {

    LevelController lc = new LevelController();

    lc._appController = ac;
    lc._levelView = new LevelView(lc.level);

    // get level from [LevelLoader] and initialise [lc]
    Level lvl = await LevelLoader().getLevel(level);
    lc.level = lvl;
    lc._levelView.level = lvl;
    lc._levelView.createVisualBar();

    return lc;
  }

  /// Starts the loaded level
  void start() {
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

      if (this.level.gameLost()) {
        this.timer.cancel();

        // show loose message
        this._appController.showMessageLoose(this.level.timeLimit <= 0);
        return;
      }

      if (this.level.gameWon()) {
        this.timer.cancel();

        // check highscore from local storage
        int oldHighscore = 0;
        bool isNewHighscore = true;
        String key = AppController.highscoreLevelKey + this.level._level.toString();
        if(this._localStorage.containsKey(key)) {
          oldHighscore = int.parse(this._localStorage[key]);
          isNewHighscore = oldHighscore < this.level.getScore() ? true : false;
        }
        if(oldHighscore < this.level.getScore()){
          this._localStorage[key] = this.level.getScore().toString();
        }

        // TODO will be deleted later
        // send score stats
        this._appController.sendCompetitionStats(this.level._level, this.level.getScore(), this.level.tries);

        // show win message
        this._appController.showMessageWin(this.level.getScore(), isNewHighscore, this.level.tries);
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
      this.level.getDozer().move(ev.gamma / 4, 0);
    });
  }

  /// Increases the number of tries for the current level in the local storage
  Future _increaseNrOfTries() async {
    int tries = 0;
    String key = AppController.triesLevelKey + this.level._level.toString();
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
}