part of generator;

class Generator {

  ParameterGenerator pg;
  int levelId = 1;

  void create() {
    createLevel(levelId);
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