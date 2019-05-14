part of dozergame;

class MessageView {

  static void showMessageWin(int seconds, bool highscore) {
    String out = highscore ? "New Highsore" : "Your Score";
    String html  = "<div id='message'>"
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

  static void showMessageLoose(bool timeout) {
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

  static void showMessageNoSupportForGyro() {
    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<hr>"
        "<h2>Oh No! On this device motion control is not available.</h2>"
        "<img src=\"resources/qr-code.jpg\">"
        "<h3>Scan the QR-Code or play with your arrow keys.</h3><hr>"
        "<button id='button_to_menu'>Let me play anyway</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageCredits() {
    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<hr>"
        "<h3>Creators, License, Fonts, Participants will be stated here later</h3>" // TODO
        "<hr>"
        "<button id='button_to_menu'>Back</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageChooseLevels(int nrAvailableLevels, int reachedLevel) {
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