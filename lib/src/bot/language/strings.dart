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
  
  /**
   * Returns a new string where the last occurence of [from] in this string is replaced with [to].
   * 
   * If [from] does not match any part of the string, then the original string is returned unmodified.
   */
  static String replaceLast(String source, Pattern from, String to) {
    if (source == null) {
      throw new ArgumentError("source String cannot be null");
    }
    if (from == null) {
      throw new ArgumentError("from Pattern cannot be null");
    }
    if (to == null) {
      throw new ArgumentError("to String cannot be null");
    }
    
    Iterable<Match> matches = from.allMatches(source);
    
    if (matches.isEmpty) {
      return source;
    }
      
    Match match = matches.last;
    String matchedString = match.group(match.groupCount);
    
    int lastIndex = source.lastIndexOf(matchedString);
    if (lastIndex == -1) {
      return source;
    }
    
    String firstPart = source.substring(0, lastIndex);
    String secondPart = source.substring(lastIndex + matchedString.length, source.length);
    return "$firstPart$to$secondPart";
  }
}