library bot.test.collection;

import 'package:unittest/unittest.dart';

import 'array_2d_test.dart' as array_2d;
import 'collection_util_test.dart' as collection_util;

void main() {
  group('Array2d', array_2d.main);
  group('CollectionUtil', collection_util.main);
}
