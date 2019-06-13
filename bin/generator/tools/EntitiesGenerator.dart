import 'dart:math';

import '../generator_model.dart';
import '../generator_sets.dart';

/// Generates an json array of all entities for a new level
class EntitiesGenerator {

  /// Parameter that determine the placement in the level
  int time = 1000;

  /// Chances determine how often these entities are generated
  /// Double the chances to double the generated entity in the long run
  List<int> chances = List();

  /// The constructor immediately sets the chances for the entities and sets
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

  /// Generates the json array of the entities
  /// Between each generated entity exists a gap, to avoid overlapping entities
  /// For entities placed tight next tot each other a set generator should be useed
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

  /// Generates json object for a single entity using the [chances] to determine
  /// which entity will be generated
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

  /// Generates a json object for a [Brick]
  String generateBrick() {
    return BrickGenerator(time, getXForBrick()).generate();
  }

  /// Generates a json object for a [Dot]
  String generateDot() {
    return DotGenerator(time, getX()).generate();
  }

  /// Generates a json object for a [Barrier]
  String generateBarrier() {
    return BarrierGenerator(time, getXForBarrier()).generate();
  }

  /// Generates a json object for a wall
  String generateWall() {
    return WallGenerator(time).generate();
  }

  /// Generates a random x coordinate for a entity
  double getX() {
    return Random().nextDouble();
  }

  /// Generates a random x coordinate for a [Brick]
  double getXForBrick() {
    return Random().nextInt(4) / 3;
  }

  /// Generates a random x coordinate for a [Barrier]
  double getXForBarrier() {
    return (Random().nextInt(3) + 1) / 4;
  }

  /// Generates a json object for a [Drill]
  String generateDrill() {
    return DrillGenerator(time, getX()).generate();
  }

  /// Generates a json object for a [DoubleUp]
  String generateDoubleUp() {
    return DoubleUpGenerator(time, getX()).generate();
  }

  /// Generates a json object for a [SlowDown]
  String generateSlowDown() {
    return SlowDownGenerator(time, getX()).generate();
  }

  /// Generates a stair set
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

  /// Generates a trap set
  String generateTrap() {
    TrapGenerator t = TrapGenerator(time);
    time += 1000;
    return t.generate();

  }
}