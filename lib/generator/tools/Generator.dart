part of generator;

class Generator {

  ParameterGenerator pg;
  int levelId = 1;
  EntitiesGenerator eg;

  String create() {
    return _createLevel(levelId);
  }

  String _createLevel(int levelId) {
    return '{' + _printParams(levelId) + _printEntities() + '}';
  }

  String _printParams(int levelId) {
    this.pg = ParameterGenerator(levelId).generateValues();
    return pg.toString() + ",";
  }

  String _printEntities() {
    return EntitiesGenerator().generateEntities(pg.timeLimit ~/ 300, 200 ~/ pg.laneSpeed);
  }
}