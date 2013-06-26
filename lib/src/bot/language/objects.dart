part of bot;

class Objects {
  _Objects() {}
  
  /**
   * Returns the first non-null argument.  If both arguments are null, an [ArgumentError] is thrown.
   */
  static firstNonNull(first, second) {
    if (first != null) {
      return first;
    } else if (second != null) {
      return second;
    }
    
    throw new ArgumentError("Both arguments were null.");
  }
}