part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _WhileBlock extends _Block {
  final _Branch branch;
  final int loopback;
  final _Registers r;
  final List<_Statement> statements = [];

  _WhileBlock(_LFunction function, this.branch, this.loopback, this.r)
      : super(function, branch.begin, branch.end);

  @override
  int scopeEnd() => end - 2;

  @override
  bool breakable() => true;

  @override
  bool isContainer() => true;

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }

  @override
  bool isUnprotected() => true;

  @override
  int getLoopback() => loopback;

  @override
  void print(_Decompiler d, _Output out) {
    out.print('while ');
    branch.asExpression(r).print(d, out);
    out.print(' do');
    out.println();
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }
}
