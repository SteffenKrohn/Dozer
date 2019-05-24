part of generator;

class EntitiesGenerator {

  // Chances determine how often these entities are generated
  int brickChance = 45;
  int dotChance = 30;
  int barrierChance = 15;
  int drillChance = 1;
  int doubleUpChance = 1;
  int slowDownChance = 1;

  // Parameter that determine the placement in the level
  int time = 1000;

  String generateEntities(int count) {
    String output = '"entities": [';

    for(int i = 0; i < count; i++) {
      output += generateEntity();
      output += ",";
      time += 300;
    }

    output = output.substring(0, output.length - 1);
    output += ']';
    return output;
  }

  String generateEntity() {
    int rnd = Random().nextInt(brickChance + dotChance + barrierChance + drillChance + doubleUpChance + slowDownChance);

    if (rnd < brickChance) {
      return generateBrick();
    } else if (rnd < brickChance + dotChance) {
      return generateDot();
    } else if (rnd < brickChance + dotChance + barrierChance) {
      return generateBarrier();
    } else if (rnd < brickChance + dotChance + barrierChance + drillChance) {
      return generateDrill();
    } else if (rnd < brickChance + dotChance + barrierChance + drillChance + doubleUpChance) {
      return generateDoubleUp();
    } else if (rnd < brickChance + dotChance + barrierChance + drillChance + doubleUpChance + slowDownChance) {
      return generateSlowDown();
    }
      return "";
  }

  String generateBrick() {
    return BrickGenerator(time, getX()).generate();
  }

  String generateDot() {
    return DotGenerator(time, getX()).generate();
  }

  String generateBarrier() {
    return BarrierGenerator(time, getX()).generate();
  }

  double getX() {
    return Random().nextDouble();
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
}