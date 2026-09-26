part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TableLiteralEntry implements Comparable<_TableLiteralEntry> {
  final _Expression key;
  final _Expression value;
  final bool isList;
  final int timestamp;

  _TableLiteralEntry(this.key, this.value, this.isList, this.timestamp);

  @override
  int compareTo(_TableLiteralEntry e) => timestamp.compareTo(e.timestamp);
}

class _TableLiteral extends _Expression {
  final List<_TableLiteralEntry> _entries = [];

  bool _isObject = true;
  bool _isList = true;
  int _listLength = 1;
  final int _capacity;

  _TableLiteral(int arraySize, int hashSize)
      : _capacity = arraySize + hashSize,
        super(_Expression.precedenceAtomic);

  @override
  int get constantIndex {
    var index = -1;
    for (final entry in _entries) {
      final k = entry.key.constantIndex;
      final v = entry.value.constantIndex;
      if (k > index) index = k;
      if (v > index) index = v;
    }
    return index;
  }

  // Sorts entries by timestamp, preserving relative order between entries
  // that share a timestamp. Multiple registers written by a single "open"
  // call (CALL with C == 0) all get the same updated-at line, so ties are
  // common; List.sort is not guaranteed stable (unlike Java's
  // Collections.sort, which unluac relies on), so a plain _entries.sort()
  // can reorder tied entries arbitrarily and corrupt list-literal indices.
  void _stableSortEntries() {
    final decorated =
    List<(int, _TableLiteralEntry)>.generate(_entries.length, (i) {
      return (i, _entries[i]);
    });
    decorated.sort((a, b) {
      final cmp = a.$2.compareTo(b.$2);
      return cmp != 0 ? cmp : a.$1.compareTo(b.$1);
    });
    for (var i = 0; i < decorated.length; i++) {
      _entries[i] = decorated[i].$2;
    }
  }

  @override
  void print(_Decompiler d, _Output out) {
    _stableSortEntries();
    _listLength = 1;
    if (_entries.isEmpty) {
      out.print('{}');
    } else {
      var lineBreak = (_isList && _entries.length > 5) ||
          (_isObject && _entries.length > 2) ||
          !_isObject;
      if (!lineBreak) {
        for (final entry in _entries) {
          if (!entry.value.isBrief) {
            lineBreak = true;
            break;
          }
        }
      }
      out.print('{');
      if (lineBreak) {
        out.println();
        out.indent();
      }
      _printEntry(d, 0, out);
      if (!_entries[0].value.isMultiple) {
        for (var index = 1; index < _entries.length; index++) {
          out.print(',');
          if (lineBreak) {
            out.println();
          } else {
            out.print(' ');
          }
          _printEntry(d, index, out);
          if (_entries[index].value.isMultiple) {
            break;
          }
        }
      }
      if (lineBreak) {
        out.println();
        out.dedent();
      }
      out.print('}');
    }
  }

  void _printEntry(_Decompiler d, int index, _Output out) {
    final entry = _entries[index];
    final key = entry.key;
    final value = entry.value;
    final isList = entry.isList;
    final multiple = index + 1 >= _entries.length || value.isMultiple;
    if (isList && key.isInteger && _listLength == key.asInteger()) {
      if (multiple) {
        value.printMultiple(d, out);
      } else {
        value.print(d, out);
      }
      _listLength++;
    } else if (_isObject && key.isIdentifier) {
      out.print(key.asName());
      out.print(' = ');
      value.print(d, out);
    } else {
      out.print('[');
      key.printBraced(d, out);
      out.print('] = ');
      value.print(d, out);
    }
  }

  @override
  bool get isTableLiteral => true;

  @override
  bool get isUngrouped => true;

  @override
  bool get isNewEntryAllowed => _entries.length < _capacity;

  @override
  void addEntry(_TableLiteralEntry entry) {
    _entries.add(entry);
    _isObject = _isObject && (entry.isList || entry.key.isIdentifier);
    _isList = _isList && entry.isList;
  }

  @override
  bool get isBrief => false;
}