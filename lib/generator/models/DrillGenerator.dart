part of generator;

/// Generates a string representation of a [Drill]
class DrillGenerator extends EntityGenerator {

  String type = "drill";

  /// Constructor for this Generator takes the [time] and [x] coordinate
  DrillGenerator(int time, double x) {
    this.time = time;
    this.x = x;
  }

  String generate() {
    return
      '{' +
        '"type": "${this.type}",' +
        '"time": ${this.time},' +
        '"x": ${this.x}' +
      '}'
    ;
  }
}