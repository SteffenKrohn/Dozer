

/// The abstract class for all [Entity] generators
abstract class EntityGenerator {

  /// The string representation of the type
  String type;
  /// The time after this entity will appear on the screen in milliseconds
  int time;
  /// The x coordinate of this entity. 1.0 results in the entity being placed
  /// on the right edge of the screen, 0.0 on the left edge.
  double x;

  /// Puts the values for this entity into a string which can be used for the level files
  String generate();
}