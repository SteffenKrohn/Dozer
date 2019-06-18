/// A class which simply represents a horizontal and vertical coordinate.
/// The class is primarily used for the [DozerTail] and could be easily extended.
class Coordinates {
  /// The horizontal coordinate of the [Entity]
  final double x;

  /// The vertical coordinate of the [Entity]
  double y;

  /// The direction, by now only for extension possibilities.
  /// E.g. image direction, when the [Dozer] is displayed by an image.
  // final int dx;

  Coordinates(this.x, this.y) {}
}
