part of dozergame;

class AppController {

  LevelController _levelController;

  /** The target framerate in hz */
  static const int framerate = 35;

  int _highscore = 0;
  Storage _reachedLevelStorage = window.localStorage;
  int _activeLevel = 1;
  int _reachedLevel = 1;
  int _nrAvailableLevels = 10;
  bool _gyroAvailable = true;

  void startup() {

    if(this._reachedLevelStorage.containsKey('reachedLevel')) {
      this._reachedLevel = int.parse(this._reachedLevelStorage['reachedLevel']);
    }
    this._activeLevel = this.getReachedLevel();
    // TODO dynamic level
    this.showLeveLOverview();

    // TODO load levels

    // Check Gyrosensor Support
    window.onDeviceOrientation.first.then((e) {
      this._gyroAvailable = e.gamma != null ? true : false;
      if(!this._gyroAvailable) {
        this.showMessageNoSupportForGyro();
      } else {
        this.showWelcomeScreenOnMobileDevices();
      }
    });
  }

  void startNextLevel() {
    LevelController.loadAndStart(this, this.getActiveLevel());
  }

  void startLevel(int level) {
    LevelController.loadAndStart(this, level);
  }

  void listenGoToMenuButton() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showLeveLOverview();
    });
  }

  void listenGoToMenuButtonAndRequestFullscreen() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showLeveLOverview();
      document.body.requestFullscreen();
      window.screen.orientation.lock("portrait-primary");
    });
  }

  void listenStartLevelButton() {
    querySelector("#button_start_level").onClick.listen((MouseEvent e) {
      this.startNextLevel();
    });
  }

  void listenNextLevelButton() {
    querySelector("#button_next_level").onClick.listen((MouseEvent e) {
      this.setActiveLevel(this.getActiveLevel() + 1);
      if (this.getActiveLevel() > this._nrAvailableLevels) {
        this.showNoSuchLevel(this.getActiveLevel());
      } else {
        this.showLeveLOverview();
      }
    });
  }

  void listenPreviousLevelButton() {
    querySelector("#button_pevious_level").onClick.listen((MouseEvent e) {
      this.setActiveLevel(this.getActiveLevel() - 1);
      this.showLeveLOverview();
    });
  }

  void listenChooseLevelButton() {
    querySelector("#button_choose_levels").onClick.listen((MouseEvent e) {
      this.showMessageChooseLevels(this._nrAvailableLevels, this.getReachedLevel());
    });
  }

  void listenAllLevelButtons(int reachedLevel) {
    for (int i = 0; i < this._nrAvailableLevels; i++) {
      querySelector("#level-${i + 1}").onClick.listen((Event e) {
        e.preventDefault();
        this.setActiveLevel(i + 1);
        this.startLevel(i + 1);
      });
    }
  }

  void listenCreditsButton() {
    querySelector("#button_credits").onClick.listen((MouseEvent e) {
      this.showMessageCredits();
    });
  }


  void listenDonateButton() {
    querySelector("#button_donate").onClick.listen((MouseEvent e) {
      window.open("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EW22STTHR8DK2&source=url", "Donate on PayPal");
    });
  }

  void showLeveLOverview() {
    MenuView.show().levelOverview(this.getActiveLevel(), _getLevelIntrusction(this.getActiveLevel())).render(); // this._levelController.level.instructions TODO waiting for dependency
    this.listenStartLevelButton();
    this.listenChooseLevelButton();
    this.listenCreditsButton();
  }

  void showMessageWin(int score, bool newHighscore) {
    MenuView.show().messageWin(score, newHighscore).render();
    this.listenNextLevelButton();
  }

  void showMessageLoose(bool timeout) {
    MenuView.show().messageLose(timeout).render();
    this.listenGoToMenuButton();
  }

  void showMessageNoSupportForGyro() {
    MenuView.show().messageNoSupportForGyro().render();
    this.listenGoToMenuButton();
  }

  void showWelcomeScreenOnMobileDevices() {
    MenuView.show().messageWelcomeScreenOnMobile().render(); // TODO replace with welcomeScreen
    this.listenGoToMenuButtonAndRequestFullscreen();
  }

  void showMessageChooseLevels(int nrAvailableLevels, int reachedLevel) {
    MenuView.show().messageChooseLevels(nrAvailableLevels, reachedLevel).render();
    this.listenGoToMenuButton();
    this.listenAllLevelButtons(reachedLevel);
  }

  void showMessageCredits() {
    MenuView.show().messageCredits().render();
    this.listenGoToMenuButton();
    this.listenDonateButton();
  }

  void showNoSuchLevel(int level) {
    MenuView.show().messageNoSuchLevel(level).render();
    this.listenPreviousLevelButton();
  }

  int getActiveLevel() {
    return this._activeLevel;
  }

  void setActiveLevel(int activeLevel) {
    this._activeLevel = activeLevel;
    if (activeLevel > this.getReachedLevel()) {
      this.setReachedLevel(activeLevel);
    }
  }

  int getReachedLevel() {
    if(this._reachedLevelStorage.containsKey('reachedLevel')) {
      return int.parse(this._reachedLevelStorage['reachedLevel']);
    }
    return this._reachedLevel;
  }

  void setReachedLevel(int reachedLevel) {
    this._reachedLevelStorage["reachedLevel"] = reachedLevel.toString();
    this._reachedLevel = reachedLevel;
  }

  String _getLevelIntrusction(int level) {
    switch (level) {
      case 1:
        return "Get in Rhythm and catch all dots to win! ";
      case 2:
        return "This time try to avoid the bricks and survive until the end!";
      case 3:
        return "Choose wisely. The barriers are your friends.";
      default:
        return "Now you are on your own. Try to reach level 10!";
    }
  }

}
