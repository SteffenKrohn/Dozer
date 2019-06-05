part of dozergame;

class AppController {

  LevelController _levelController;

  /** The target framerate in hz */
  static const int framerate = 40;

  final Storage _localStorage = window.localStorage;
  int _activeLevel = 1;
  int _reachedLevel = 1;
  int _userId;
  /// This is the number of all available level
  int _nrAvailableLevels = 500;
  bool gyroAvailable = false;

  void startup() {

    // get local storage
    if(this._localStorage.containsKey('reachedLevel')) {
      this._reachedLevel = int.parse(this._localStorage['reachedLevel']);
    }
    if(this._localStorage.containsKey('userId')) {
      this._userId = int.parse(this._localStorage['userId']);
    }

    this._activeLevel = this.getReachedLevel();
    // TODO dynamic level
    this.showLevelOverview();

    // TODO load levels

    // Check Gyrosensor Support and show first menu screen
    window.onDeviceOrientation.first.then((e) {
      this.gyroAvailable = e.gamma != null ? true : false;
      if(!this.gyroAvailable) {
        this.showMessageNoSupportForGyro();
      } else if((window.innerHeight / window.screen.height) < 92) {
        this.showWelcomeScreenOnMobileDevices();
      } else {
        this.showLevelOverview();
        this._sendVisitStats();
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
      this.showLevelOverview();
    });
  }

  void listenGoToMenuButtonAndRequestFullscreen() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showLevelOverview();
      try {
        document.body.requestFullscreen();
        window.screen.orientation.lock("portrait-primary");

        // delayed call of sendStats because fullscreen request is async
        Future delay = Future.delayed(Duration(milliseconds: 1000), () => true);
        delay.then((d) {
          this._sendVisitStats(isFullscreen: true);
        });
      } catch (e) {
        this._sendVisitStats();
      }
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
        this.showLevelOverview();
      }
    });
  }

  void listenPreviousLevelButton() {
    querySelector("#button_pevious_level").onClick.listen((MouseEvent e) {
      this.setActiveLevel(this.getActiveLevel() - 1);
      this.showLevelOverview();
    });
  }

  void listenChooseLevelButton() {
    querySelector("#button_choose_levels").onClick.listen((MouseEvent e) {
      this.showMessageChooseLevels(this._nrAvailableLevels, this.getReachedLevel());
    });
  }

  void listenAllLevelButtons(int reachedLevel) {
    for (int i = 0; i < this.getReachedLevel(); i++) {
      querySelector("#level-${i + 1}").onClick.listen((Event e) {
        e.preventDefault();
        this.setActiveLevel(i + 1);
        this.showLevelOverview();
      });
    }
  }

  void listenCreditsButton() {
    querySelector("#button_credits").onClick.listen((MouseEvent e) {
      this.showMessageCredits();
    });
  }


  void listenDonateButton() {
    querySelector("#donate-button").onClick.listen((MouseEvent e) {
      window.open("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EW22STTHR8DK2&source=url", "Donate on PayPal");
    });
  }

  void showLevelOverview() {
    MenuView.show().levelOverview(this.getActiveLevel(), _getLevelInstruction(this.getActiveLevel())).render(); // this._levelController.level.instructions TODO waiting for dependency
    this.listenStartLevelButton();
    this.listenChooseLevelButton();
    this.listenCreditsButton();
  }

  void showMessageWin(int score, bool newHighscore, int tries) {
    MenuView.show().messageWin(score, newHighscore, tries).render();
    this.listenNextLevelButton();
  }

  void showMessageLoose(bool timeout) {
    MenuView.show().messageLose(timeout).render();
    this.listenGoToMenuButton();
  }

  void showMessageNoSupportForGyro() {
    MenuView.show().messageNoSupportForGyro().render();
    this.listenGoToMenuButton();
    this._sendVisitStats();
  }

  void showWelcomeScreenOnMobileDevices() {
    MenuView.show().messageWelcomeScreenOnMobile().render();
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
    if(this._localStorage.containsKey('reachedLevel')) {
      return int.parse(this._localStorage['reachedLevel']);
    }
    return this._reachedLevel;
  }

  int getHighscore(int level) {
    int hs = 0;
    if(this._localStorage.containsKey('highscore_level_$level')) {
      hs = int.parse(this._localStorage['highscore_level_$level']);
    }
    return hs;
  }

  void setReachedLevel(int reachedLevel) {
    this._localStorage["reachedLevel"] = reachedLevel.toString();
    this._reachedLevel = reachedLevel;
  }

  String _getLevelInstruction(int level) {
    switch (level) {
      case 1:
        return "Get in Rhythm and catch all dots to win! ";
      case 2:
        return "This time, try to avoid the bricks and survive until the end!";
      case 3:
        return "Choose wisely. The barriers are your friends.";
      case 4:
        return "Now you are on your own. Try to reach Level 500!";
      default:
        int hs = this.getHighscore(level);
        return hs > 0 ? "Highscore: $hs" : "No Highscore yet";
    }
  }

  void _sendVisitStats({bool isFullscreen = false}) {
    // in the very first start the used ID will be assigned and stored
    if(this._userId == null) {
      this._userId = Random.secure().nextInt(pow(2, 32));
      this._localStorage['userId'] = this._userId.toString();
    }

    int width = document.body.getBoundingClientRect().width;
    int height = document.body.getBoundingClientRect().height;
    
    String body = "{'fields':{"
        "'userId':{'integerValue': '${this._userId}'},"
        "'timestamp':{'timestampValue': '${DateTime.now().toUtc().toIso8601String()}'},"
        "'viewWidth':{'integerValue': '${width}'},"
        "'viewHeight': {'integerValue': '${height}'},"
        "'reachedLevel': {'integerValue': '${this._reachedLevel}'},"
        "'isGyroAvailable': {'booleanValue': ${this.gyroAvailable}},"
        "'isFullscreen': {'booleanValue': $isFullscreen}"
        "}}";

    HttpRequest.request(
        "https://firestore.googleapis.com/v1/projects/dozer-tcb-jsk/databases/(default)/documents/visits",
        method: "POST",
        sendData: body,
        requestHeaders: {
          'Content-Type': 'application/json; charset=UTF-8'
        }).then((HttpRequest resp) {
      // print(resp.responseText);
      print("sent visit");
    }).catchError((e) => print(e));
  }

  void sendScoreStats(int level, int score, int tries, bool won, bool abort) {
    String body = "{'fields':{"
        "'userId':{'integerValue': '${this._userId}'},"
        "'timestamp':{'timestampValue': '${DateTime.now().toUtc().toIso8601String()}'},"
        "'reachedLevel': {'integerValue': '${this._reachedLevel}'},"
        "'score': {'integerValue': '$score'},"
        "'level': {'integerValue': '$level'},"
        "'tries': {'integerValue': '$tries'},"
        "'won': {'booleanValue': $won},"
        "'abort': {'booleanValue': $abort},"
        "'isGyroAvailable': {'booleanValue': ${this.gyroAvailable}}"
        "}}";

    HttpRequest.request(
        "https://firestore.googleapis.com/v1/projects/dozer-tcb-jsk/databases/(default)/documents/scores",
        method: "POST",
        sendData: body,
        requestHeaders: {
          'Content-Type': 'application/json; charset=UTF-8'
        }).then((HttpRequest resp) {
      // print(resp.responseText);
      print("sent score $level $score $won $abort");
    }).catchError((e) => print(e));
  }

}
