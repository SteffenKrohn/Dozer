part of generator;

/// Generates a string representation of a [Brick]
class BrickGenerator extends EntityGenerator {

  String type = "brick";
  /// The value the generated [Brick] will have
  int value;

  /// The minimum value the [Brick] can have
  int minValue = 1;
  /// The maximum value the [Brick] can have
  int maxValue = 21;

  /// Constructor for this Generator takes the [time] and [x] coordinate
  /// Optionally a [value] can be provided. If no value is provided a random value
  /// will be generated within the boundaries of [minValue] and [maxValue].
  BrickGenerator(int time, double x, {int value = null}) {
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