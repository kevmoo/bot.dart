part of bot;

// TODO: ponder wrapping StreamController instead of extending
// so there is no weirdness with the asBroadcast magic

class EventHandle<T> extends async.StreamController<T> implements Disposable {
  bool _disposed = false;
  async.Stream _broadcastCache;

  EventHandle({void onCancel()}) : super(onCancel: onCancel);

  void dispose(){
    if(_disposed) {
      throw const DisposedError();
    }
    // Set disposed_ to true first, in case during the chain of disposal this
    // gets disposed recursively.
    this._disposed = true;
    super.close();
  }

  async.Stream get stream {
    if(_broadcastCache == null) {
      _broadcastCache = super.stream.asBroadcastStream();
    }
    return _broadcastCache;
  }

  bool get isDisposed => _disposed;
}
