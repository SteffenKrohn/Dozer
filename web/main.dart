import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'package:pwa/client.dart' as pwa;

import 'model/Brick.dart';

import 'MotionView.dart';
import 'model/Dot.dart';
import 'model/Dozer.dart';
import 'views/GameView.dart';
import 'views/LaneView.dart';
import 'model/Element.dart' as elem;

void main() {
/*
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
  Dozer dozer = new Dozer(
      "dozer",
      querySelector("#field").getBoundingClientRect().right ~/ 2,
      querySelector("#field").getBoundingClientRect().bottom - 50,
      50,
      50,
      99
  );
  querySelector("#field").appendHtml(dozer.toString());
  dozer.update();

  int time = 0;
  double factor = 2;

  // Automatic Update
  Timer t = new Timer.periodic(new Duration(milliseconds: 20), (update) {
    time += 20;
    gv.speedUp();
    gv.update();
    dozer.checkCollision();
    if (dozer.value <= 0) {
      loseView(time ~/ 1000);
      return;
    }

    factor += 0.01;
    if ((time % (2000 / factor)).toInt() < 40) {
      addElement(gv, time~/20, dozer);
    }

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

  window.onDeviceOrientation.listen((ev) {
    // No device orientation
    if (ev.alpha == null && ev.beta == null && ev.gamma == null) {
    }
    // Device orientation available
    else {
      int dx = ev.gamma.toInt();
      if (querySelector("#dozer").getBoundingClientRect().left + dx < 0) {
        dx = querySelector("#dozer").getBoundingClientRect().left * -1;
      }
      if (dozer.x + dx + dozer.width > querySelector("#field").getBoundingClientRect().right) {
        dx = querySelector("#field").getBoundingClientRect().right - querySelector("#dozer").getBoundingClientRect().right;
      }
      dozer.setDerivation(dx);
    }
  });

}


void push(LaneView l, Random r, id, Dozer dozer) {
  if (r.nextInt(4) < 3) {
    Brick b = new Brick("brick$id",0,0,50,l.view.getBoundingClientRect().width.toInt(),r.nextInt(20));
    dozer.addCollisionObject(b, (elem.Element t, elem.Element e) {
      t.removeCollisionObject(e);
      l.elements.remove(e);
      querySelector("#"+e.id).remove();
      (t as Dozer).value -= (e as Brick).value;
      (e as Brick).value = 0;
    });
    l.push(b);
  } else {
    Dot d = new Dot("dot$id",0,0,50,50,r.nextInt(20));
    dozer.addCollisionObject(d, (elem.Element t, elem.Element e) {
      t.removeCollisionObject(e);
      l.elements.remove(e);
      querySelector("#"+e.id).remove();
      (t as Dozer).value += (e as Dot).value;
      (e as Dot).value = 0;
    });
    l.push(d);
  }
}

void addElement(GameView gv, int id, Dozer dozer) {
  Random r = Random();

  switch (r.nextInt(4)) {
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
}

void loseView(int seconds) {
  querySelector("body").setInnerHtml("<h1>You lost with ${seconds} seconds!</h1>");
  return;
}