import 'dart:html';

import 'Element.dart' as elem;

class Dozer extends elem.Element {

  /** The current score / length of the dozer */
  int score;
  List<int> tail;

  /**
   * Creates a Dozer object with the id  dozer and the given score
   */
  Dozer(int score) {
    this.id = "dozer";
    this.score = score;
  }

  void update() {
    this.getView().text = this.score.toString();

    // TODO Make prettier
    dx = this.dx;
    // Left border
    if (querySelector("#dozer").getBoundingClientRect().left + dx < 0) {
      dx = querySelector("#dozer").getBoundingClientRect().left * -1;
    }
    if (this.x + dx + this.getView().getBoundingClientRect().width > querySelector("#lane").getBoundingClientRect().right) {
      dx = querySelector("#lane").getBoundingClientRect().right - querySelector("#dozer").getBoundingClientRect().right;
    }
    this.dx = dx;
    super.update();
  }

  /**
   * Changes the score of the dozer
   */
  void changeScore(int change) {
    // TODO
  }

  /**
   * Returns a string representation of the dozer as an html element
   */
  String toString() {
    return "<div class='element dozer' id=${this.id}> ${this.score.toString()} </div>";
  }
}