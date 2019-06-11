part of generator;

/// Generates a json block containing all necessary parameters for a level
class ParameterGenerator {

  /// The ID of the level
  int levelId;
  /// The time the player has to finish the level
  int timeLimit;
  /// The score the player starts the level with
  int initialScore;
  /// The score the player has to reach to win the level
  int targetScore;
  /// The speed at which the elements move from the top of the screen to the bottom
  /// A speed of 1.0 results in the elements needing one seconds for that.
  /// A speed greater than 1.5 will result in a nearly impossible level
  double laneSpeed;

  /// The minimum time limit that the level can have
  int minTimeLimit = 50000; // Default 50.000ms = 50s
  /// The maximum time limit the level can have
  int maxTimeLimit = 100000; // Default 120.000ms = 120s = 2min

  /// The minimum initial score that the level can have
  int minInitialScore = 10;
  /// The maximum initial score the level can have
  int maxInitialScore = 15;

  /// The minimum target score hat the level can have
  int minTargetScore = 40;
  /// The maximum target score the level can have
  int maxTargetScore = 50;

  /// The minimum speed that the level can have
  double minLaneSpeed = 0.6;
  /// The maximum speed the level can have
  double maxLaneSpeed = 1.0;

  /// The constructor expects the level id as a parameter
  ParameterGenerator(int levelID) {
    this.levelId = levelID;
  }

  /// Generates the random values for the parameters using the declared minimum and maximum values
  ParameterGenerator generateValues() {
    this.generateTimeLimit();
    this.generateInitialScore();
    this.generateTargetScore();
    this.generateLaneSpeed();
    return this;
  }

  /// Generates a random [timeLimit] using [minTimeLimit] and [maxTimeLimit] as boundaries
  void generateTimeLimit() {
    this.timeLimit = Random().nextInt(this.maxTimeLimit - this.minTimeLimit) + this.minTimeLimit + 1;
  }

  /// Generates a random [initialScore] using [minInitialScore] and [maxInitialScore] as boundaries
  void generateInitialScore() {
    this.initialScore = Random().nextInt(this.maxInitialScore - this.minInitialScore) + this.minInitialScore + 1;
  }

  /// Generates a random [targetScore] using [minTargetScore] and [maxTargetScore] as boundaries
  void generateTargetScore() {
    this.targetScore = Random().nextInt(this.maxTargetScore - this.minTargetScore) + this.minTargetScore + 1;
  }

  /// Generates a random [laneSpeed] using [minLaneSpeed] and [maxLaneSpeed] as boundaries
  void generateLaneSpeed() {
    this.laneSpeed = Random().nextDouble() * (this.maxLaneSpeed - this.minLaneSpeed) + this.minLaneSpeed;
  }

  /// Puts all generated value for the parameters in a json block
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