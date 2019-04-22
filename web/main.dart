import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'package:pwa/client.dart' as pwa;

import 'model/Brick.dart';

import 'MotionView.dart';
import 'model/Dot.dart';
import 'views/GameView.dart';
import 'views/LaneView.dart';
import 'model/Element.dart' as m;

void main() {

  new pwa.Client(); // This makes this game offline playable in your browser using service workers

  final qr = querySelector('#qr');       // Html element that shows the QR code of the URL.
  final start = querySelector('#start'); // Html element to start the game.
  final over = querySelector('#over');   // Html element to indicate the game over state.

  final view = new MotionView();         // View object, repsonsible to update game states
  var mobile = false;

  // Area and ball object
  Circle area = new Circle(view.center_x, view.center_y, view.size / 4, view);
  Circle ball = new Circle(view.center_x, view.center_y, view.size / 8, view);

  view.update(area, ball); // Initial update of the game state

  /*
  // Device orientation event handler.
  //
  window.onDeviceOrientation.listen((ev) {

    // No device orientation
    if (ev.alpha == null && ev.beta == null && ev.gamma == null) {
      qr.style.display = 'block'; // Show QR code
    }
    // Device orientation available
    else {
      qr.style.display = 'none'; // Hide QR code
      mobile = true;
      // Determine ball movement from orientation event
      //
      // beta: 30° no move, 10° full up, 50° full down
      // gamma: 0° no move, -20° full left, 20° full right
      //
      final dy = min(50, max(10, ev.beta)) - 30;
      final dx = min(20, max(-20, ev.gamma));
      ball.move(dx, dy);
    }
  });
  */

  GameView gv = new GameView();

  // Dozer
  Dot dozer = new Dot(
      "dozer",
      querySelector("#field").getBoundingClientRect().bottom - 20,
      800,
      50,
      50,
      99
  );
  querySelector("#field").appendHtml(dozer.toString());
  dozer.update();

  // Automatic Update
  Timer t = new Timer.periodic(new Duration(milliseconds: 10), (update) {
    gv.update();
    dozer.checkCollision();
    dozer.update();
  });

  // Initialize a stream for the KeyEvents:
  window.onKeyDown.listen((KeyboardEvent e) {
    // If the key is not set yet, set it with a timestamp.
    //Left pressed
    if (e.keyCode == 37) {
      dozer.x -= 10;
    }
    // Right pressed
    if (e.keyCode == 39) {
      dozer.x += 10;
    }
  });

  //ID Generator
  int id = 1;
  Random r = Random();

  // Timer to add random elements
  new Timer.periodic(new Duration(milliseconds: 1000), (update) {

    switch (r.nextInt(3)){
      case 0:
        push(gv.lane1, r, id, dozer);
        break;
      case 1:
        push(gv.lane2, r, id, dozer);
        break;
      case 2:
        push(gv.lane3, r, id, dozer);
        break;
      case 3:
        push(gv.lane4, r, id, dozer);
        break;
    }
    id++;
  });
}

void push(LaneView l, Random r, id, Dot dozer) {
  if (r.nextInt(4) < 3) {
    Brick b = new Brick("brick$id",0,0,50,l.view.getBoundingClientRect().width.toInt(),r.nextInt(20));
    dozer.addCollisionObject(b, (m.Element t, m.Element e) {
      querySelector("#"+e.id).style.visibility = "hidden";
      (t as Dot).value -= (e as Brick).value;
      (e as Brick).value = 0;
    });
    l.push(b);
  } else {
    Dot d = new Dot("dot$id",200,0,50,50,r.nextInt(20));
    dozer.addCollisionObject(d, (m.Element t, m.Element e) {
      querySelector("#"+e.id).style.visibility = "hidden";
      (t as Dot).value += (e as Dot).value;
      (e as Dot).value = 0;
    });
    l.push(d);
  }
}