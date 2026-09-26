part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// A simple growable LIFO stack, ported from unluac's util.Stack.
class _Stack<T> {
  final List<T> _data = [];

  bool get isEmpty => _data.isEmpty;

  T peek() => _data[_data.length - 1];

  T pop() => _data.removeLast();

  void push(T item) {
    if (_data.length > 65536) {
      throw StateError('Trying to push more than 65536 items!');
    }
    _data.add(item);
  }

  int get size => _data.length;

  void reverse() {
    final reversed = _data.reversed.toList();
    _data
      ..clear()
      ..addAll(reversed);
  }
}
