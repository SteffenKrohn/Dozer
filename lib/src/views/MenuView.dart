part of dozergame;

/// This is the View representation of our app, but not the game itself.
/// This class is used for the menu navigation.
/// These [MenuView]'s are only rendered after click events or when a level is over.
/// So they are static once they are called.
class MenuView {

  /// This is the content what one [MenuView] will display when it's rendered
  HtmlElement content;

  /// Factory method which returns a new [MenuView].
  static MenuView show() {
    return MenuView();
  }

  /// The method will change the DOM-Tree according to the [content]
  void render() {
    querySelector("body").setInnerHtml(
        "<div id='menu'></div>"
    );
    querySelector("#menu").insertAdjacentElement("afterbegin", this.content);
  }

  /// Returns a new [HeadingElement] with the Dozer Title.
  /// This method is used on every MenuView, with corporate identity in mind ;)
  HeadingElement getLogo() {
    HeadingElement logo = HeadingElement.h1();
    logo.setInnerHtml("Dozer");
    logo.setAttribute("id", "dozer-logo");
    return logo;
  }

  /// Returns a Button Box for two Buttons on the bottom of the view
  DivElement getBottomButtonBox() {
    DivElement div = DivElement();
    div.setAttribute("class", "button-box");
    return div;
  }

  /// The [levelOverview] is the main view of all the [MenuView]'s. On it the
  /// active level can be started, the number of the active level is displayed,
  /// it's highscore, and the buttons to get to the credits and choose level view.
  MenuView levelOverview(int level, String levelInstruction) {

    DivElement div = DivElement();
    div.setAttribute("id", "button_start_level");
    div.setAttribute("class", "message");

    div.append(getLogo());
    div.append(HRElement());

    HeadingElement levelTitle = HeadingElement.h2();
    levelTitle.appendText("Level");
    div.append(levelTitle);

    HeadingElement levelId = HeadingElement.h1();
    levelId.setInnerHtml("$level");
    levelId.style.marginTop = "1vh";
    levelId.style.textShadow = "0.04em 0.04em rgb(137,137,137)";
    div.append(levelId);

    ParagraphElement instructions = ParagraphElement();
    instructions.appendText(levelInstruction);
    div.append(instructions);

    div.append(HRElement());

    ParagraphElement tapToPlay = ParagraphElement()
      ..setAttribute("class", "tap-me")
      ..appendText("Tap To Play");
    div.append(tapToPlay);

    ButtonElement chooseLevel = ButtonElement()
      ..setAttribute("id", "button_choose_levels")
      ..setAttribute("class", "upper-bottom-button")
      ..appendText("Choose a Level");

    ButtonElement credits = ButtonElement()
      ..setAttribute("id", "button_credits")
      ..setAttribute("class", "lower-bottom-button")
      ..appendText("Credits");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);
    
    DivElement buttonBox = getBottomButtonBox();

    buttonBox.setAttribute("style", "height: 20%");
    chooseLevel.setAttribute("style", "height: 50%");
    credits.setAttribute("style", "height: 50%");
    buttonBox.append(chooseLevel);
    buttonBox.append(credits);
    
    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  /// This is the view, which gets displayed when the user wins a level.
  /// If he reaches a new highscore, the highscore and the number of tries are
  /// displayed. Else just the score is displayed. This can be changed easily
  /// because the parameter 'tries' is mandatory.
  MenuView messageWin(int score, bool newHighscore, int tries) {

    String msgScore = newHighscore ? "New Highsore" : "Your Score";

    DivElement div = DivElement();
    div.setAttribute("id", "button_next_level");
    div.setAttribute("class", "message");

    div.append(getLogo());
    div.append(HRElement());

    HeadingElement levelTitle = HeadingElement.h2();
    levelTitle.appendText("You Won!");
    div.append(levelTitle);

    SpanElement msgText = SpanElement();
    msgText.appendText(msgScore);
    msgText.style.fontStyle = "italic";
    div.append(msgText);

    ParagraphElement scoreParagraph = ParagraphElement()
      ..appendText(score.toString())
      ..setAttribute("class", "highscore");
    div.append(scoreParagraph);

    if(newHighscore) {
      String msgTries = tries > 1 ? "It took you $tries tries!" : "Unbelievable, with your first try!";
      ParagraphElement triesParagraph = ParagraphElement()
        ..appendText(msgTries);
      div.append(triesParagraph);
    }

    div.append(HRElement());

    ParagraphElement tapToAdvance = ParagraphElement()
      ..setAttribute("class", "tap-me")
      ..appendText("Tap To Continue");
    div.append(tapToAdvance);

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    this.content = outerDiv;
    return this;
  }

  /// This is the view which gets displayed when the user looses a level. If he
  /// didn't make it in time, then a different loose message gets displayed as
  /// he would get if he looses because his dozer ran into a brick.
  MenuView messageLose(bool timeout) {

    String msg;
    if(timeout) {
      msg = "Be faster and grow your dozer bigger next time!";
    } else {
      msg = "Your Dozer did not make it, avoid the dangerous bricks next time!";
    }

    DivElement div = DivElement();
    div.setAttribute("id", "button_to_menu");
    div.setAttribute("class", "message");

    div.append(getLogo());
    div.append(HRElement());

    HeadingElement levelTitle = HeadingElement.h2();
    levelTitle.appendText("You Lost!");
    div.append(levelTitle);

    SpanElement msgText = SpanElement();
    msgText.appendText(msg);
    msgText.style.fontStyle = "italic";
    div.append(msgText);

    HRElement hr = HRElement();
    hr.style.marginTop = "3vh";
    div.append(hr);

    ParagraphElement tapToAdvance = ParagraphElement()
      ..setAttribute("class", "tap-me")
      ..appendText("Tap To Continue");
    div.append(tapToAdvance);

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    this.content = outerDiv;
    return this;
  }

  /// This message view will be displayed mainly on desktop devices without
  /// the gyro sensor support or on mobile devices where the device orientation
  /// is disabled. It displays the QR-Code to give the user the chance to play
  /// it on another device. Else he can also play it on the current device.
  MenuView messageNoSupportForGyro() {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("Oh No! On this device motion control is not available.");
    div.append(upperText);

    ImageElement qrImage = ImageElement();
    qrImage.setAttribute("src", "resources/qr-code.jpg");
    div.append(qrImage);

    ParagraphElement lowerText = ParagraphElement();
    lowerText.appendText("Scan the QR-Code or play with your arrow keys.");
    div.append(lowerText);

    div.append(HRElement());

    ButtonElement button = ButtonElement()
      ..setAttribute("id", "button_to_menu")
      ..setAttribute("class", "lower-bottom-button")
      ..appendText("Let me play anyway");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    DivElement buttonBox = getBottomButtonBox();
    buttonBox.setAttribute("style", "height: 10%");
    button.setAttribute("style", "height: 100%");
    buttonBox.append(button);

    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  /// This message will only be displayed if the user accomplishes the last
  /// available level. Which at the moment, with [AppController._nrAvailableLevels]
  /// levels, shouldn't happen.
  MenuView messageNoSuchLevel(int level) {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("The level ${level} is not available yet.");
    div.append(upperText);

    div.append(HRElement());

    ButtonElement button = ButtonElement()
      ..setAttribute("id", "button_pevious_level")
      ..setAttribute("class", "lower-bottom-button")
      ..appendText("Return to last Level");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    DivElement buttonBox = getBottomButtonBox();
    buttonBox.setAttribute("style", "height: 10%");
    button.setAttribute("style", "height: 100%");
    buttonBox.append(button);

    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  /// This welcome view will only be displayed on mobile devices where the
  /// device orientation is available but the app was not started in fullscreen
  /// mode. This view is only used for a user interaction (namely a click event)
  /// to request the fullscreen mode. Since we give the opportunity to add the
  /// Webapp to the homescreen, this view should not be displayed often.
  MenuView messageWelcomeScreenOnMobile() {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    /*div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("Welcome to Dozer - Have fun!");
    div.append(upperText);

    div.append(HRElement());

    ParagraphElement tapToAdvance = ParagraphElement()
      ..setAttribute("class", "tap-me")
      ..appendText("Tap To Continue");
    div.append(tapToAdvance);

    DivElement outerDiv = DivElement()
      ..setAttribute("id", "button_to_menu");
    outerDiv.append(div);*/

    // TODO change back after final presentation
    HRElement hr = HRElement()
      ..style.marginTop = "50pt";
    div.append(hr);

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("Enter your nickname to take part in the competition! Otherwise, leave it empty.");
    div.append(upperText);

    div.append(HRElement());

    InputElement textbox = InputElement()
      ..setAttribute("id", "nickInput")
      ..placeholder = "Your Nickname"
      ..style.margin = "auto"
      ..style.marginTop = "4vh"
      ..style.height = "20pt"
      ..style.width = "120pt"
      ..maxLength = 12
      ..style.fontSize = "14pt";
    div.append(textbox);

    ButtonElement button = ButtonElement()
      ..setAttribute("id", "button_to_menu")
      ..setAttribute("class", "lower-bottom-button")
      ..appendText("Let's go!");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    DivElement buttonBox = getBottomButtonBox();
    buttonBox.setAttribute("style", "height: 10%");
    button.setAttribute("style", "height: 100%");
    buttonBox.append(button);

    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  /// This is the credits view to display the creators of the game and to give a
  /// donations opportunity.
  MenuView creditsView() {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("Built with \u{2764} in Lübeck.");
    div.append(upperText);

    ParagraphElement middleText = ParagraphElement();
    middleText.appendText("Jan Steffen Krohn & Tom Christopher Böttger");
    div.append(middleText);

    div.append(HRElement());

    ParagraphElement donateText = ParagraphElement()
      ..setAttribute("class", "donate-text")
      ..appendText("Help us making Dozer even better and donate us a coffee :-)");
    div.append(donateText);

    ImageElement paypal = ImageElement(src: "resources/paypal.png");

    SpanElement textDonate = SpanElement();
    textDonate.text = "Donate";

    ButtonElement buttonDonate = ButtonElement()
      ..setAttribute("id", "donate-button")
      ..setAttribute("class", "upper-bottom-button")
      ..append(paypal)
      ..append(textDonate);

    ButtonElement buttonToMenu = ButtonElement()
      ..setAttribute("id", "button_to_menu")
      ..setAttribute("class", "lower-bottom-button")
      ..appendText("Return");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    DivElement buttonBox = getBottomButtonBox();
    buttonBox.setAttribute("style", "height: 20%");
    buttonDonate.setAttribute("style", "height: 50%");
    buttonToMenu.setAttribute("style", "height: 50%");
    buttonBox.append(buttonDonate);
    buttonBox.append(buttonToMenu);

    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  /// This is the view where the user can choose between all the levels he
  /// already unlocked by accomplishing the levels. All levels are displayed
  /// as a button with the corresponding level number in it.
  MenuView chooseLevelsView(int nrAvailableLevels, int reachedLevel) {
    DivElement div = DivElement()
      ..setAttribute("class", "message")
      ..append(getLogo())
      ..append(HRElement());

    DivElement chooseLevelWrapper = DivElement()
      ..setAttribute("class", "choose-level-wrapper");

    for (int i = 0; i < nrAvailableLevels; i++) {
      ButtonElement levelButton = ButtonElement()
          ..setAttribute("value", (i + 1).toString())
          ..setAttribute("class", "choose-level ${i < reachedLevel ? "reached" : ""}")
          ..setAttribute("id", "level-${i + 1}")
          ..appendText((i + 1).toString());

      chooseLevelWrapper.append(levelButton);
    }
    div.append(chooseLevelWrapper);

    ButtonElement button = ButtonElement()
      ..setAttribute("id", "button_to_menu")
      ..setAttribute("class", "lower-bottom-button")
      ..appendText("Return");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    DivElement buttonBox = getBottomButtonBox();
    buttonBox.setAttribute("style", "height: 10%");
    button.setAttribute("style", "height: 100%");
    buttonBox.append(button);

    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }
}