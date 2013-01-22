import 'dart:html';

import 'package:bot/bot.dart';

const Size _size = const Size(5, 5);

final CanvasElement _canvas = query('canvas');
CanvasRenderingContext2D _ctx;
ImageData _data;
Array2d _values;


void main() {
  _canvas.width = _size.width;
  _canvas.height = _size.height;
  _canvas.style.width = '${_size.width}px';
  _canvas.style.height = '${_size.height}px';

  window.setTimeout(() {
    _ctx = _canvas.context2d;
    window.requestAnimationFrame(_update);
  }, 0);
}

void _update(num highResTime) {
  if(_values == null) {
    _data = _ctx.createImageData(_size.width, _size.height);

    var view32 = new Uint32Array.fromBuffer(_data.data.buffer);

    _values = new Array2d.wrap(_size.width, view32);

    for(var i = 0; i< _values.length; i++) {
      _values[i] = rnd.nextInt(256*256*256*256);
    }
  }

  for(var i = 0; i< _values.length; i++) {
    _values[i] = getNext(_values[i]);
  }

  _ctx.putImageData(_data, 0, 0);

  window.requestAnimationFrame(_update);
}

int getNext(int previous) {
  var red = previous >> 24;
  print(red.toRadixString(16));
  if(red > 0) {
    red--;
  }
  previous &= red << 24;

  //previous = previous - 260;
  return previous | 255;
}
