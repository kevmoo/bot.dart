library test.bot.throttled_stream;

import 'dart:async';
import 'package:unittest/unittest.dart';

import 'package:bot/src/throttled_stream.dart';

void main() {

  test('kitchen sink', () {

    var ts = new ThrottledStream<Iterable<int>, int>(_sum);

    expect(ts.source, isNull);
    expect(ts.outputValue, isNull);

    ts.source = [-2, 3];
    expect(ts.source, [-2, 3]);

    final simple = const [1,2,3];

    return ts.outputStream
        .first.then((int sum) {
          expect(sum, 1);
          expect(ts.outputValue, 1);

          ts.source = [2];
          expect(ts.source, [2]);
          expect(ts.outputValue, 1);

          ts.source = [3];
          expect(ts.source, [3]);
          expect(ts.outputValue, 1);

          return ts.outputStream.first;
        })
        .then((int sum) {
          expect(sum, 2);
          expect(ts.outputValue, 2);

          return ts.outputStream.first;
        })
        .then((int sum) {
          expect(sum, 3);
          expect(ts.outputValue, 3);

          ts.source = null;
          expect(ts.source, null);
          return ts.outputStream.first;
        })
        .then((value) {
          fail('Should not get a value...should error out');
        })
        .catchError((error) {
          expect(error, const isInstanceOf<ArgumentError>());
        })
        .then((_) {

          ts.source = simple;

          return ts.outputStream.first;
        })
        .then((int sum) {
          expect(sum, 6);

          ts.refresh();
          return ts.outputStream.first;
        })
        .then((int sum) {
          expect(sum, 6);

          // this should be ignored, since it's the current value
          ts.source = simple;
          ts.source = [1];

          return ts.outputStream.first;
        })
        .then((int sum) {
          expect(sum, 1);
        });
  });

}

Future<int> _sum(Iterable<int> values) {
  if (values == null) throw new ArgumentError('null!');

  return new Future(() => values.reduce((a, b) {
    if (a == null) throw new ArgumentError();
    if (b == null) throw new ArgumentError();
    return a + b;
  }));
}
