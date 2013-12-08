library test.bot.expand_stream;

import 'dart:async';
import 'package:bot/src/bot/expand_stream.dart';
import 'package:unittest/unittest.dart';

void main() {

  test('simple', () {
    var inputs = [7, 11, 13, 17, 19];

    return expandStream(_slowFromList(inputs), _fromNumber, onDone: _final)
        .toList()
          .then((List<int> items) {
            expect(items, orderedEquals(
                                        [7, 14, 11, 22, 13, 26, 17, 34, 19, 38, 0, 1, 2, 3]));
          });
  });
}


Stream<int> _fromNumber(int input) =>
    _slowFromList([input, input * 2]);

Stream<int> _final() =>
    _slowFromList([0,1,2,3]);

Stream _slowFromList(List items) {
  var controller = new StreamController();

  Future.forEach(items, (item) {
    return new Future.delayed(new Duration(milliseconds: 2))
      .then((_) {
        controller.add(item);
      });
  }).whenComplete(controller.close);

  return controller.stream;
}
