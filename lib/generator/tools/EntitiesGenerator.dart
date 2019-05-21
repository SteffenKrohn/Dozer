part of generator;

class EntitiesGenerator {

  // Chances determine how often these entities are generated
  int brickChance = 3;
  int dotChance = 2;
  int barrierChance = 1;

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
    int rnd = Random().nextInt(brickChance + dotChance + barrierChance);

    if (rnd < brickChance) {
      return generateBrick();
    } else if (rnd < brickChance + dotChance) {
      return generateDot();
    } else if (rnd < brickChance + dotChance + barrierChance) {
      return generateBarrier();
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
}