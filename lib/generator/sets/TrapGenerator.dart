part of generator;

/// Generator for a combination of a [Brick], [Barries]s and a [Dot]
/// The [Dot] is flanked by two [Barrier]s and at ge end is a [Brick].
/// So when the player decides to collect he [Dot] he will also crash into the [Brick]
class TrapGenerator extends SetGenerator {

  /// Constructor takes only the [time] as a parameter
  TrapGenerator(int time) {
    this.time = time;
  }

  String generate() {
    int lane = Random().nextInt(4);

    String output = "";
    BarrierGenerator b;
    // When the trap is on the left or right side of the screen, no barriers
    // will be needed there
    if (lane != 0) {
      double x = lane * 0.25;
      b = BarrierGenerator(time, x);
      b.height = 1000;
      output += b.generate() + ",";
    }
    if (lane != 3) {
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