part of dozergame;

abstract class PowerUp extends Entity {

  /// Duration of the effect of the power up´s in ms
  int duration = 5000;

  int getDuration() {
    return this.duration;
  }
}