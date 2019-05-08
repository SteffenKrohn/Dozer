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
  Brick(int id, int x, int value) {
    this.id = id;
    this.x = x;
    this.value = value;
    this.width = 250;
    this.height= 80;
  }

  /**
   * Returns a string representing as a DOM element of this Brick
   */
  String toString() {
    return "<div class='element brick' id=${this.id}> ${this.value} </div>";
  }

  @override
  void hitBy(m.Element e) {
    // TODO: implement hitBy
  }
}