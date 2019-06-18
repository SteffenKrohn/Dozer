import '../generator_model.dart';

/// Generates a string representation of a [DoubleUp]
class DoubleUpGenerator extends EntityGenerator {
  String type = "doubleup";

  /// Constructor for this Generator takes the [time] and [x] coordinate
  DoubleUpGenerator(int time, double x) {
    this.time = time;
    this.x = x;
  }

  String generate() {
    return '{' + '"type": "${this.type}",' + '"time": ${this.time},' + '"x": ${this.x}' + '}';
  }
}
