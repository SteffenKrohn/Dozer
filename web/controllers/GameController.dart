import 'dart:html';
import 'dart:async';
import 'dart:math';

import '../model/Brick.dart';

import '../model/Dot.dart';
import '../model/Dozer.dart';
import '../views/GameView.dart';
import '../views/LaneView.dart';
import '../model/Element.dart' as elem;

class GameController {

  void startup() {

    // Create the overall GameView
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

    // Start the periodic update of the game elements with 50hz
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
      if ((time % (2000 / factor)).toInt() < 30) {
        addElement(gv, time~/20, dozer);
      }

      dozer.update();
    });

    window.onKeyDown.listen((KeyboardEvent e) {
      //Left pressed
      if (e.keyCode == 37) {
        dozer.x -= 10;
      }
      // Right pressed
      if (e.keyCode == 39) {
        dozer.x += 10;
      }
    });

    // Handle the device orientation to move the Dozer
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

  /**
   * Enables control of the dozer by keyboard
   * namely the left and right arrow button
   */
  void enableKeyboardControl(){
  }

  /**
   * Enables control of the dozer by tilting the phone
   */
  void enableOrientationControl() {
  }

  // TODO legacy
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

  // TODO legacy
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

  // TODO legacy
  void loseView(int seconds) {
    querySelector("body").setInnerHtml("<h1>You lost with ${seconds} seconds!</h1>");
    return;
  }
}