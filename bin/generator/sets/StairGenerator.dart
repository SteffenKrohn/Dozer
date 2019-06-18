import '../generator_model.dart';
import '../generator_sets.dart';

/// Generator for a combination of [Brick]s shaped like stairs
class StairGenerator extends SetGenerator {
  /// The direction the stairs will face. Only "left" and "right" are supported.
  String _direction;

  /// Constructor takes only the [time] as a parameter
  StairGenerator(int time) {
    this.time = time;
  }

  /// Sets the direction of the stairs to the right
  StairGenerator left() {
    _direction = "left";
    return this;
  }

  /// Sets the direction of the stairs to the left
  StairGenerator right() {
    _direction = "right";
    return this;
  }

  String generate() {
    if (null == _direction) {
      throw Exception("Direction for StairGenerator has to be set.");
    }
    BrickGenerator g1;
    BrickGenerator g2;
    BrickGenerator g3;

    if (_direction == "right") {
      g1 = BrickGenerator(time, 0.0);
      g2 = BrickGenerator(time + 160, 1 / 3);
      g3 = BrickGenerator(time + 320, 2 / 3);
    } else if (_direction == "left") {
      g1 = BrickGenerator(time, 1.0);
      g2 = BrickGenerator(time + 160, 2 / 3);
      g3 = BrickGenerator(time + 320, 1 / 3);
    }
    return g1.generate() + "," + g2.generate() + "," + g3.generate();
  }
}
