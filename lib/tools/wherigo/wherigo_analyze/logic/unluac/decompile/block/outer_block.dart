part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _OuterBlock extends _Block {
  final List<_Statement> statements = [];

  _OuterBlock(_LFunction function, int length) : super(function, 0, length + 1);

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
  int getLoopback() => throw StateError('OuterBlock has no loopback');

  @override
  int scopeEnd() =>
      (end - 1) + function.header.version.getOuterBlockScopeAdjustment();

  @override
  void print(_Decompiler d, _Output out) {
    // Drop the extra trailing return statement.
    final last = statements.length - 1;
    if (last < 0 || statements[last] is! _ReturnStatement) {
      throw StateError(
          last < 0 ? 'empty outer block' : statements[last].toString());
    }
    statements.removeAt(last);
    _Statement.printSequence(d, out, statements);
  }
}
