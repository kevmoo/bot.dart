part of bot;

class AttachedEvent<T> extends Attachable {

  AttachedEvent(String name) : super(name);

  EventHandler addHandler(AttachableObject obj, Action1<T> handler) {
    return obj._addHandler(this, handler);
  }

  bool removeHandler(AttachableObject obj, EventHandler handlerId) {
    requireArgumentNotNull(obj, 'obj');
    return obj._removeHandler(this, handlerId);
  }

  void fireEvent(AttachableObject obj, T args) => obj._fireEvent(this, args);
}
