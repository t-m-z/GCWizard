part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TForBlock extends _Block {
  final int register;
  final int length;
  final _Registers r;
  final List<_Statement> statements = [];

  _TForBlock(super.function, super.begin, super.end, this.register, this.length,
      this.r);

  @override
  int scopeEnd() => end - 3;

  @override
  bool breakable() => true;

  @override
  bool isContainer() => true;

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }

  @override
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('TForBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('for ');
    if (function.header.version == _Version.lua50) {
      r.getTarget(register + 2, begin - 1).print(d, out);
      for (var r1 = register + 3; r1 <= register + 2 + length; r1++) {
        out.print(', ');
        r.getTarget(r1, begin - 1).print(d, out);
      }
    } else {
      r.getTarget(register + 3, begin - 1).print(d, out);
      for (var r1 = register + 4; r1 <= register + 2 + length; r1++) {
        out.print(', ');
        r.getTarget(r1, begin - 1).print(d, out);
      }
    }
    out.print(' in ');
    _Expression value;
    value = r.getValue(register, begin - 1);
    value.print(d, out);
    if (!value.isMultiple) {
      out.print(', ');
      value = r.getValue(register + 1, begin - 1);
      value.print(d, out);
      if (!value.isMultiple) {
        out.print(', ');
        value = r.getValue(register + 2, begin - 1);
        value.print(d, out);
      }
    }
    out.print(' do');
    out.println();
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }
}
