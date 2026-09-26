part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ForBlock extends _Block {
  final int register;
  final _Registers r;
  final List<_Statement> statements = [];

  _ForBlock(super.function, super.begin, super.end, this.register, this.r);

  @override
  int scopeEnd() => end - 2;

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }

  @override
  bool breakable() => true;

  @override
  bool isContainer() => true;

  @override
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('ForBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('for ');
    if (function.header.version == _Version.lua50) {
      r.getTarget(register, begin - 1).print(d, out);
    } else {
      r.getTarget(register + 3, begin - 1).print(d, out);
    }
    out.print(' = ');
    if (function.header.version == _Version.lua50) {
      r.getValue(register, begin - 2).print(d, out);
    } else {
      r.getValue(register, begin - 1).print(d, out);
    }
    out.print(', ');
    r.getValue(register + 1, begin - 1).print(d, out);
    final step = r.getValue(register + 2, begin - 1);
    if (!step.isInteger || step.asInteger() != 1) {
      out.print(', ');
      step.print(d, out);
    }
    out.print(' do');
    out.println();
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }
}
