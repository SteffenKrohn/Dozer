part of generator;

class TrapGenerator extends SetGenerator {

  TrapGenerator(int time) {
    this.time = time;
  }

  String generate() {
    int lane = Random().nextInt(4);

    String output = "";
    BarrierGenerator b;
    if (lane != 1) {
      double x = lane * 0.25;
      b = BarrierGenerator(time, x);
      b.height = 1000;
      output += b.generate() + ",";
    }
    if (lane != 4) {
      double x = lane * 0.25 + 0.25;
       b = BarrierGenerator(time, x);
       b.height = 1000;
      output += b.generate() + ",";
    }
    output += DotGenerator(time + 100, lane / 3 + 0.12).generate() + ",";
    output += BrickGenerator(time + 1000, lane / 3).generate();
    return output;
  }
}