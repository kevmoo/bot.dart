part of bot_retained;

class _Logging {
  static final Map<Thing, _LogData> _data = new Map<Thing, _LogData>();

  static void log(Thing thing, String value) {
    final data = _data.putIfAbsent(thing, () => new _LogData(thing));
    data.log(value);
  }
}

class _LogData {
  final Thing thing;
  final Map<String, _LogEntry> _entries = new Map<String, _LogEntry>();

  _LogData(this.thing);

  void log(String value) {
    bool first = false;
    final entry = _entries.putIfAbsent(value, () => new _LogEntry(value));

    entry.update();

    print([thing, entry]);
  }
}

class _LogEntry {
  final String value;
  int _count = 0;
  num _first;
  num _last;

  _LogEntry(this.value);

  void update() {
    _count++;
    _last = window.performance.now();
    if(_first == null) {
      _first = _last;
    }
  }

  String toString() => "$value:: count: $_count; first: $_first; last: $_last";
}
