part of generator;

class BarrierGenerator extends EntityGenerator {

  String type = "barrier";
  int height;

  int minHeight = 300;
  int maxHeight = 3000;

  BarrierGenerator(int time, double x, {int height = null}) {
    this.time = time;
    this.x = x;
    this.height = height;
    if (null == this.height) {
      this.generateHeight();
    }
  }

  void generateHeight() {
    this.height = Random().nextInt(this.maxHeight - this.minHeight) + this.minHeight;
  }

  String generate() {
    return
      '{' +
        '"type": "${this.type}",' +
        '"time": ${this.time},' +
        '"x": ${this.x},' +
        '"height": ${this.height}'
      '}'
    ;
  }
}