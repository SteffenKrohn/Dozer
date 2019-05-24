part of generator;

class BrickGenerator extends EntityGenerator {

  String type = "brick";
  int value;

  int minValue = 1;
  int maxValue = 21;

  BrickGenerator(int time, double x, {int value = null}) {
    this.time = time;
    this.x = x;
    this.value = value;
    if (null == this.value) {
      this.generateValue();
    }
  }

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