part of dozergame;

class LevelController {

  AppController _appController;
  Level level;
  LevelView _levelView;

  static void loadAndStart(AppController ac, int level) async {
    Future<LevelController> dlc = LevelController.load(ac, level);
    LevelController lc = await dlc;
    lc.start();
  }

  static Future<LevelController> load(AppController ac, int level) async {

    LevelController lc = new LevelController();

    lc._appController = ac;

    lc._levelView = new LevelView(lc, lc.level);

    Level lvl = await LevelLoader.getLevel(lc, 1);
    lc.level = lvl;
    lc._levelView.level = lvl;
    return lc;
  }

  void start() {
    enableKeyboardControl();
    enableOrientationControl();

    Timer t;
    // Start the periodic update of the game elements with 50hz
    t = new Timer.periodic(new Duration(milliseconds: 1000 ~/ AppController.framerate), (update) {
      this.level.changeTimeLimit(-1000 / AppController.framerate / 1000);

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
        // TODO second parameter provisional
        this._appController.showMessageWin(this.level.getScore(), true);
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
        this.level.getDozer().move(-8, 0);
      }
      // Right pressed
      if (e.keyCode == 39) {
        this.level.getDozer().move(8, 0);
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
      // TODO make prettier
      int dx = ev.gamma ~/ 2;
      this.level.getDozer().move(dx, 0);
    });
  }
}