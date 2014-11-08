library bot.test.collection.number_enumerable;

import 'package:bot/src/collection.dart';
import 'package:unittest/unittest.dart';
import 'package:bot_test/bot_test.dart';

void main() {
  group('NumberEnumerable', () {
    test('sum', _testSum);
    test('min', _testMin);
    test('max', _testMax);
    test('average', _testAverage);
    test('range', _testRange);
  });
}

void _testRange() {
  var ne = new NumberEnumerable.fromRange(10, 5);
  expect(ne, orderedEquals([10, 11, 12, 13, 14]));

  ne = new NumberEnumerable.fromRange(0, -1);
  expect(ne, orderedEquals([]));

  ne = new NumberEnumerable.fromRange(0, 0);
  expect(ne, orderedEquals([]));

  ne = new NumberEnumerable.fromRange(0, 1);
  expect(ne, orderedEquals([0]));
}

void _testSum() {
  var value = n$([1, 2, 3]).sum();
  expect(value, equals(6));

  expect(() => n$([1, 2, 3, null]).sum(), throws);
}

void _testMin() {
  var value = n$([1, 2, 3]).min();
  expect(value, equals(1));

  expect(() => n$([1, 2, 3, null]).min(), throws);
}

void _testMax() {
  var value = n$([1, 2, 3]).max();
  expect(value, equals(3));

  expect(() => n$([1, 2, 3, null]).max(), throws);
}

void _testAverage() {
  var value = n$([1, 2, 3]).average();
  expect(value, equals(2));

  expect(() => n$([1, 2, 3, null]).average(), throwsInvalidOperationError);
}
