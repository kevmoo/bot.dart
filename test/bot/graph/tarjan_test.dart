library test.bot.graph.tarjan;

import 'package:unittest/unittest.dart';
import 'package:bot/src/graph.dart';

void main() {
  test('single item', () {
    // single node, no loop
    var graph = new Map<int, Set<int>>();
    graph[1] = null;

    var result = stronglyConnectedComponents(graph);
    expect(result.length, equals(1));
    expect(result[0], unorderedEquals([1]));
  });

  test('5 isolated items', () {
    var graph = new Map<int, Set<int>>();
    graph[1] = null;
    graph[2] = null;
    graph[3] = null;
    graph[4] = null;
    graph[5] = null;

    var result = stronglyConnectedComponents(graph);
    expect(result.length, equals(5));
    expect(result[0], unorderedEquals([1]));
    expect(result[1], unorderedEquals([2]));
    expect(result[2], unorderedEquals([3]));
    expect(result[3], unorderedEquals([4]));
    expect(result[4], unorderedEquals([5]));
  });

  test('5 in a line', () {
    var graph = new Map<int, Set<int>>();
    graph[1] = null;
    graph[2] = new Set<int>.from([1]);
    graph[3] = new Set<int>.from([2]);
    graph[4] = new Set<int>.from([3]);
    graph[5] = new Set<int>.from([4]);

    var result = stronglyConnectedComponents(graph);
    expect(result.length, equals(5));
    expect(result[0], unorderedEquals([1]));
    expect(result[1], unorderedEquals([2]));
    expect(result[2], unorderedEquals([3]));
    expect(result[3], unorderedEquals([4]));
    expect(result[4], unorderedEquals([5]));
  });

  test('5 in a loop', () {
    var graph = new Map<int, Set<int>>();
    graph[1] = new Set<int>.from([5]);
    graph[2] = new Set<int>.from([1]);
    graph[3] = new Set<int>.from([2]);
    graph[4] = new Set<int>.from([3]);
    graph[5] = new Set<int>.from([4]);

    var result = stronglyConnectedComponents(graph);
    expect(result.length, equals(1));
    expect(result[0], unorderedEquals([1, 2, 3, 4, 5]));
  });

  test('5 random', () {
    var graph = new Map<int, Set<int>>();
    graph[1] = new Set<int>.from([2]);
    graph[2] = new Set<int>.from([3]);
    graph[3] = new Set<int>.from([2]);
    graph[4] = new Set<int>.from([1]);
    graph[5] = new Set<int>.from([4]);

    var result = stronglyConnectedComponents(graph);
    expect(result.length, equals(4));
    expect(result[0], unorderedEquals([2, 3]));
    expect(result[1], unorderedEquals([1]));
    expect(result[2], unorderedEquals([4]));
    expect(result[3], unorderedEquals([5]));
  });

  test('implied key', () {
    // single node, no loop
    var graph = new Map<int, Set<int>>();
    graph[1] = new Set<int>.from([2]);

    var result = stronglyConnectedComponents(graph);
    expect(result.length, equals(2));
    expect(result[0], unorderedEquals([2]));
    expect(result[1], unorderedEquals([1]));
  });
}
