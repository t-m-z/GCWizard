part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ReturnStatement extends _Statement {
  final List<_Expression> values;

  _ReturnStatement([this.values = const []]);

  @override
  void print(_Decompiler d, _Output out) {
    out.print('do ');
    printTail(d, out);
    out.print(' end');
  }

  @override
  void printTail(_Decompiler d, _Output out) {
    out.print('return');
    if (values.isNotEmpty) {
      out.print(' ');
      _Expression.printSequence(d, out, values, false, true);
    }
  }
}
