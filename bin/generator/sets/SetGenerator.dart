

/// Abstract class for all set generators
abstract class SetGenerator {

  /// The time in milliseconds until this set appears on the screen
  int time;

  /// Generates a string representation of the set which can be used in the level files
  String generate();
}