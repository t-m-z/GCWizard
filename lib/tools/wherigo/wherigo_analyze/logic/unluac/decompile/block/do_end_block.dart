part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _DoEndBlock extends _Block {
  final List<_Statement> statements = [];

  _DoEndBlock(super.function, super.begin, super.end);

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }

  @override
  bool breakable() => false;

  @override
  bool isContainer() => true;

  @override
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('DoEndBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.println('do');
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }
}
