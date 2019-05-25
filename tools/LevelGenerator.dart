import 'package:dozergame/generator/generator.dart';

import 'dart:io';

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
    File f = File("web/resources/level/level${i}.json");
    f.writeAsString(levelJson);
  }


}