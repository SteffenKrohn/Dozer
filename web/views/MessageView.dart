import 'dart:html';

class MessageView {

  static void showMessageWin(int score, int seconds) {
    String html  = "<div id='message'>"
        "<h1>You won!</h1>"
        "<h2>You reached a score of $score in only $seconds seconds</h2>"
        "<button id='button_to_menu'>Go To Menu</button>"
        "<button id='button_next_level'>Next Level</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageLoose(int score) {
    String out;
    if(score > 0) {
      out = "Be faster and grow your dozer bigger next time!";
    } else {
      out = "Your Dozer did not make it, avoid the dangerous bricks next time!";
    }

    String html  = "<div id='message'>"
        "<h1>You Loose.</h1>"
        "<h2>$out</h2>"
        "<button id='button_to_menu'>Go To Menu</button>"
        "<button id='button_next_level'>Try Again</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageNoSupportForGyro() {
    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<h2>Sadly your device does not support motion control.</h2>"
        "<h3>Controlling the Dozer is only possible with the arrow buttons on your keyboard. "
        "But you can scan the QR-Code to play it on your smartphone!</h3>"
        "<button id='button_to_menu'>It's Ok</button>"
        "<button id='button_qr_code'>Show QR-Code</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageQRCode() {
    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<img src=\"../images/qr-code.jpg\">"
        "<h3>Get your Smartphone out and scan the QR-Code to play with Motion Control!</h3>"
        "<button id='button_to_menu'>Go To Menu</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageHelp(bool gyroAvailable) { // TODO maybe a better explanation and even with an image
    String descr = gyroAvailable ? "tilting your phone": "pressing the left and right arrow keys. Move straight on by pressing the upper key";

    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<h3>You move the dozer by $descr. In a limited time, "
        "make the dozer grow by collecting the red dots. "
        "But be careful because there will be obstacles like bricks and barriers.</h3>"
        "<button id='button_to_menu'>Back</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageCredits() {
    String html  = "<div id='message'>"
        "<h1>Dozer</h1>"
        "<h3>Creators, License, Fonts, Participants will be stated here later</h3>" // TODO
        "<button id='button_to_menu'>Back</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }

  static void showMessageChooseLevels(int nrAvailableLevels, int reachedLevel) {
    String html  = "<div id='message'><h3>Your unlocked levels!</h3><table>";

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