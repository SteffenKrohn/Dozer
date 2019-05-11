import 'dart:html';

class MenuView {

  static void show() {
    String html  = "<div id='menu'>"
        "<h1>Dozer</h1>"
        "<h2>The Game - (logo?)</h2>"
        "<button id='button_next_level'>Play</button>"
        "<button id='button_choose_levels'>Choose a Level</button>"
        "<button id='button_help'>Help</button>"
        "<button id='button_credits'>Credits</button>"
        "<p>Hier könnte ihre Werbung stehen.</p>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }
}