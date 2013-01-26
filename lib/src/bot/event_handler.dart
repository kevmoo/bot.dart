part of bot;

class EventHandler<T> implements Comparable {
  static int _globalId = 0;
  final int id;
  final int _hashCode;
  final Function _handler;

  EventHandler._internal(int value, Function handler) :
    id = value,
    _handler = handler,
    _hashCode = Util.getHashCode([value]);

  factory EventHandler(Function handler) {
    return new EventHandler._internal(_globalId++, handler);
  }

  int compareTo(EventHandler other) => id.compareTo(other.id);

  int get hashCode => _hashCode;

  bool operator ==(EventHandler other) => other != null && other.id == id;
}
