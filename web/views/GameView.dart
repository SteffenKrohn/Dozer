import 'dart:html';

import 'LaneView.dart';

class GameView {

  final lane1 = new LaneView('#lane1');
  final lane2 = new LaneView('#lane2');
  final lane3 = new LaneView('#lane3');
  final lane4 = new LaneView('#lane4');

  GameView() {

  }

  void update() {
    lane1.update();
    lane2.update();
    lane3.update();
    lane4.update();
  }
}