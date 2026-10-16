part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _IfThenElseBlock extends _Block {
  final _Branch branch;
  final int loopback;
  final _Registers r;
  final List<_Statement> statements = [];
  final bool emptyElse;
  _ElseEndBlock? partner;

  _IfThenElseBlock(
      _LFunction function, this.branch, this.loopback, this.emptyElse, this.r)
      : super(function, branch.begin, branch.end);

  @override
  int compareTo(_Block block) {
    if (identical(block, partner)) {
      return -1;
    } else {
      return super.compareTo(block);
    }
  }

  @override
  bool breakable() => false;

  @override
  bool isContainer() => true;

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }

  @override
  int scopeEnd() => end - 2;

  @override
  bool isUnprotected() => true;

  @override
  int getLoopback() => loopback;

  @override
  void print(_Decompiler d, _Output out) {
    out.print('if ');
    branch.asExpression(r).print(d, out);
    out.print(' then');
    out.println();
    out.indent();
    // Handle the case where the "then" is empty in if-then-else.
    // The jump over the else block is falsely detected as a break.
    if (statements.length == 1 && statements[0] is _BreakBlock) {
      final b = statements[0] as _BreakBlock;
      if (b.target == loopback) {
        out.dedent();
        return;
      }
    }
    _Statement.printSequence(d, out, statements);
    out.dedent();
    if (emptyElse) {
      out.println('else');
      out.println('end');
    }
  }
}
