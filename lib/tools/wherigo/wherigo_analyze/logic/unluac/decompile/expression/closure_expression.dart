part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ClosureExpression extends _Expression {
  final _LFunction function;
  final int upvalueLine;
  final List<_Declaration> declList;

  _ClosureExpression(this.function, this.declList, this.upvalueLine)
      : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex => -1;

  @override
  bool get isClosure => true;

  @override
  bool get isUngrouped => true;

  @override
  bool isUpvalueOf(int register) {
    for (final upvalue in function.upvalues) {
      if (upvalue.instack && upvalue.idx == register) {
        return true;
      }
    }
    return false;
  }

  @override
  int closureUpvalueLine() => upvalueLine;

  @override
  void print(_Decompiler outer, _Output out) {
    final d = _Decompiler(function, outer.declList, upvalueLine);
    out.print('function');
    _printMain(out, d, true);
  }

  @override
  void printClosure(_Decompiler d, _Output out, _Target name) {
    final decompiler = _Decompiler(function, d.declList, upvalueLine);
    out.print('function ');
    if (function.numParams >= 1 &&
        decompiler.declList[0].name == 'self' &&
        name is _TableTarget) {
      name.printMethod(d, out);
      _printMain(out, decompiler, false);
    } else {
      name.print(d, out);
      _printMain(out, decompiler, true);
    }
  }

  void _printMain(_Output out, _Decompiler d, bool includeFirst) {
    out.print('(');
    final start = includeFirst ? 0 : 1;
    if (function.numParams > start) {
      _VariableTarget(d.declList[start]).print(d, out);
      for (var i = start + 1; i < function.numParams; i++) {
        out.print(', ');
        _VariableTarget(d.declList[i]).print(d, out);
      }
    }
    if ((function.vararg & 1) == 1) {
      if (function.numParams > start) {
        out.print(', ...');
      } else {
        out.print('...');
      }
    }
    out.print(')');
    out.println();
    out.indent();
    d.decompile();
    d.print(out);
    out.dedent();
    out.print('end');
  }
}
