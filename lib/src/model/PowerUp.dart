import 'package:dozergame/model.dart';

/// The [PowerUp]'s are like dots but give the player other functionality.
/// Implementations of this abstract class are for instance the
/// [DoubleUp]
/// [Drill]
/// [SlowDown]
abstract class PowerUp extends Entity {

  /// Duration of the effect of the power up´s in ms
  final int duration = 5000;

  int getDuration() {
    return this.duration;
  }
}