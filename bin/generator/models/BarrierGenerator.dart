import 'dart:math';
import '../generator_model.dart';

/// Generates a string representation of a [Barrier]
class BarrierGenerator extends EntityGenerator {
  String type = "barrier";

  /// The height of the generated [Barrier]
  int height;

  /// The minimum height of the [Barrier]
  int minHeight = 300;

  /// The maximum height of the [Barrier]
  int maxHeight = 3000;

  /// Constructor for this Generator takes the [time] and [x] coordinate
  /// Optionally a height can be provided. If no height is provided a random height
  /// will be generated within the boundaries of [minHeight] and [maxHeight].
  BarrierGenerator(int time, double x, {int height = null}) {
    this.time = time;
    this.x = x;
    this.height = height;
    if (null == this.height) {
      this.generateHeight();
    }
  }

  /// Generated random height within the boundaries of [minHeight] and [maxHeight].
  void generateHeight() {
    this.height = Random().nextInt(this.maxHeight - this.minHeight) + this.minHeight;
  }

  String generate() {
    return '{' +
        '"type": "${this.type}",' +
        '"time": ${this.time},' +
        '"x": ${this.x},' +
        '"height": ${this.height}'
        '}';
  }
}
