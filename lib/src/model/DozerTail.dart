import 'package:dozergame/model.dart';

/// The [DozerTail] is handled like a normal [Entity].
/// It is seperate from the [Dozer] class because its much more simple and
/// the tail does not have to be checked for collisions
class DozerTail extends Entity {

  /// Creates a simple [DozerTail] object
  DozerTail(int id, double x, double y, Level level) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.height = (level.viewWidth * 0.05).floor();
    this.width = (level.viewWidth * 0.05).floor();
    this.level = level;
  }

  @override
  String toString() {
    return "dozertail";
  }

  @override
  void hitBy(Entity e) {}

  @override
  double getDy() {
    return 0;
  }
}