library test.bot.graph.topo_sort;

import 'package:bot_test/bot_test.dart';
import 'package:unittest/unittest.dart';
import 'package:bot/src/graph.dart';

void main() {
  _test('empty', {}, []);

  _testThrow('null', null, throwsNullArgumentError);

  _test('one node, no deps', {'a' : []}, ['a']);

  _test('one node, one dep', {'a' : ['b']}, ['b', 'a']);

  _test('test tushar', {
    'd': ['c'],
    'c': ['x'],
    'x': ['b', 'a'],
    'b': ['e']
  }, ['a', 'e', 'b', 'x', 'c', 'd']);

  _test('test tushar, reference e sooner', {
    'd': ['c', 'e'],
    'c': ['x'],
    'x': ['b', 'a'],
    'b': ['e']
  }, ['e', 'a', 'b', 'x', 'c', 'd']);

  _testThrow('test tushar, with a loop', {
    'd': ['c', 'e'],
    'c': ['x'],
    'x': ['b', 'a'],
    'b': ['e', 'd']
  }, throwsArgumentError);

  _test('independent', {
    'a': [],
    'b': []
  }, ['a', 'b']);

  _testThrow('self loop', {
    'a': ['a']
  }, throwsArgumentError);

  _testThrow('dupe dependency', {
    'a': ['b', 'b']
  }, throwsArgumentError);

  // self-reference throws
  // null key throws
}

void _test(String name, Map<String, List<String>> map, List<String> expected) {

  test(name, () {
    var actual = topologicalSort(map);
    expect(actual, expected);
  });

}

void _testThrow(String name, Map<String, List<String>> map, Throws throwsMatcher) {
  test(name, () {
    expect(() => topologicalSort(map), throwsMatcher);
  });
}
