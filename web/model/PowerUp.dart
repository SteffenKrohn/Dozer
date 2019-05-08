
import 'Element.dart';

abstract class PowerUp extends Element {

  int duration;

  int getDuration() {
    return this.duration;
  }
}