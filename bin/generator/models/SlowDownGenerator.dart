import '../generator_model.dart';

/// Generates a string representation of a [SlowDown]
class SlowDownGenerator extends EntityGenerator {
  String type = "slowdown";

  /// Constructor for this Generator takes the [time] and [x] coordinate
  SlowDownGenerator(int time, double x) {
    this.time = time;
    this.x = x;
  }

  String generate() {
    return '{' + '"type": "${this.type}",' + '"time": ${this.time},' + '"x": ${this.x}' + '}';
  }
}
