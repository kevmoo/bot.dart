library bot.test.collection;

import 'package:unittest/unittest.dart';

import 'array_2d_test.dart' as array_2d;
import 'collection_util_test.dart' as collection_util;
import 'test_enumerable.dart' as enumerable;
import 'test_number_enumerable.dart' as number_enum;

void main() {
  group('Array2d', array_2d.main);
  group('CollectionUtil', collection_util.main);
  group('Enumerable', enumerable.main);
  group("NumberEnumerable", number_enum.main);
}
