import 'dart:html';

class MenuView {

  static void show(int level, String levelInstruction) {
    String html  = "<div id='menu'>"
        "<div id='button_next_level'"
        "<h1>Dozer</h1><hr>"
        "<h3>Level</h3>"
        "<h2>$level</h2>"
        "<h3>$levelInstruction</h3><hr>"
        "<p>Tap To Play</p>"
        "</div>"

        "<button id='button_choose_levels'>Choose a Level</button>"
        "<button id='button_credits'>Credits</button>"
        "</div>";

    querySelector("body").setInnerHtml(html);
  }
}