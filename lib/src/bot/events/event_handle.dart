part of bot;

class EventHandle<T> extends DisposableImpl implements EventRoot<T> {
  HashMap<int, Action1<T>> _handlers;

  void fireEvent(T args) {
    assert(!isDisposed);
    if(_handlers != null) {
      _handlers.forEach((int id, Action1<T> handler) {
        handler(args);
      });
    }
  }

  /**
   * _I'm not a huge fan of returning a [GlobalId] but at the moment
   * functions don't have a simple model for identity. [GlobalId] allows
   * reliable removal of an added handler._
   *
   * Related dart bug [167](http://code.google.com/p/dart/issues/detail?id=167)
   */
  EventHandler add(Action1<T> handler) {
    assert(!isDisposed);
    var wrapped = new EventHandler(handler);
    if(_handlers == null) {
      _handlers = new HashMap<int, Action1<T>>();
    }
    _handlers[wrapped.id] = handler; 
    return wrapped;
  }
  
  void addHandler(EventHandler handler) {
    assert(!isDisposed);
    if (_handlers == null) {
      _handlers = new HashMap<int, Action1<T>>();
    }
    _handlers[handler.id] = handler._handler;
  }

  bool remove(EventHandler handler) {
    if(_handlers != null) {
      return _handlers.remove(handler.id) != null;
    }
    else {
      return false;
    }
  }

  void disposeInternal() {
    super.disposeInternal();
    if(_handlers != null) {
      _handlers.clear();
      _handlers = null;
    }
  }
}
