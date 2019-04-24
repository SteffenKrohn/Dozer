/**
 * A Generator used to generate unique Ids
 */
class IDGenerator {

  int _id = 0;

  /**
   * Creates a new previously unused unique id
   */
  String getnewID(String type) {
    _id++;
    return type + _id.toString();
  }
}