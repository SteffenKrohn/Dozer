
import 'dart:collection';

import '../controller/LevelController.dart';
import 'Dozer.dart';
import 'Element.dart';

class Level {

  LevelController _levelController;
  Dozer _dozer;

  /** Time limit in seconds */
  double _timeLimit;
  int _initialScore;
  int _targetScore;
  int _laneSpeed;
  int _level;

  Map<int, Element> visibleElements = new Map<int, Element>();
  Queue<Element> remainingElements = new Queue<Element>();



  /**
   * Creates a new level
   */
  Level(LevelController lc, int timeLimit, int initialScore, int targetScore, int laneSpeed, int level) {
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

  /**
   * Returns a map of all currently visible elements
   * The key value pair of a map entry is:
   * <ID of element | element>
   */
  Map<int, Element> getVisibleElements() {
    //TODO
  }

  /**
   * Updates all necessary elements
   * This will probably be called every 50ms
   */
  void update() {
    //TODO
  }

  /**
   * Checks collision of all visible elements
   * This will probably be called every 50ms
   */
  void checkCollisions() {
    //TODO
  }
}