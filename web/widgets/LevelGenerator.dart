import 'dart:async';
import 'dart:html';
import 'dart:math';

import '../model/Brick.dart';
import '../model/Dot.dart';
import '../model/Dozer.dart';
import '../views/LevelView.dart';
import 'IDGenerator.dart';
import '../model/Element.dart' as m;

class LevelGenerator {

  LevelView _levelView;
  List<String> _params;

  Dozer _dozer;

  // TODO No Dozer
  LevelGenerator(LevelView lv, List<String> params, Dozer dozer) {
    this._levelView = lv;
    this._params = params;

    this._dozer = dozer;
  }

  // TODO majorly fucked up so far
  /**
   * Starts generating elements for the LevelView
   */
  void start() {

    Random r = new Random();
    Element view = querySelector("#lane");

    IDGenerator idG = new IDGenerator();

    Timer t;
    int wall = 0;
    int width = view.getBoundingClientRect().width ~/ 4;
    t = new Timer.periodic(new Duration(milliseconds: 1000), (update) {
      
      if (wall % 7 == 0) {
        int width = view.getBoundingClientRect().width ~/ 4;
        Brick b1 = new Brick(idG.getnewID("brick"), 0, 0, r.nextInt(20) +1);
        Brick b2 = new Brick(idG.getnewID("brick"), width, 0, r.nextInt(20) +1);
        Brick b3 = new Brick(idG.getnewID("brick"), width*2, 0, r.nextInt(20) +1);
        Brick b4 = new Brick(idG.getnewID("brick"), width*3, 0, r.nextInt(20) +1);

        this._dozer.addCollisionObject(b1, (m.Element t, m.Element e) {
          t.removeCollisionObject(e);
          _levelView.elements.remove(e);
          querySelector("#"+e.id).remove();
          (t as Dozer).score -= (e as Brick).value;
          (e as Brick).value = 0;
          return;
        });
        this._dozer.addCollisionObject(b2, (m.Element t, m.Element e) {
          t.removeCollisionObject(e);
          _levelView.elements.remove(e);
          querySelector("#"+e.id).remove();
          (t as Dozer).score -= (e as Brick).value;
          (e as Brick).value = 0;
          return;
        });
        this._dozer.addCollisionObject(b3, (m.Element t, m.Element e) {
          t.removeCollisionObject(e);
          _levelView.elements.remove(e);
          querySelector("#"+e.id).remove();
          (t as Dozer).score -= (e as Brick).value;
          (e as Brick).value = 0;
          return;
        });
        this._dozer.addCollisionObject(b4, (m.Element t, m.Element e) {
          t.removeCollisionObject(e);
          _levelView.elements.remove(e);
          querySelector("#"+e.id).remove();
          (t as Dozer).score -= (e as Brick).value;
          (e as Brick).value = 0;
          return;
        });

        view.appendHtml(b1.toString());
        view.appendHtml(b2.toString());
        view.appendHtml(b3.toString());
        view.appendHtml(b4.toString());

        b1.created();
        b2.created();
        b3.created();
        b4.created();

        _levelView.elements.add(b1);
        _levelView.elements.add(b2);
        _levelView.elements.add(b3);
        _levelView.elements.add(b4);
      } else if (wall % 7 < 3) {
        Dot d = new Dot(idG.getnewID("dot"), r.nextInt(width * 3),0,r.nextInt(20)+1);
        this._dozer.addCollisionObject(d, (m.Element t, m.Element e) {
          t.removeCollisionObject(e);
          _levelView.elements.remove(e);
          querySelector("#"+e.id).remove();
          (t as Dozer).score += (e as Dot).value;
          (e as Dot).value = 0;
        });

        view.appendHtml(d.toString());
        d.created();
        _levelView.elements.add(d);
      } else if (wall % 7 == 4) {
        Brick b = new Brick(idG.getnewID("brick"), r.nextInt(width*3),0,r.nextInt(20)+1);
        this._dozer.addCollisionObject(b, (m.Element t, m.Element e) {
          t.removeCollisionObject(e);
          _levelView.elements.remove(e);
          querySelector("#"+e.id).remove();
          (t as Dozer).score -= (e as Brick).value;
          (e as Brick).value = 0;
          return;
        });
        view.appendHtml(b.toString());
        b.created();
        _levelView.elements.add(b);
      }

      wall = r.nextInt(7);
    });

  }

  void stop(Timer t) {

  }

}