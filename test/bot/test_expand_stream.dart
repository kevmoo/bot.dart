library test.bot.expand_stream;

import 'dart:async';
import 'package:bot/src/expand_stream.dart';
import 'package:unittest/unittest.dart';

void main() {

  group('expandStream', () {
    // source stream is paused during future
    // non-future value just works -- return value ignored
    // thrown exception immediately or from future cancels substription

    test('simple', () {
      var inputs = [7, 11, 13, 17, 19];

      return expandStream(_slowFromList(inputs), _fromNumber, onDone: _final)
          .toList()
            .then((List<int> items) {
              expect(items,
                  orderedEquals([7, 14, 11, 22, 13, 26, 17, 34, 19, 38, 0, 1, 2, 3]));
            });
    });

  });

  group('streamForEachAsync', () {
    test('simple sync', () {
      var items = new List.generate(10, (i) => i);
      var stream = new Stream.fromIterable(items);

      int count = 0;
      return streamForEachAsync(stream, (int item) {
        expect(item, lessThan(items.length));
        expect(item, count);
        count++;
      }).then((_) {
        expect(count, items.length);
      });

    });

    test('simple async', () {
      var items = new List.generate(10, (i) => i);
      var stream = new Stream.fromIterable(items);

      int count = 0;
      return streamForEachAsync(stream, (int item) {
        expect(item, lessThan(items.length));
        expect(item, count);
        count++;
        return new Future.value();
      }).then((_) {
        expect(count, items.length);
      });

    });

    test('stream has error', () {
      var canceled = false;
      var controller = new StreamController(onCancel: () {
        canceled = true;
      });
      controller.add(0);

      int count = 0;

      var errorCaught = false;

      return streamForEachAsync(controller.stream, (int item) {
        expect(item, count);
        if (item < 5) {
          count++;
          controller.add(item + 1);
        } else {
          controller.addError('never 5');
        }
      }).catchError((err) {
        expect(err, 'never 5');
        errorCaught = true;
      }).then((_) {
        expect(errorCaught, isTrue);
        expect(canceled, isTrue);
      });
    });

    test('action throws error directly', () {
      var canceled = false;
      var controller = new StreamController(onCancel: () {
        canceled = true;
      });
      controller.add(0);

      int count = 0;

      var errorCaught = false;

      return streamForEachAsync(controller.stream, (int item) {
        expect(item, count);
        if (item < 5) {
          count++;
          controller.add(item + 1);
        } else {
          throw 'never 5';
        }
      }).catchError((err) {
        expect(err, 'never 5');
        errorCaught = true;
      }).then((_) {
        expect(errorCaught, isTrue);
        expect(canceled, isTrue);
      });
    });

    test('action throws error directly', () {
      var canceled = false;
      var controller = new StreamController(onCancel: () {
        canceled = true;
      });
      controller.add(0);

      int count = 0;

      var errorCaught = false;

      return streamForEachAsync(controller.stream, (int item) {
        expect(item, count);
        if (item < 5) {
          count++;
          controller.add(item + 1);
        } else {
          return new Future.error('never 5');
        }
      }).catchError((err) {
        expect(err, 'never 5');
        errorCaught = true;
      }).then((_) {
        expect(errorCaught, isTrue);
        expect(canceled, isTrue);
      });
    });
  });
}

Stream<int> _fromNumber(int input) => _slowFromList([input, input * 2]);

Stream<int> _final() => _slowFromList([0, 1, 2, 3]);

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
