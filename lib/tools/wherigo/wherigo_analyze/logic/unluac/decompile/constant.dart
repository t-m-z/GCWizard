part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

const Set<String> _reservedWords = {
  'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function',
  'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true',
  'until', 'while', //
};

bool _isLetter(int codeUnit) {
  final ch = String.fromCharCode(codeUnit);
  return RegExp(r'\p{L}', unicode: true).hasMatch(ch);
}

bool _isDigit(int codeUnit) => codeUnit >= 0x30 && codeUnit <= 0x39;

class _Constant {
  // 0 = nil, 1 = boolean, 2 = number, 3 = string
  final int type;
  final bool boolValue;
  final _LNumber? number;
  final String? string;

  _Constant.fromInt(int constant)
      : type = 2,
        boolValue = false,
        number = _LNumber.makeInteger(constant),
        string = null;

  _Constant(_LObject constant)
      : type = _typeOf(constant),
        boolValue = constant is _LBoolean && identical(constant, _LBoolean.ltrue),
        number = constant is _LNumber ? constant : null,
        string = constant is _LString ? constant.deref() : null;

  static int _typeOf(_LObject constant) {
    if (constant is _LNil) return 0;
    if (constant is _LBoolean) return 1;
    if (constant is _LNumber) return 2;
    if (constant is _LString) return 3;
    throw ArgumentError('Illegal constant type: $constant');
  }

  void print(_Decompiler d, _Output out, bool braced) {
    switch (type) {
      case 0:
        out.print('nil');
        break;
      case 1:
        out.print(boolValue ? 'true' : 'false');
        break;
      case 2:
        out.print(number.toString());
        break;
      case 3:
        _printString(d, out, braced);
        break;
      default:
        throw StateError('Illegal constant type: $type');
    }
  }

  void _printString(_Decompiler d, _Output out, bool braced) {
    final s = string!;
    var newlines = 0;
    var unprintable = 0;
    final rawstring = d.getConfiguration().rawstring;
    for (var i = 0; i < s.length; i++) {
      final c = s.codeUnitAt(i);
      if (c == 10) {
        newlines++;
      } else if ((c <= 31 && c != 9) || c >= 127) {
        unprintable++;
      }
    }
    if (unprintable == 0 &&
        (newlines > 1 || (newlines == 1 && s.indexOf('\n') != s.length - 1))) {
      var pipe = 0;
      final lc = s.codeUnitAt(s.length - 1);
      if (lc == 93 /* ']' */) {
        pipe = 1;
      }
      var pipeString = ']]';
      while (s.contains(pipeString)) {
        pipe++;
        pipeString = ']${'=' * pipe}]';
      }
      if (braced) out.print('(');
      out.print('[');
      out.print('=' * pipe);
      out.print('[');
      final indent = out.indentationLevel;
      out.indentationLevel = 0;
      out.println();
      out.print(s);
      out.print(']');
      out.print('=' * pipe);
      out.print(']');
      if (braced) out.print(')');
      out.indentationLevel = indent;
    } else {
      out.print('"');
      for (var i = 0; i < s.length; i++) {
        final c = s.codeUnitAt(i);
        if (c <= 31 || c >= 127) {
          if (c == 7) {
            out.print('\\a');
          } else if (c == 8) {
            out.print('\\b');
          } else if (c == 12) {
            out.print('\\f');
          } else if (c == 10) {
            out.print('\\n');
          } else if (c == 13) {
            out.print('\\r');
          } else if (c == 9) {
            out.print('\\t');
          } else if (c == 11) {
            out.print('\\v');
          } else if (!rawstring || c <= 127) {
            final dec = c.toString();
            out.print('\\');
            out.print('0' * (3 - dec.length));
            out.print(dec);
          } else {
            out.printByte(c & 0xFF);
          }
        } else if (c == 34) {
          out.print('\\"');
        } else if (c == 92) {
          out.print('\\\\');
        } else {
          out.print(String.fromCharCode(c));
        }
      }
      out.print('"');
    }
  }

  bool get isNil => type == 0;

  bool get isBoolean => type == 1;

  bool get isNumber => type == 2;

  bool get isInteger => number!.value() == number!.value().roundToDouble();

  int asInteger() {
    if (!isInteger) {
      throw StateError('Constant is not an integer');
    }
    return number!.value().toInt();
  }

  bool get isString => type == 3;

  bool get isIdentifier {
    if (!isString) return false;
    final s = string!;
    if (_reservedWords.contains(s)) return false;
    if (s.isEmpty) return false;
    final start = s.codeUnitAt(0);
    if (start != 95 /* _ */ && !_isLetter(start)) return false;
    for (var i = 1; i < s.length; i++) {
      final next = s.codeUnitAt(i);
      if (_isLetter(next)) continue;
      if (_isDigit(next)) continue;
      if (next == 95) continue;
      return false;
    }
    return true;
  }

  String asName() {
    if (type != 3) {
      throw StateError('Constant is not a string');
    }
    return string!;
  }
}
