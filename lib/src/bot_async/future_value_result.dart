part of bot_async;

class FutureValueResult<TOutput> {
  static const String _VALUE_KEY = 'value';
  static const String _ERROR_KEY = 'error';
  static const String _STACK_TRACE_KEY = 'stackTrace';

  final TOutput value;
  final error;
  final stackTrace;
  final Func1<dynamic, TOutput> _outputSerializer;

  FutureValueResult(this.value, [this._outputSerializer]) :
    error = null, stackTrace = null;

  FutureValueResult.fromException(this.error, this.stackTrace)
  : value = null, _outputSerializer = null {
    requireArgumentNotNull(error, 'error');
  }

  factory FutureValueResult.fromMap(Map value) {
    requireArgumentNotNull(value, 'value');
    requireArgument(isMyMap(value), 'value');

    final ex = value[_ERROR_KEY];
    if(ex != null) {
      final stack = value[_STACK_TRACE_KEY];
      return new FutureValueResult.fromException(ex, stack);
    } else {
      return new FutureValueResult(value[_VALUE_KEY]);
    }
  }

  bool get isException => error != null;

  Map toMap() {
    final rawValue = _serialize(value);
    return {
      _VALUE_KEY : rawValue,
      _ERROR_KEY : error,
      _STACK_TRACE_KEY : stackTrace
    };
  }

  static bool isMyMap(Map value) {
    return value != null && value.length == 3 &&
        value.containsKey(_VALUE_KEY) &&
        value.containsKey(_ERROR_KEY) &&
        value.containsKey(_STACK_TRACE_KEY);
  }

  bool operator ==(other) {
    return other != null &&
        other.value == value &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  int get hashCode => Util.getHashCode([value, error, stackTrace]);

  dynamic _serialize(TOutput output) {
    if(_outputSerializer == null) {
      return output;
    } else {
      return _outputSerializer(output);
    }
  }
}
