
import 'dart:collection';

import '../controller/LevelController.dart';
import 'Barrier.dart';
import 'Brick.dart';
import 'CollisionChecker.dart';
import 'Dot.dart';
import 'Dozer.dart';
import 'Element.dart';
import 'PowerUp.dart';

class Level {

  LevelController _levelController;
  Dozer _dozer;

  /** Time limit in seconds */
  double timeLimit;
  int _initialScore;
  int targetScore;
  int laneSpeed;
  int _level;

  Map<int, Element> visibleElements = new Map<int, Element>();
  Queue<Element> remainingElements = new Queue<Element>();



  /**
   * Creates a new level
   */
  Level(LevelController lc, int timeLimit, int initialScore, int targetScore, int laneSpeed, int level) {
    this._levelController = lc;
    this._level = level;
    this.timeLimit = timeLimit.toDouble();
    this._initialScore = initialScore;
    this.targetScore = targetScore;
    this.laneSpeed = laneSpeed;

    this._dozer = new Dozer(initialScore);
  }

  /**
   * Changes the time limit of the level.
   * The provided change is in seconds.
   * Provide a positive change to increase the time limit,
   * a negative change to decrease the time limit.
   */
  void changeTimeLimit(double change) {
    this.timeLimit += change;
  }

  /**
   * Changes the lane speed of the level.
   * Provide a positive change to increase the lane speed,
   * a negative change to decrease the lane speed.
   */
  void changeLaneSpeed(int change) {
    this.laneSpeed += change;
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
    return this.visibleElements;
  }

  /**
   * Updates all necessary elements
   * This will probably be called every 50ms
   */
  void update() {
    this.visibleElements.forEach((id, e) => e.update());
    this.checkCollisions();
  }

  /**
   * Checks collision of all visible elements with the dozer
   * This will probably be called every 50ms
   */
  void checkCollisions() {
    this.visibleElements.forEach((id, e) {
      if (e is Brick || e is Barrier) {
        if(CollisionChecker.recCir(e, this._dozer)) {
          this._dozer.hitBy(e);
          e.hitBy(this._dozer);
        }
      } else if (e is Dot || e is PowerUp) {
        if(CollisionChecker.circles(e, this._dozer)) {
          this._dozer.hitBy(e);
          e.hitBy(this._dozer);
        }
      }
    });
  }
}