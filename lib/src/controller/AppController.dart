part of dozergame;

/// The [AppController] is the main controller of the app. It contains all the listeners
/// for the buttons, can make the views switch and can start levels.
class AppController {

  /// The Target Framerate of the application in hz
  static const int framerate = 40;

  /// The 'number of reached level' key for the local storage
  static const String _reachedLevelKey = "reachedLevel_v2";
  /// The 'highscore for level x' key for the local storage.
  /// Using this key alone is not sufficient.
  /// You have to append a String with the level number.
  static const String highscoreLevelKey = "highscore_level_v2_";
  /// The 'number of tries for level x' key for the local storage.
  /// Using this key alone is not sufficient.
  /// You have to append a String with the level number.
  static const String triesLevelKey = "tries_level_v2_";

  /// The reference of the local storage
  final Storage _localStorage = window.localStorage;

  /// This is the level the user would start on the main page 'levelOverview'.
  /// After the app startup it's set to the reached Level and after the click
  /// on one specific level in the 'chooseLevelView' it's set to the specific one.
  int _activeLevel = 1;
  /// The reached Level of the user
  int _reachedLevel = 1;
  /// This is the number of all available level
  int _nrAvailableLevels = 500;
  /// Is the gyro sensor retrieval available
  bool gyroAvailable = false;

  /// TODO will be deleted later
  static const String _userIdKey = "userId";
  int _userId;
  String _nick = "";

  /// This method initialises the app at startup
  void startup() {

    // get reached level from local storage
    if(this._localStorage.containsKey(_reachedLevelKey)) {
      this._reachedLevel = int.parse(this._localStorage[_reachedLevelKey]);
    }
    this._activeLevel = this.getReachedLevel();

    // TODO will be deleted later
    if(this._localStorage.containsKey(_userIdKey)) {
      this._userId = int.parse(this._localStorage[_userIdKey]);
    }
    // in the very first start the used ID will be assigned and stored
    if(this._userId == null) {
      this._userId = Random.secure().nextInt(pow(2, 32));
      this._localStorage[_userIdKey] = this._userId.toString();
    }

    // TODO change after final presentation
    /*// Check gyro sensor support and show first screen
    window.onDeviceOrientation.first.then((e) {
      this.gyroAvailable = e.gamma != null ? true : false;
      if(!this.gyroAvailable) {
        this.showMessageNoSupportForGyro();
      } else if((window.innerHeight / window.screen.height) < 0.92) {
        // shown if not started in fullscreen (0.92 because on iphone fs is not
        // possible and with the notch it's even smaller
        this.showWelcomeScreenOnMobileDevices();
      } else {
        // shown if already in fullscreen, e.g. web app
        this.showLevelOverview();
      }
    });*/
    window.onDeviceOrientation.first.then((e) {
      this.gyroAvailable = e.gamma != null ? true : false;
      if(!this.gyroAvailable) {
        this.showMessageNoSupportForGyro();
      } else {
        this.showWelcomeScreenOnMobileDevices();
      }
    });
  }

  /// Starts the [_activeLevel]
  void startNextLevel() {
    LevelController.loadAndStart(this, this.getActiveLevel());
  }

  /// Listens to the 'Go To Menu Button' which directs the user to the main page
  void listenGoToMenuButton() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showLevelOverview();
    });
  }

  /// Listens to the 'Go To Menu Button' which directs the user to the main page
  /// and requests the fullscreen on the mobile device.
  /// Will be called only if the 'messageWelcomeScreenOnMobile' was called before.
  void listenGoToMenuButtonAndRequestFullscreen() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {

      // TODO delete after final presentation
      InputElement nickInput = querySelector("#nickInput");
      this._nick = nickInput.value;
      print(this._nick);

      this.showLevelOverview();
      try {
        document.body.requestFullscreen();
        window.screen.orientation.lock("portrait-primary");
      } catch (e) {
        print("You better use Chrome ;)");
      }
    });
  }

  /// Listens to the 'start level button' click events and starts the next level
  /// according to [_activeLevel]
  void listenStartLevelButton() {
    querySelector("#button_start_level").onClick.listen((MouseEvent e) {
      this.startNextLevel();
    });
  }

  /// Listens to the 'next level button' click events, increases the [_activeLevel]
  /// and redirects the user to the 'levelOverview' if the new level is available.
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

  /// Listens to the 'go to previous level button' click events and decreases the [_activeLevel].
  /// This method will only be called when the 'messageNoSuchLevel' was shown.
  void listenPreviousLevelButton() {
    querySelector("#button_pevious_level").onClick.listen((MouseEvent e) {
      this.setActiveLevel(this.getActiveLevel() - 1);
      this.showLevelOverview();
    });
  }

  /// Listens to the 'choose level button' click events and shows the 'chooseLevelsView'
  void listenChooseLevelButton() {
    querySelector("#button_choose_levels").onClick.listen((MouseEvent e) {
      this.showChooseLevelsView(this._nrAvailableLevels, this.getReachedLevel());
    });
  }

  /// Listens for all the 'level buttons' click events,
  /// sets the new [_activeLevel] accordingly and shows the 'levelOverview'.
  void listenAllLevelButtons(int reachedLevel) {
    for (int i = 0; i < this.getReachedLevel(); i++) {
      querySelector("#level-${i + 1}").onClick.listen((Event e) {
        e.preventDefault();
        this.setActiveLevel(i + 1);
        this.showLevelOverview();
      });
    }
  }

  /// Listens for the 'credits button' click events and shows the credits view
  void listenCreditsButton() {
    querySelector("#button_credits").onClick.listen((MouseEvent e) {
      this.showCreditsView();
    });
  }

  /// Listens to the 'donate button' click events and opens a new window
  /// directing to paypal
  void listenDonateButton() {
    querySelector("#donate-button").onClick.listen((MouseEvent e) {
      window.open("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EW22STTHR8DK2&source=url",
          "Donate on PayPal");
    });
  }

  /// Shows the 'levelOverview' and activates the button click listener for
  /// [listenStartLevelButton]
  /// [listenChooseLevelButton]
  /// [listenCreditsButton]
  void showLevelOverview() {
    MenuView.show().levelOverview(this.getActiveLevel(), _getLevelInstruction(this.getActiveLevel())).render();
    this.listenStartLevelButton();
    this.listenChooseLevelButton();
    this.listenCreditsButton();
  }

  /// Shows the 'MessageWin' and activates the button click listener for
  /// [listenNextLevelButton]
  void showMessageWin(int score, bool newHighscore, int tries) {
    MenuView.show().messageWin(score, newHighscore, tries).render();
    this.listenNextLevelButton();
  }

  /// Shows the 'MessageLoose' and activates the button click listener for
  /// [listenGoToMenuButton]
  void showMessageLoose(bool timeout) {
    MenuView.show().messageLose(timeout).render();
    this.listenGoToMenuButton();
  }

  /// Shows the 'MessageNoSupportForGyro' on desktop devices and activates the
  /// button click listener for [listenGoToMenuButton]
  void showMessageNoSupportForGyro() {
    MenuView.show().messageNoSupportForGyro().render();
    this.listenGoToMenuButton();
  }

  /// Shows the 'WelcomeScreenOnMobileDevices' and activates the button click
  /// listener for [listenGoToMenuButtonAndRequestFullscreen]
  void showWelcomeScreenOnMobileDevices() {
    MenuView.show().messageWelcomeScreenOnMobile().render();
    this.listenGoToMenuButtonAndRequestFullscreen();
  }

  /// Shows the 'ChooseLevelsView' and activates the button click listener for
  /// [listenGoToMenuButton]
  /// [listenAllLevelButtons]
  void showChooseLevelsView(int nrAvailableLevels, int reachedLevel) {
    MenuView.show().chooseLevelsView(nrAvailableLevels, reachedLevel).render();
    this.listenGoToMenuButton();
    this.listenAllLevelButtons(reachedLevel);
  }

  /// Shows the 'CreditsView' and activates the button click listener for
  /// [listenGoToMenuButton]
  /// [listenDonateButton]
  void showCreditsView() {
    MenuView.show().creditsView().render();
    this.listenGoToMenuButton();
    this.listenDonateButton();
  }

  /// Shows the 'NoSuchLevelView' and activates the button click listener for
  /// [listenPreviousLevelButton]
  void showNoSuchLevel(int level) {
    MenuView.show().messageNoSuchLevel(level).render();
    this.listenPreviousLevelButton();
  }

  /// Returns the [_activeLevel]
  int getActiveLevel() {
    return this._activeLevel;
  }

  /// Sets the [_activeLevel] to the passed integer value. If this value is bigger
  /// than the [_reachedLevel] then the reached level will be increased accordingly.
  void setActiveLevel(int activeLevel) {
    this._activeLevel = activeLevel;
    if (activeLevel > this.getReachedLevel()) {
      this.setReachedLevel(activeLevel);
    }
  }

  /// Returns the [_reachedLevel]
  int getReachedLevel() {
    return this._reachedLevel;
  }

  /// Returns the level specific highscore.
  int getHighscore(int level) {
    int hs = 0;
    String key = highscoreLevelKey + level.toString();
    if(this._localStorage.containsKey(key)) {
      hs = int.parse(this._localStorage[key]);
    }
    return hs;
  }

  /// Sets the [_reachedLevel] member variable and the according value in the
  /// local storage.
  void setReachedLevel(int reachedLevel) {
    this._localStorage[_reachedLevelKey] = reachedLevel.toString();
    this._reachedLevel = reachedLevel;
  }

  /// Returns the level instructions for the first 4 levels and displays the
  /// score for greater levels.
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

  /// TODO will be deleted later
  void sendCompetitionStats(int level, int score, int tries) {
    if(this._nick != "") {
      String body = "{'fields':{"
          "'userId':{'integerValue': '${this._userId}'},"
          "'nick':{'stringValue': '${this._nick}'},"
          "'timestamp':{'timestampValue': '${DateTime.now()
          .toUtc()
          .toIso8601String()}'},"
          "'reachedLevel': {'integerValue': '${this._reachedLevel}'},"
          "'score': {'integerValue': '$score'},"
          "'level': {'integerValue': '$level'},"
          "'tries': {'integerValue': '$tries'}"
          "}}";

      HttpRequest.request(
          "https://firestore.googleapis.com/v1/projects/dozer-tcb-jsk/databases/(default)/documents/competition",
          method: "POST",
          sendData: body,
          requestHeaders: {
            'Content-Type': 'application/json; charset=UTF-8'
          }).then((HttpRequest resp) {
        // print(resp.responseText);
        print("sent competition stats");
      }).catchError((e) => print(e));
    }
  }

}
