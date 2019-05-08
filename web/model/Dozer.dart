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
    this.id = 0;
    this.score = score;
  }

  void update() {
    // TODO Make prettier
    dx = this.dx;
    // Left border

    if (this.x + dx < 0) {
      dx = this.x * -1;
    }
    // TODO bad querySelector
    if (this.x + dx + this.width > querySelector("#lane").getBoundingClientRect().right) {
      dx = querySelector("#lane").getBoundingClientRect().right - this.x + this.width;
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