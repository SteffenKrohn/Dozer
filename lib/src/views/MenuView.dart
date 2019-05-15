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
    div.setAttribute("id", "button_next_level");
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

    ParagraphElement tapToPlay = ParagraphElement();
    tapToPlay.appendText("Tap To Play");
    div.append(tapToPlay);

    ButtonElement chooseLevel = ButtonElement();
    chooseLevel.setAttribute("id", "button_choose_levels");
    chooseLevel.appendText("Choose a Level");

    ButtonElement credits = ButtonElement();
    credits.setAttribute("id", "button_credits");
    credits.appendText("Credits");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);
    
    DivElement buttonBox = getBottomButtonBox();
    buttonBox.append(chooseLevel);
    buttonBox.append(credits);
    
    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  static void messageWin(int seconds, bool highscore) {
    String out = highscore ? "New Highsore" : "Your Score";
    String html  =
        "<div id='menu'>"
        "<hr>"
        "<div id='button_next_level'>"
        "<h1>You won!</h1>"
        "<h3>$out</h3>"
        "<h1>$seconds</h1>"
        "<hr>"
        "</div>"
        "<button id='button_to_menu'>Go To Menu</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void messageLoose(bool timeout) {
    String out;
    if(timeout) {
      out = "Be faster and grow your dozer bigger next time!";
    } else {
      out = "Your Dozer did not make it, avoid the dangerous bricks next time!";
    }

    String html  = "<div id='message'>"
        "<div id='button_next_level'>"
        "<hr>"
        "<h1>You Loose.</h1>"
        "<h2>$out</h2>"
        "<hr>"
        "</div>"
        "<button id='button_to_menu'>Go To Menu</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
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

    ButtonElement button = ButtonElement();
    button.setAttribute("id", "button_to_menu");
    button.appendText("Let me play anyway");

    DivElement outerDiv = DivElement();
    outerDiv.append(div);

    DivElement buttonBox = getBottomButtonBox();
    buttonBox.append(button);

    outerDiv.append(buttonBox);

    this.content = outerDiv;
    return this;
  }

  static void messageCredits() {
    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<hr>"
        "<h3>Creators, License, Fonts, Participants will be stated here later</h3>" // TODO
        "<hr>"
        "<button id='button_to_menu'>Back</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void messageChooseLevels(int nrAvailableLevels, int reachedLevel) {
    String html  = "<div id='message'><h1>Dozer</h1><hr><h3>Your unlocked levels!</h3><table>";

    int columns = 4;
    int nrLevel = 1;
    for(int y = 1; y <= nrAvailableLevels ~/ columns + 1; y++) { // rows
      html += "<tr>";
      for(int x = 1; x <= columns; x++) { // columns
        if(nrLevel <= reachedLevel) {
          html += "<td><button class='button_level_clickable' id='button_level_$nrLevel'>$nrLevel</button></td>";
        } else {
          html += "<td><button class='button_level_greyed_out'>$nrLevel</button></td>";
        }
        nrLevel++;
      }
      html += "</tr>";
    }

    html += "</table><button id='button_to_menu'>Back</button></div>";

    querySelector("body").setInnerHtml(html);
  }
}