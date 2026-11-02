part of 'package:gc_wizard/tools/general_tools/gcwizardscript/logic/gcwizard_script.dart';

class _GCWList {
  late List<Object> _contents;

  _GCWList() {
    _contents = <Object>[];
  }

  int length() {
    return _contents.length;
  }

  void add(Object? value) {
    if (value != null) _contents.add(value);
  }

  void addall(_GCWList? list) {
    if (list != null) _contents.addAll(list._contents);
  }

  void clear() {
    _contents = [];
  }

  void shuffle() {
    _contents.shuffle();
  }

  static int _compare(Object a, Object b) {
    if (a is num && b is num) return a.compareTo(b);
    if (a is String && b is String) return a.compareTo(b);
    if (a is _GCWList && b is _GCWList) return a.length().compareTo(b.length());

    // Typreihenfolge: num < String < _GCWList
    int rank(Object o) => o is num ? 0 : o is String ? 1 : o is _GCWList ? 2 : 3;
    return rank(a).compareTo(rank(b));
  }

  void sort() {
    _contents.sort(_compare);
  }

  void sortDescending() {
    _contents.sort((a, b) => _compare(b, a));
  }

  // echte Umkehrung der aktuellen Reihenfolge (falls benötigt)
  void reverse() {
    _contents = _contents.reversed.toList();
  }

  void insert(int index, Object? value) {
    if (value != null) _contents.insert(index, value);
  }

  void remove(
      Object? element,
      ) {
    _contents.remove(element);
  }

  void removeAt(
    int index,
  ) {
    _contents.removeAt(index);
  }

  void removeLast() {
    _contents.removeLast();
  }

  @override
  String toString() {
    return _contents.toString();
  }

  Object getIndex(int index) {
    if (_contents.isEmpty) return 'NIL';
    if (index > _contents.length - 1) return 'NIL';
    return _contents[index];
  }

  List<Object> getContent() {
    return _contents;
  }

  List<Object> subList(int start, int end){
    return _contents.sublist(start, end);
  }}


void _listClear(_GCWList? list) {
  if (list != null) {
    list.clear();
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listAdd(_GCWList? list, Object? value) {
  if (list != null) {
    if (value != null) {
      list.add(value);
    }
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listSort(_GCWList? list, Object? mode) {
  if (list != null) {
    if (_isNotAInt(mode)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      switch (mode as int) {
        case 0:
          list.reverse();
          break;
        case 1:
          list.sort();
          break;
      }
    }
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listShuffle(_GCWList? list) {
  if (list != null) {
    list.shuffle();
  } else {
    _handleError(_INVALIDLIST);
  }
}

String _listToString(_GCWList? list) {
  if (list == null) {
    return '';
  } else {
    return list.toString();
  }
}

void _listAddAll(_GCWList? listto, _GCWList? listfrom) {
  if (listto != null) {
    listto.addall(listfrom);
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listInsert(_GCWList? list, Object? index, Object? value) {
  if (list != null) {
    if (_isNotAInt(index)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      if (index as int >= list.length()) {
        _handleError(_RANGEERROR);
      } else {
        list.insert(index, value);
      }
    }
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listRemove(_GCWList? list, Object? element){
  if (list != null) {
    list.remove(element);
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listRemoveLast(_GCWList? list){
  if (list != null) {
    list.removeLast();
  } else {
    _handleError(_INVALIDLIST);
  }
}

void _listRemoveAt(_GCWList? list, Object? index) {
  if (list != null) {
    if (_isNotAInt(index)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      if (index as int >= list.length()) {
        _handleError(_RANGEERROR);
      } else {
        list.removeAt(index);
      }
    }
  } else {
    _handleError(_INVALIDLIST);
  }
}

int _listLength(_GCWList? list) {
  if (list == null) {
    return 0;
  } else {
    return list.length();
  }
}

int _listIsEmpty(_GCWList? list) {
  if (list != null) {
    if (_listLength(list) == 0) return 1;
    return 0;
  } else {
    return 0;
  }
}

int _listIsNotEmpty(_GCWList? list) {
  return _listIsEmpty(list) == 1 ? 0 : 1;
}

Object? _listGet(_GCWList? list, Object? index) {
  if (list != null) {
    if (_isNotANumber(index)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      if (_isAInt(index)) {
        if (index as int >= list.length()) {
          _handleError(_RANGEERROR);
        } else {
          return list.getIndex(index);
        }
      } else if (_isADouble(index) && ((index as double) - (index).truncate() == 0)) {
        index = index.toInt();
        if (index as int >= list.length()) {
          _handleError(_RANGEERROR);
        } else {
          return list.getIndex(index);
        }
      } else {
        _handleError(_INVALIDTYPECAST);
      }
    }
  } else {
    _handleError(_INVALIDLIST);
    return null;
  }
  return null;
}

void _listFrom(Object? listName, Object? value) {
  if (_isNotAString(listName)) {
    _handleError(_INVALIDTYPECAST);
  } else {
    _state.variables[listName as String] = _GCWList();
    _listAdd(_state.variables[listName] as _GCWList, value);
  }
}

bool _gcwListContentEquals(_GCWList a, _GCWList b) {
  if (identical(a, b)) return true;
  final x = a.getContent();
  final y = b.getContent();
  if (x.length != y.length) return false;
  for (var i = 0; i < x.length; i++) {
    final ex = x[i];
    final ey = y[i];
    if (ex is _GCWList && ey is _GCWList) {
      if (!_gcwListContentEquals(ex, ey)) return false;
    } else if (ex.runtimeType != ey.runtimeType || ex != ey) {
      return false;
    }
  }
  return true;
}

int _listEquals(_GCWList? list1, _GCWList? list2) {
  if (list1 == null || list2 == null) {
    _handleError(_INVALIDLIST);
    return 0;
  }
  return _gcwListContentEquals(list1, list2) ? 1 : 0;
}

void _listSublist(Object? subListName, _GCWList? list, Object? start, Object? end) {
  if (_isNotAString(subListName)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  if (list == null) {
    _handleError(_INVALIDLIST);
    return;
  }
  if (_isNotAInt(start) || _isNotAInt(end)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }

  final s = start as int;
  final e = end as int;
  if (s < 0 || e > list.length() || s > e) {
    _handleError(_RANGEERROR);
    return;
  }

  final result = _GCWList();
  for (final element in list.subList(s, e)) {
    result.add(element);
  }
  _state.variables[subListName as String] = _GCWList();
  _listAddAll(_state.variables[subListName] as _GCWList, result);
}

