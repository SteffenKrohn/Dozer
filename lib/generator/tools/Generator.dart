part of generator;

class Generator {

  ParameterGenerator pg;

  void create() {
    createLevel(2);
  }

  void createLevel(int levelId) {
    print('{');
    printParams(levelId);
    printEntities();
    print('}');
  }

  void printParams(int levelId) {
    this. pg = ParameterGenerator(levelId).generateValues();
    print(pg.toString());
    print(",");
  }

  void printEntities() {
    print(EntitiesGenerator().generateEntities(pg.timeLimit ~/ 300));
  }
}