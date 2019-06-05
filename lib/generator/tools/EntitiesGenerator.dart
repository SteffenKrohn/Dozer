part of generator;

class EntitiesGenerator {

  // Parameter that determine the placement in the level
  int time = 1000;

  // Chances determine how often these entities are generated
  List<int> chances = List();

  EntitiesGenerator() {
    chances.add(20); // Brick
    chances.add(18); // Dot
    chances.add(6);  // Barrier
    chances.add(1);  // Drill
    chances.add(1);  // DoubleUp
    chances.add(0);  // SlowDown
    chances.add(1);  // Wall
    chances.add(1);  // Stair
    chances.add(1);  // Trap
  }

  String generateEntities(int count, int gap) {
    String output = '"entities": [';

    for(int i = 0; i < count; i++) {
      output += generateEntity();
      output += ",";
      time += gap;
    }

    output = output.substring(0, output.length - 1);
    output += ']';
    return output;
  }

  String generateEntity() {
    int c = 0;
    c = chances.fold(0, (i, e) => i += e);
    int rnd = Random().nextInt(c);

    c = 0;
    int i = 0;
    for (; i < chances.length; i++) {
      c += chances.elementAt(i);
      if (rnd < c) break;
    }

    switch (i) {
      case 0:
        return generateBrick();
      case 1:
        return generateDot();
      case 2:
        return generateBarrier();
      case 3:
        return generateDrill();
      case 4:
        return generateDoubleUp();
      case 5:
        return generateSlowDown();
      case 6:
        return generateWall();
      case 7:
        return generateStair();
      case 8:
        return generateTrap();
      case 9:
      case 10:
      default:
        return "";
    }
  }

  String generateBrick() {
    return BrickGenerator(time, getXForBrick()).generate();
  }

  String generateDot() {
    return DotGenerator(time, getX()).generate();
  }

  String generateBarrier() {
    return BarrierGenerator(time, getXForBarrier()).generate();
  }

  String generateWall() {
    return WallGenerator(time).generate();
  }

  double getX() {
    return Random().nextDouble();
  }

  double getXForBrick() {
    return Random().nextInt(4) / 3;
  }

  double getXForBarrier() {
    return (Random().nextInt(3) + 1) / 4;
  }

  String generateDrill() {
    return DrillGenerator(time, getX()).generate();
  }

  String generateDoubleUp() {
    return DoubleUpGenerator(time, getX()).generate();
  }

  String generateSlowDown() {
    return SlowDownGenerator(time, getX()).generate();
  }

  String generateStair() {
    int x = Random().nextInt(2);
    StairGenerator s;
    if (x == 1) {
      s = StairGenerator(time).right();
    } else {
      s = StairGenerator(time).left();
    }
    time += 320;
    return s.generate();
  }

  String generateTrap() {
    TrapGenerator t = TrapGenerator(time);
    time += 1000;
    return t.generate();

  }
}