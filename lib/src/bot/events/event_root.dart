part of bot;

abstract class EventRoot<T> {
  EventHandler add(Action1<T> handler);
  void addHandler(EventHandler handler);
  bool remove(EventHandler handler);
}
