import 'dart:math';
import '../generator_model.dart';

class DotGenerator extends EntityGenerator {

  String type = "dot";
  int value;

  int minValue = 1;
  int maxValue = 10;

  DotGenerator(int time, double x, {int value = null}) {
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