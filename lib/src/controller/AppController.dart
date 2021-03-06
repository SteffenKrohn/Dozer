import 'dart:html';
import 'dart:js';

import 'package:dozergame/controller.dart';
import 'package:dozergame/view.dart';

/// The [AppController] is the main controller of the app. It contains all the listeners
/// for the buttons, can make the views switch and can call the load method of
/// the [LevelController] for starting a level.
class AppController {
  /// The Target Framerate of the application in hz
  static const int framerate = 40;

  /// The 'number of reached level' key for the local storage
  static const String _reachedLevelKey = "reachedLevel";

  /// The 'highscore for level x' key for the local storage.
  /// Using this key alone is not sufficient.
  /// You have to append a String with the level number.
  static const String highscoreLevelKey = "highscore_level_";

  /// The 'number of tries for level x' key for the local storage.
  /// Using this key alone is not sufficient.
  /// You have to append a String with the level number.
  static const String triesLevelKey = "tries_level_";

  /// The reference of the local storage
  final Storage _localStorage = window.localStorage;

  /// This is the level the user would see on the main page 'levelOverview'.
  /// After the app startup it's set to the reached Level and after the click
  /// on one specific level in the 'chooseLevelView' it's set to the specific one.
  int _activeLevel = 1;

  /// The reached Level of the user
  int _reachedLevel = 1;

  /// This is the number of all available level
  int _nrAvailableLevels = 500;

  /// Is the gyro sensor retrieval available
  bool gyroAvailable = false;

  /// This method initialises the app at startup
  void startup() {
    // get reached level from local storage
    if (this._localStorage.containsKey(_reachedLevelKey)) {
      this._reachedLevel = int.parse(this._localStorage[_reachedLevelKey]);
    }
    this._activeLevel = this.getReachedLevel();

    // (07/2020) Changed the flow because on iOS 13+ the permission for gyro sensor needs to be requested
    RegExp isMobileRegEx = new RegExp(r"(iPad)|(iPhone)|(iPod)|(android)|(webOS)|(ipad)|(iphone)|(Android)");
    
    if (!isMobileRegEx.hasMatch(window.navigator.userAgent)) {
      // on desktop devices
      this.showMessageNoSupportForGyro();
    } else if ((window.innerHeight / window.screen.height) < 0.92) {
      // shown if not started in fullscreen (0.92 because on iphone fs is not
      // possible and with the notch it's even smaller)
      this.showWelcomeScreenOnMobileDevices();
      this.gyroAvailable = true;
    } else {
      // shown if already in fullscreen, e.g. web app
      this.showLevelOverview();
      this.gyroAvailable = true;
    }
  }

  /// Starts the [_activeLevel]
  void startNextLevel() {
    LevelController.loadAndStart(this, this._activeLevel);
  }

  /// Listens to the 'Go To Menu Button' which directs the user to the main
  /// menu page 'Level Overview'
  void listenGoToMenuButton() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showLevelOverview();
      context.callMethod("requestiOSGyro");
    });
  }

  /// Listens to the 'Go To Menu Button' which directs the user to the main page
  /// and requests the fullscreen on the mobile device.
  /// Will be called only if the 'messageWelcomeScreenOnMobile' was called before.
  void listenGoToMenuButtonAndRequestFullscreen() {
    querySelector("#button_to_menu").onClick.listen((MouseEvent e) {
      this.showLevelOverview();
      try {
        document.body.requestFullscreen();
        window.screen.orientation.lock("portrait-primary");
      } catch (e) {
        print("You better use Chrome ;)");
      }
      context.callMethod("requestiOSGyro");
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
      this.setActiveLevel(this._activeLevel + 1);
      if (this._activeLevel > this._nrAvailableLevels) {
        this.showNoSuchLevel(this._activeLevel);
      } else {
        this.showLevelOverview();
      }
    });
  }

  /// Listens to the 'go to previous level button' click events and decreases the [_activeLevel].
  /// This method will only be called when the 'messageNoSuchLevel' was shown.
  void listenPreviousLevelButton() {
    querySelector("#button_pevious_level").onClick.listen((MouseEvent e) {
      this.setActiveLevel(this._activeLevel - 1);
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
    MenuView.show().levelOverview(this._activeLevel, _getLevelInstruction(this._activeLevel)).render();
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
    if (this._localStorage.containsKey(key)) {
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
}
