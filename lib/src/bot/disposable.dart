part of bot;

abstract class Disposable {
  void dispose();
  bool get isDisposed;
}

class DisposedError extends StateError {
  DisposedError() : super('Invalid operation on disposed object');
}
