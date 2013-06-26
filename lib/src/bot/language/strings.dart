part of bot;

class Strings {
  _Strings() {}
  
  /**
   * Returns true if [value] is null or empty, false otherwise.
   */
  static bool isNullOrEmpty(String value) {
    if (value == null || value == "") {
      return true;
    }
    return false;
  }
  
  /**
   * Returns [value] if it's not null, or an empty string if it is.
   */
  static String nonNullOrEmpty(String value) {
    if (value == null) {
      return "";
    }
    return value;
  }
  
  /**
   * Returns [value] if it's not empty, or null if it is.
   */
  static String nonEmptyOrNull(String value) {
    if (value != "") {
      return value;
    }
    return null;
  }
}