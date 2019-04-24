import 'dart:html';

import '../model/Element.dart' as m;

class LaneView {

  Element view;

  List<m.Element> elements = new List();

  double laneSpeed = 2;

  LaneView(String s) {
    this.view = querySelector(s);
  }

  void update() {
    elements.forEach((e) {
      if (e.y > view.getBoundingClientRect().bottom) {
        querySelector("#"+e.id).remove();
        elements.remove(e);
        e = null;
        return;
      }
      // TODO magic number LaneSpeed
      e.move(0, laneSpeed.toInt());
      e.update();
    });
  }

  void push(m.Element e) {
    this.elements.add(e);
    this.view.appendHtml(e.toString());
    e.x += view.getBoundingClientRect().left;
    e.y += view.getBoundingClientRect().top;
  }
}