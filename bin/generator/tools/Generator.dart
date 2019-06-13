import '../generator_tools.dart';

/// Generates the json string for an entire level including the parameter and entities
class Generator {

  /// The generator for the parameter
  ParameterGenerator pg;
  /// The ID of the generated level
  int levelId = 1;
  /// The generator for the entities
  EntitiesGenerator eg;

  /// Creates and returns the json string for the newly generated level
  String create() {
    return _createLevel(levelId);
  }

  /// Generates a new level with the provided [levelId]
  String _createLevel(int levelId) {
    return '{' + _printParams(levelId) + _printEntities() + '}';
  }

  /// Generates json block for the parameter of a level
  String _printParams(int levelId) {
    this.pg = ParameterGenerator(levelId).generateValues();
    return pg.toString() + ",";
  }

  /// Generates the json array for the entities of a level
  String _printEntities() {
    return EntitiesGenerator().generateEntities(pg.timeLimit ~/ 300, 200 ~/ pg.laneSpeed);
  }
}