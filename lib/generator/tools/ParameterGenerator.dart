part of generator;

class ParameterGenerator {

  // Final level parameter
  int levelId;
  int timeLimit;
  int initialScore;
  int targetScore;
  double laneSpeed;
  String instructions;

  // Parameter used to generate final level parameter
  int minTimeLimit = 50000; // Default 50.000ms = 50s
  int maxTimeLimit = 100000; // Default 120.000ms = 120s = 2min

  int minInitialScore = 10;
  int maxInitialScore = 15;

  int minTargetScore = 40;
  int maxTargetScore = 50;

  double minLaneSpeed = 0.6;
  double maxLaneSpeed = 1.0;

  ParameterGenerator(int levelID) {
    this.levelId = levelID;
  }

  ParameterGenerator generateValues() {
    this.generateTimeLimit();
    this.generateInitialScore();
    this.generateTargetScore();
    this.generateLaneSpeed();
    return this;
  }

  void generateTimeLimit() {
    this.timeLimit = Random().nextInt(this.maxTimeLimit - this.minTimeLimit) + this.minTimeLimit + 1;
  }

  void generateInitialScore() {
    this.initialScore = Random().nextInt(this.maxInitialScore - this.minInitialScore) + this.minInitialScore + 1;
  }

  void generateTargetScore() {
    this.targetScore = Random().nextInt(this.maxTargetScore - this.minTargetScore) + this.minTargetScore + 1;
  }

  void generateLaneSpeed() {
    this.laneSpeed = Random().nextDouble() * (this.maxLaneSpeed - this.minLaneSpeed) + this.minLaneSpeed;
  }

  String toString() {
    return
      '"params": {' +
        '"level": ${levelId},' +
        '"timelimit": ${this.timeLimit},' +
        '"initialscore": ${this.initialScore},' +
        '"targetscore": ${this.targetScore},'+
        '"lanespeed": ${this.laneSpeed}' +
      '}'
    ;
  }
}