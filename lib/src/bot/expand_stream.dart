library bot.expand_stream;

import 'dart:async';
import 'package:bot/src/bot/typedefs.dart';

// TODO: test more, especially failure cases
Stream expandStream(Stream source, Stream convert(input), {Stream onDone()}) {

  var expander = new _StreamExpander(source, convert, onDone);
  return expander.stream;
}

class _StreamExpander<T, S> {
  final Func1<T, Stream<S>> _converter;
  final Func<Stream<S>> _onDone;
  final StreamIterator<T> _iterator;

  final StreamController<S> _controller = new StreamController();

  _StreamExpander(Stream<T> source, this._converter, [this._onDone]) :
    this._iterator = new StreamIterator(source) {
    _moveNext();
  }

  Stream<S> get stream => _controller.stream;

  void _moveNext() {
    // TODO: handle case where moveNext yields an error
    _iterator.moveNext().then((bool hasNext) {
      if(!hasNext) {
        _finish();
        return;
      }

      // TODO: handle case where convert throws
      var subStream = _converter(_iterator.current);

      _controller.addStream(subStream)
        .then((_) => _moveNext());
    });
  }

  void _finish() {
    if(_onDone != null) {
      // TODO: handle case where onDone throws
      _controller.addStream(_onDone())
        .whenComplete(_close);
    } else {
      _close();
    }
  }

  void _close() {
    _controller.close();
  }

}
