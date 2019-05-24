part of generator;

class SlowDownGenerator extends EntityGenerator {

  String type = "drill";
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