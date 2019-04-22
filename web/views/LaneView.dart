import 'dart:html';

import '../model/Element.dart' as m;

class LaneView {

  Element view;

  List<m.Element> elements = new List();

  LaneView(String s) {
    this.view = querySelector(s);
  }

  void update() {
    elements.forEach((e) {
      // TODO magic number LaneSpeed
      e.move(0, 2);
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