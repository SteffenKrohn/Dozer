part of dozergame;

class MenuView {
  
  HtmlElement content;

  static MenuView show() {
    return MenuView();
  }
  
  void render() {
    querySelector("body").setInnerHtml(
        "<div id='menu'></div>"
    );
    querySelector("#menu").insertAdjacentElement("afterbegin", this.content);
  }

  HeadingElement getLogo() {
    var logo = HeadingElement.h1();
    logo.setInnerHtml("Dozer");
    return logo;
  }

  DivElement getBottomButtonBox() {
    DivElement div = DivElement();
    div.setAttribute("class", "button-box");
    return div;
  }

  MenuView levelOverview(int level, String levelInstruction) {

    DivElement div = DivElement();
    div.setAttribute("id", "button_start_level");
    div.setAttribute("class", "message");

    div.append(getLogo());
    div.append(HRElement());

    HeadingElement levelTitle = HeadingElement.h2();
    levelTitle.appendText("Level");
    div.append(levelTitle);

    SpanElement levelId = SpanElement();
    levelId.appendText(level.toString());
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

  MenuView messageWin(int score, bool newHighscore) {

    String msg = newHighscore ? "New Highsore" : "Your Score";

    DivElement div = DivElement();
    div.setAttribute("id", "button_next_level");
    div.setAttribute("class", "message");

    div.append(getLogo());
    div.append(HRElement());

    HeadingElement levelTitle = HeadingElement.h2();
    levelTitle.appendText("You Won!");
    div.append(levelTitle);

    SpanElement msgText = SpanElement();
    msgText.appendText(msg);
    div.append(msgText);

    ParagraphElement scoreParagraph = ParagraphElement()
      ..appendText(score.toString())
      ..setAttribute("class", "highscore");
    div.append(scoreParagraph);

    div.append(HRElement());

    ParagraphElement tapToAdvance = ParagraphElement()
      ..setAttribute("class", "tap-me")
      ..appendText("Tap To Advance");
    div.append(tapToAdvance);

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    this.content = outerDiv;
    return this;
  }

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
    div.append(msgText);

    div.append(HRElement());

    ParagraphElement tapToAdvance = ParagraphElement()
      ..setAttribute("class", "tap-me")
      ..appendText("Tap To Advance");
    div.append(tapToAdvance);

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    this.content = outerDiv;
    return this;
  }

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

  MenuView messageNoSuchLevel(int level) {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("The level ${level} is not available.");
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


  MenuView messageWelcomeScreenOnMobile() {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("Welcome to Dozer - Have fun!");
    div.append(upperText);

    div.append(HRElement());

    DivElement outerDiv = DivElement()
      ..setAttribute("id", "button_to_menu");
    outerDiv.append(div);


    this.content = outerDiv;
    return this;
  }

  MenuView messageCredits() {
    DivElement div = DivElement();
    div.setAttribute("class", "message");
    div.append(getLogo());
    div.append(HRElement());

    ParagraphElement upperText = ParagraphElement();
    upperText.appendText("Built with Love in Lübeck.");
    div.append(upperText);

    ParagraphElement middleText = ParagraphElement();
    middleText.appendText("Jan Steffen Krohn & Tom Christopher Böttger");
    div.append(middleText);

    div.append(HRElement());

    // a little space to put the paypal logo on the bottom but above th buttons TODO nicht super responsiv
    DivElement spaceDiv = DivElement();
    spaceDiv.style.width = "auto";
    spaceDiv.style.marginTop = "35vh";
    div.append(spaceDiv);

    ParagraphElement donateText = ParagraphElement();
    donateText.appendText("Help us making Dozer even better and donate us a coffee :-)");
    div.append(donateText);

    ImageElement paypal = ImageElement(src: "resources/paypal.png");
    paypal.style.position = "relative";
    paypal.style.height = "5vh";
    paypal.style.width = "auto";
    paypal.style.marginTop = "auto";
    paypal.style.marginRight = "100%";
    paypal.style.display = "inline-block";
    //div.append(paypal);

    SpanElement textDonate = SpanElement();
    textDonate.text = "Donate";
    textDonate.style.display = "inline-block";
    textDonate.style.position = "relative";

    ButtonElement buttonDonate = ButtonElement()
      ..setAttribute("id", "button_donate")
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

  MenuView messageChooseLevels(int nrAvailableLevels, int reachedLevel) {
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