part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// Collects decompiled source text via an [OutputProvider], tracking
/// indentation and column position exactly like unluac's Output class.
class _Output {
  final _OutputProvider _out;
  int indentationLevel = 0;
  int position = 0;

  _Output(this._out);

  void indent() {
    indentationLevel += 2;
  }

  void dedent() {
    indentationLevel -= 2;
  }

  void _start() {
    if (position == 0) {
      for (var i = indentationLevel; i != 0; i--) {
        _out.printString(' ');
        position++;
      }
    }
  }

  void print(String s) {
    _start();
    _out.printString(s);
    position += s.length;
  }

  void printByte(int b) {
    _start();
    _out.printByte(b);
    position += 1;
  }

  void println([String? s]) {
    if (s != null) {
      print(s);
    }
    _start();
    _out.println();
    position = 0;
  }
}
