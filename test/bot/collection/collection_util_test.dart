library bot.test.collection.collection_util.test;

import 'package:bot/src/collection.dart';
import 'package:unittest/unittest.dart';

void main() {
  test('allUnique', () {
    expect(CollectionUtil.allUnique([]), isTrue);

    expect(CollectionUtil.allUnique([1]), isTrue);
    expect(CollectionUtil.allUnique([null]), isTrue);
    expect(CollectionUtil.allUnique(['']), isTrue);
    expect(CollectionUtil.allUnique(['str']), isTrue);
    expect(CollectionUtil.allUnique([1, 2]), isTrue);
    expect(CollectionUtil.allUnique([1, 2]), isTrue);
    expect(CollectionUtil.allUnique(['', 'str']), isTrue);

    expect(CollectionUtil.allUnique([1, 1]), isFalse);
    expect(CollectionUtil.allUnique([null, null]), isFalse);
    expect(CollectionUtil.allUnique(['', '']), isFalse);
    expect(CollectionUtil.allUnique(['', '']), isFalse);
    expect(CollectionUtil.allUnique(['str', 'str']), isFalse);
  });
}
