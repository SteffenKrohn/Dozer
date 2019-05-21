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
  int minTimeLimit = 20000; // Default 20.000ms = 20s
  int maxTimeLimit = 120000; // Default 120.000ms = 120s = 2min

  int minInitialScore = 5;
  int maxInitialScore = 20;

  int minTargetScore = 25;
  int maxTargetScore = 60;

  double minLaneSpeed = 0.2;
  double maxLaneSpeed = 1.5;

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
        '"lanespeed": ${this.laneSpeed},' +
        '"instructions": ${this.instructions}' +
      '}'
    ;
  }
}