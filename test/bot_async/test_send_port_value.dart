part of test_bot_async;

Serialization _getSerial() {
  var serial = new Serialization();

  var t2 = new Tuple<int, int>(0,0);
  serial.addRuleFor(t2, constructorFields: ['item1', 'item2']);

  var t3 = new Tuple3<int, int, int>(0,0,0);
  serial.addRuleFor(t3, constructorFields: ['item1', 'item2', 'item3']);

  return serial;
}

class TestSendPortValue {
  static void run() {
    group('SendPortValue', () {
      test('simple', _testSimple);
      test('complex', _testComplex);
    });
  }

  static void _testSimple() {
    final tv = new _TestValue();

    final callback = expectAsync1((EventArgs arg) {
      expect(tv.output, equals(25));
    });

    final onError = expectAsync1((IsolateUnhandledException error) {
      expect(error.source, equals('wah?'));
    });

    tv.outputChanged.listen(callback);
    tv.error.listen(onError);
    tv.input = 5;

    tv.input = -1;
  }

  static void _testComplex() {
    final tv = new _ComplexTestValue();

    final callback = expectAsync1((EventArgs arg) {
      expect(tv.output, equals(new Tuple3(5,6,11)));
    });

    final onError = expectAsync1((IsolateUnhandledException error) {
      expect(error.source, equals('wah?'));
    });

    tv.outputChanged.listen(callback);
    tv.error.listen(onError);
    tv.input = new Tuple<int, int>(5, 6);

    tv.input = null;
  }
}

class _TestValue extends SendPortValue<int, int> {
  _TestValue() : super(spawnFunction(_testIsolate));
}

void _testIsolate() {
  new SendValuePort<int, int>((input) {
    if(input < 0) {
      throw 'wah?';
    }

    final int output = input * input;
    return output;
  });
}


class _ComplexTestValue extends SendPortValue<Tuple<int, int>, Tuple3<int, int, int>> {
  _ComplexTestValue() : super(spawnFunction(_complexTestIsolate),
      inputSerializer: _inputSerializer, outputDeserializer: _outputSerializer);
}

final _serial = _getSerial();
final _format = const SimpleJsonFormat(storeRoundTripInfo: true);

dynamic _inputSerializer(input) {
  var writer = _serial.newWriter(_format);
  var output = writer.write(input);
  return output;
}

dynamic _outputSerializer(dynamic input) {
  var reader = _serial.newReader(_format);
  var output = reader.read(input);
  return output;
}

void _complexTestIsolate() {
  new SendValuePort<Tuple<int, int>, Tuple3<int, int, int>>((input) {
    if(input == null) {
      throw 'wah?';
    }

    return new Tuple3<int, int, int>(
        input.item1,
        input.item2,
        input.item1 + input.item2);
  }, inputDeserializer:_outputSerializer, outputSerializer:_inputSerializer);
}
