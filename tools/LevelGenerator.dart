import '../bin/generator/generator_tools.dart';
import 'dart:io';

/// This generates new levels and automatically saves them into the appropriate files
///
/// This can be run from the project root dir with `dart ./tools/LevelGenerator.dart`
/// Additionally two parameters can be provided
///   - Start ID of generated level inclusive
///   - End ID of generated levels inclusive
/// If they are not provided default values of 1 and 1 are used,
/// which results in level 1 being overwritten.
///
/// `dart ./tools/LevelGenerator.dart 5 10` would generate 5 levels from 5 up to and including 10.
/// Because this overwrites the existing levels without an additional prompt,
/// it is important to make sure the correct parameter are set or the existing
/// level are recoverable (eg. by using git)
void main(List<String> args) {
  int start = 1;
  int end = 1;
  if (args.length > 0) {
    start = int.parse(args.first);
    end = int.parse(args.last);
  }
  for (int i = start; i <= end; i++) {
    Generator g = Generator();
    g.levelId = i;
    String levelJson = g.create();
    File f = File("web/resources/level/level${i.toString()}.json");
    f.writeAsString(levelJson);
  }
}