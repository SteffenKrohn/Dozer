class IDGenerator {

  int counter = 0;

  /**
   * Creates a new previously unused unique id
   */
  String getnewID(String type) {
    counter++;
    return type + counter.toString();
  }
}