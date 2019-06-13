import '../generator_model.dart';

class DrillGenerator extends EntityGenerator {

  String type = "drill";
  int value;

  DrillGenerator(int time, double x) {
    this.time = time;
    this.x = x;
    this.value = value;
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