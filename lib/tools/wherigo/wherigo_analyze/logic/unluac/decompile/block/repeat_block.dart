part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _RepeatBlock extends _Block {
  final _Branch branch;
  final _Registers r;
  final List<_Statement> statements = [];

  _RepeatBlock(_LFunction function, this.branch, this.r)
      : super(function, branch.end, branch.begin);

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
  int getLoopback() => throw StateError('RepeatBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('repeat');
    out.println();
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('until ');
    branch.asExpression(r).print(d, out);
  }
}
