import 'dart:html';
import 'Element.dart' as m;

/**
 * Representation of a Brick
 * This is used to build obstacles for the player
 * Upon hitting the Brick, the score will be decreased
 */
class Brick extends m.Element {

  /** The value is displayed and used to decrease the score */
  int value;

  /**
   * Constructs a new Brick with all necessary information
   */
  Brick(String id, int x, int y, int value) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.value = value;
  }

  /**
   * Updates the DOM element with current values
   */
  void update() {
    super.update();
    querySelector('#'+this.id).text = this.value.toString();
  }

  /**
   * Returns a string representing as a DOM element of this Brick
   */
  String toString() {
    return "<div class='element brick' id=${this.id}> ${this.value} </div>";
  }
}