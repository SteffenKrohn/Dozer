import '../generator_model.dart';

class SlowDownGenerator extends EntityGenerator {

  String type = "slowdown";
  int value;

  SlowDownGenerator(int time, double x) {
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