import 'dart:html';

import '../model/Element.dart' as m;

class CollisionChecker {

  /**
   * Checks if two elements with rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool rectangles(m.Element a, m.Element b) {
    // TODO make pretty
    var av = querySelector("#"+a.id);
    var bv = querySelector("#"+b.id);

    int aTop = av.getBoundingClientRect().top.toInt();
    int aLeft = av.getBoundingClientRect().left.toInt();
    int aBot = av.getBoundingClientRect().bottom.toInt();
    int aRight = av.getBoundingClientRect().right.toInt();

    int bTop = bv.getBoundingClientRect().top.toInt();
    int bLeft = bv.getBoundingClientRect().left.toInt();
    int bBot = bv.getBoundingClientRect().bottom.toInt();
    int bRight = bv.getBoundingClientRect().right.toInt();

    bool v = false;
    bool h = false;
    if (aTop >= bTop && aTop <= bBot) {
      v = true;
    }
    if (aBot >= bTop && aBot <= bBot) {
      v = true;
    }
    if (aLeft >= bLeft && aLeft <= bRight) {
      h = true;
    }
    if (aRight >= bLeft && aRight <= bRight) {
      h = true;
    }
    return v && h;
  }

  /**
   * Checks if two elements with circle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool circles(m.Element a, m.Element b) {
    //TODO
  }

  /**
   * Checks if two elements with circle and rectangle shape overlap or touch
   * by checking the boundaries of both elements
   */
  static bool recCir(m.Element rectanlge, m.Element circle) {
    //TODO
  }
}