import 'dart:math';

import 'package:dozergame/model.dart';
import 'package:dozergame/controller.dart';

/// The model representation of the Dozer, the game's main character.
/// It extends the class [Entity].
class Dozer extends Entity {

  /// The maximum possible height of the [Dozer] in percent of the viewport height
  static const double MAXIMUM_DOZER_HEIGHT = 0.7;
  /// The gap between one [DozerTail] Entity and another in percent of one's height
  static const double TAIL_GAP = 0.5;

  /// The current score and length respectively of the [Dozer]
  int score;
  /// The route the [Dozer] went represented by [Coordinates]
  List<Coordinates> _tailRoute = new List<Coordinates>();
  /// A list of all [DozerTail] Entities
  List<DozerTail> tailEntities = new List<DozerTail>();
  /// The gap of one [DozerTail] Entity to the next one
  double _tailGap;
  /// A scientifically correct calculated constant of the moved distance of
  /// entities so the dozer tail entities go down with the other entities
  /// that entities don't intersect with the dozer tail
  double _movedDistance;

  /// Fields that track if a power up is active
  List<Future> drillFutures = List();
  List<Future> doubleUpFutures = List();
  bool drillActive = false;
  bool doubleUpActive = false;

  /// Creates a [Dozer] object with the zero id, the given score and other member variables.
  /// The zero id is used to recognize the dozer entity.
  Dozer(Level level) {
    this.id = 0;
    this.dy = 0;
    this.score = level.initialScore;
    this.level = level;

    this.height = (this.level.viewWidth * 0.05).floor();
    this.width = (this.level.viewWidth * 0.05).floor();
    this.x = this.level.viewWidth / 2 - this.width;
    this.y = this._getYAccordingToScore();

    this._tailGap = this.height * TAIL_GAP;
    this._movedDistance = this.level.getVerticalMovementPerUpdate() / (1.15 * this.level.laneSpeed + 1.54);

    for(int i = 0; i <= this.level.targetScore * AppController.framerate; i++) {
      this._tailRoute.add(Coordinates(this.x, this.y + (i * this._tailGap * this.level.laneSpeed)));
    }
    // Add the tail entities according to initial score
    this._removeAndAddTailEntities();
  }

  /// Updates the [Dozer] movement, the [DozerTail] and his parent [Entity]
  void update() async {
    // Left border
    if (this.x + this.dx < 0) {
      this.dx = this.x * -1;
    }
    // Right border
    if (this.x + this.dx + this.width > level.viewWidth) {
      this.dx = level.viewWidth - this.x - this.width;
    }

    super.update();

    // Add new Route Coordinate to List and update existing ones
    this._tailRoute.removeLast();
    this._tailRoute.forEach((c) => c.y += this._movedDistance);
    this._tailRoute.insert(0, Coordinates(this.x, this.y));


    this._updateExistingTailEntities();
    this._updateVerticalDozerPlacement();
  }

  /// Change vertical [Dozer] placement Y-Coordinate according to the score
  void _updateVerticalDozerPlacement() {
    // dozer grows in height
    if(this._getYAccordingToScore() < this.y) {
      this._tailRoute.forEach((c) => c.y -= 1);
      this.y -= 1;
      return;
    }
    // dozer shrinks in height
    if(this._getYAccordingToScore() > this.y) {
      this._tailRoute.forEach((c) => c.y += 1);
      this.y += 1;
      return;
    }
  }

  /// Adds or removes [DozerTail] according to the current score
  void _removeAndAddTailEntities() {
    // Remove Tail Entities after score decreases
    while(this.tailEntities.length >= this.score && this.tailEntities.length > 0) {
      this.tailEntities.removeLast();
    }

    // Add Tail Entities after score increase
    while(this.tailEntities.length + 1 < this.score) {
      this.tailEntities.add(DozerTail(-1 * (this.tailEntities.length + 1), this.x, this.y, this.level));
    }
  }

  /// Updates existing [DozerTail] entities
  void _updateExistingTailEntities() {
    Coordinates lastCoordinates = this._tailRoute.first;
    for(int i = 0; i < this.tailEntities.length; i++) {
      // theorem of pythagoras
      Coordinates nextCoordinates = this._tailRoute.skip(i).firstWhere(
        (c) =>
          // Next Coordinate must be above old one
          c.y > lastCoordinates.y &&
          sqrt(pow(lastCoordinates.y - c.y, 2) + pow(lastCoordinates.x - c.x, 2)) >= this._tailGap
      );

      this.tailEntities[i].x = nextCoordinates.x;
      this.tailEntities[i].y = nextCoordinates.y;

      lastCoordinates = nextCoordinates;
    }
}


  /// Changes the score of the [Dozer].
  /// Depending on the power up´s behaviour it will be different.
  void changeScore(int change) {
    if (this.doubleUpActive && change > 0) {
      change = change * 2;
    }

    if (this.drillActive && change < 0) {
      change = 0;
    }
    this.score += change;
    this._removeAndAddTailEntities();
  }

  /// Returns a string representation of the [Dozer]
  String toString() {
    return "dozer";
  }

  @override
  void hitBy(Entity e) async {
    if (e is Brick) {
      this.changeScore(-1 * e.value);
      return;
    }
    if (e is Dot) {
      this.changeScore(e.value);
      return;
    }
    if (e is Barrier) {
      // Right Side
      if (this.dx < 0) {
        this.x = e.x + e.width - this.dx;
      } else if (this.dx > 0) {
        // Left Side
        this.x = e.x - this.width - this.dx;
      }
      return;
    }
    // PowerUp´s
    // If the power up is already active we have a future for that powerup
    // in [drillFutures]. So start a new Future when the previous power up
    // has ended.
    if (e is DoubleUp) {
      if (this.doubleUpFutures.length > 0) {
        this.doubleUpFutures.first.then((t) {
          this.doubleUpActive = true;
          Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
          delay.then((d) {
            this.doubleUpActive = false;
          });
          this.doubleUpFutures.insert(0, delay);
          this.doubleUpFutures.removeLast();
        });
      } else {
        Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
        delay.then((d) {
          this.doubleUpActive = false;
        });
        this.doubleUpFutures.insert(0, delay);
      }
      this.doubleUpActive = true;
      return;
    }
    if (e is Drill) {
      if (this.drillFutures.length > 0) {
        this.drillFutures.first.then((t) {
          this.drillActive = true;
          Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
          delay.then((d) {
            this.drillActive = false;
          });
          this.drillFutures.insert(0, delay);
          this.drillFutures.removeLast();
        });
      } else {
        Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
        delay.then((d) {
          this.drillActive = false;
        });
        this.drillFutures.insert(0, delay);
      }
      this.drillActive = true;
      return;
    }
    if (e is SlowDown) {
      if (this.level.slowDownFutures.length > 0) {
        this.level.slowDownFutures.first.then((t) {
          this.level.slowDownActive = true;
          Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
          delay.then((d) {
            this.level.slowDownActive = false;
          });
          this.level.slowDownFutures.insert(0, delay);
          this.level.slowDownFutures.removeLast();
        });
      } else {
        Future delay = Future.delayed(Duration(milliseconds: e.getDuration()), () => true);
        delay.then((d) {
          this.level.slowDownActive = false;
        });
        this.level.slowDownFutures.insert(0, delay);
      }
      this.level.slowDownActive = true;
      return;
    }
    //TODO other hitBy behaviour
  }

  /// Gets the y height for the head of the [Dozer]
  double _getYAccordingToScore() {
    return max(this.level.viewHeight * (1 - (this.score * 1.5 / 100)) - 10, this.level.viewHeight * Dozer.MAXIMUM_DOZER_HEIGHT);
  }

  @override
  double getDy() {
    return 0;
  }
}