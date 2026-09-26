part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ElseEndBlock extends _Block {
  final List<_Statement> statements = [];
  _IfThenElseBlock? partner;

  _ElseEndBlock(super.function, super.begin, super.end);

  @override
  int compareTo(_Block block) {
    if (identical(block, partner)) {
      return 1;
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
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('ElseEndBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    if (statements.length == 1 && statements[0] is _IfThenEndBlock) {
      out.print('else');
      statements[0].print(d, out);
    } else if (statements.length == 2 &&
        statements[0] is _IfThenElseBlock &&
        statements[1] is _ElseEndBlock) {
      out.print('else');
      statements[0].print(d, out);
      statements[1].print(d, out);
    } else {
      out.print('else');
      out.println();
      out.indent();
      _Statement.printSequence(d, out, statements);
      out.dedent();
      out.print('end');
    }
  }
}
