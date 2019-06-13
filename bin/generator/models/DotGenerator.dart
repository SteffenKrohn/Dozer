import 'dart:math';
import '../generator_model.dart';

/// Generates a string representation of a [Dot]
class DotGenerator extends EntityGenerator {

  String type = "dot";
  /// The value the generated [Dot] will have
  int value;

  /// The minimum value the [Dot] can have
  int minValue = 1;
  /// The maximum value the [Dot] can have
  int maxValue = 10;

  /// Constructor for this Generator takes the [time] and [x] coordinate
  /// Optionally a [value] can be provided. If no value is provided a random value
  /// will be generated within the boundaries of [minValue] and [maxValue].
  DotGenerator(int time, double x, {int value = null}) {
    this.time = time;
    this.x = x;
    this.value = value;
    if (null == this.value) {
      this.generateValue();
    }
  }

  /// Generated random value within the boundaries of [minValue] and [maxValue].
  void generateValue() {
    this.value = Random().nextInt(this.maxValue - this.minValue) + this.minValue;
  }

  String generate() {
    return
      '{' +
        '"type": "${this.type}",' +
        '"time": ${this.time},' +
        '"x": ${this.x},' +
        '"value": ${this.value}'
      '}'
    ;
  }
}