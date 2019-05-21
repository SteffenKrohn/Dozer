part of generator;

class WallGenerator extends SetGenerator {

  WallGenerator(int time) {
    this.time = time;
  }

  String generate() {
    BrickGenerator g1 = BrickGenerator(time, 0.0);
    BrickGenerator g2 = BrickGenerator(time, 1 / 3);
    BrickGenerator g3 = BrickGenerator(time, 2 / 3);
    BrickGenerator g4 = BrickGenerator(time, 1.0);
    return g1.generate() + "," + g2.generate() + "," + g3.generate() + "," + g4.generate();
  }
}