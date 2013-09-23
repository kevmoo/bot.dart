part of bot_async;

class SendPortValue<TInput, TOutput> extends FutureValue<TInput, TOutput> {
  final SendPort _sendPort;
  final Func1<TInput, dynamic> inputSerializer;
  final Func1<dynamic, TOutput> outputDeserializer;

  SendPortValue(this._sendPort, {this.inputSerializer, this.outputDeserializer});

  Future<TOutput> getFuture(TInput value) {

    dynamic val = (inputSerializer == null) ? value : inputSerializer(value);

    return _sendPort.call(val)
        .then((value) {
          if(value is Map && FutureValueResult.isMyMap(value)) {
            final fvr = new FutureValueResult.fromMap(value);
            if(fvr.isException) {
              throw new IsolateUnhandledException('Error is SendPortValue', fvr.error, fvr.stackTrace);
            } else {
              value = fvr.value;
            }
          }
          return _deserializer(value);
        });
  }

  TOutput _deserializer(dynamic input) {
    if(outputDeserializer == null) {
      return input;
    } else {
      return outputDeserializer(input);
    }
  }
}
