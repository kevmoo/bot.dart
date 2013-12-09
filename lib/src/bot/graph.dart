library bot.graph;

import 'dart:math' as math;
import 'dart:collection';
import 'require.dart';

part 'graph/topo_sort.dart';

// http://en.wikipedia.org/wiki/Tarjan's_strongly_connected_components_algorithm

List<List> stronglyConnectedComponents(Map graph) {
  assert(graph != null);

  var nodes = new _Graph(graph);
  var tarjan = new _TarjanCycleDetect._internal(nodes);
  return tarjan._executeTarjan();
}

/**
 * Use top-level [stronglyConnectedComponents] instead.
 */
@deprecated
class TarjanCycleDetect<TNode> {

  /**
   * Use top-level [stronglyConnectedComponents] instead.
   */
  @deprecated
  static List<List> getStronglyConnectedComponents(Map graph) =>
      stronglyConnectedComponents(graph);
}

class _TarjanCycleDetect<T> {
  final _indexExpando = new Expando<int>('index');
  final _linkExpando = new Expando<int>('link');

  int _index = 0;
  final List<_GraphNode> _stack;
  final List<List<T>> _scc;
  final _Graph<T> _list;

  _TarjanCycleDetect._internal(this._list) :
    _index = 0,
    _stack = new List<_GraphNode<T>>(),
    _scc = new List<List<T>>();

  List<List<T>> _executeTarjan() {
    for (var node in _list.getSourceNodeSet()) {
      if(_getIndex(node) == -1) {
        _tarjan(node);
      }
    }
    return _scc;
  }

  void _tarjan(_GraphNode<T> v) {
    _setIndex(v, _index);
    _setLowLink(v, _index);
    _index++;
    _stack.insert(0, v);
    for(final n in v.outNodes){
      if(_getIndex(n) == -1){
        _tarjan(n);
        _setLowLink(v, math.min(_getLowLink(v), _getLowLink(n)));
      } else if(_stack.indexOf(n) >= 0){
        _setLowLink(v, math.min(_getLowLink(v), _getIndex(n)));
      }
    }
    if(_getLowLink(v) == _getIndex(v)){
      _GraphNode n;
      var component = new List<T>();
      do {
        n = _stack[0];
        _stack.removeRange(0, 1);
        component.add(n.value);
      } while(n != v);
      _scc.add(component);
    }
  }

  int _getIndex(_GraphNode<T> node) {
    var value = _indexExpando[node];
    return (value == null) ? -1 : value;
  }

  int _setIndex(_GraphNode<T> node, int value) =>
    _indexExpando[node] = value;

  int _getLowLink(_GraphNode<T> node) => _linkExpando[node];

  int _setLowLink(_GraphNode<T> node, int value) =>
    _linkExpando[node] = value;
}
