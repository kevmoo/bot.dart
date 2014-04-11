library test.bot.math.rect;

import 'package:bot/bot.dart';
import 'package:unittest/unittest.dart';

void main() {
  group('Box', () {
    test('equals', _testEquals);
    test('size and location', _testSizeLocation);
    test('isValid', _testValid);
  });
}

void _testEquals() {
  var a = const Box(0, 0, 1, 1);
  expect(a, equals(a));
  expect(a, same(a));

  var b = const Box(0, 0, 1, 1);
  expect(b, equals(a));
  expect(b, same(a));

  var c = new Box(0, 0, 1, 1);
  expect(c, equals(a));
  expect(c, isNot(same(a)));
}

void _testSizeLocation() {
  var a = new Box(1, 2, 3, 4);

  var b = new Box.fromCoordSize(a.topLeft, a.size);

  expect(b, equals(a));
}

void _testValid() {
  Box a;

  var validLocations = const [-1, 0, 1];
  var validSizes = const [0, 1];

  var invalidLocations = const [double.NAN, double.NEGATIVE_INFINITY,
      double.INFINITY, null];

  var invalidSizes = const [double.NAN, double.NEGATIVE_INFINITY,
      double.INFINITY];

  for (var x in validLocations) {
    for (var y in validLocations) {
      for (var w in validSizes) {
        for (var h in validSizes) {
          a = new Box(x, y, w, h);
          expect(a.isValid, isTrue);

          for (var badLocation in invalidLocations) {
            a = new Box(badLocation, y, w, h);
            expect(a.isValid, isFalse);

            a = new Box(x, badLocation, w, h);
            expect(a.isValid, isFalse);
          }

          for (var badSize in invalidSizes) {
            a = new Box(x, y, badSize, h);
            expect(a.isValid, isFalse);

            a = new Box(x, y, w, badSize);
            expect(a.isValid, isFalse);
          }
        }
      }
    }
  }
}
