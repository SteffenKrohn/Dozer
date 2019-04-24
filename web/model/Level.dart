import 'dart:html';

import '../controller/LevelController.dart';
import 'Dozer.dart';

class Level {

  LevelController _levelController;

  // Level Params
  int _level;

  /** Time limit in seconds */
  double _timeLimit;
  int _initialScore;
  int _targetScore;
  int _laneSpeed;

  Dozer _dozer;

  /**
   * Creates a new level
   */
  Level(LevelController lc, int level, int timeLimit, int initialScore, int targetScore, int laneSpeed) {
    this._levelController = lc;
    this._level = level;
    this._timeLimit = timeLimit.toDouble();
    this._initialScore = initialScore;
    this._targetScore = targetScore;
    this._laneSpeed = laneSpeed;

    this._dozer = new Dozer(initialScore);
  }

  /**
   * Changes the time limit of the level.
   * The provided change is in seconds.
   * Provide a positive change to increase the time limit,
   * a negative change to decrease the time limit.
   */
  void changeTimeLimit(double change) {
    this._timeLimit += change;
  }

  /**
   * Changes the lane speed of the level.
   * Provide a positive change to increase the lane speed,
   * a negative change to decrease the lane speed.
   */
  void changeLaneSpeed(int change) {
    this._laneSpeed += change;
  }

  /**
   * Returns the current score
   */
  int getScore() {
    return this._dozer.score;
  }

  /**
   * Return the current level
   */
  int getLevel() {
    return this._level;
  }

  /**
   * Returns the Dozer object
   */
  Dozer getDozer() {
    return this._dozer;
  }

  int getLaneSpeed() {
    return this._laneSpeed;
  }

  double getTimeLimit() {
    return this._timeLimit;
  }

  int getTargetScoree() {
    return _targetScore;
  }
}