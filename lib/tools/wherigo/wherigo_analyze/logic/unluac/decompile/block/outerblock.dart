import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/return.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';

class OuterBlock extends Block {
  final List<Statement> statements;

  OuterBlock(LFunction function, int length)
      : statements = List<Statement>.filled(length, Statement(), growable: true),
        super(function, 0, length + 1);

  @override
  void addStatement(Statement statement) {
    statements.add(statement);
  }

  @override
  bool breakable() {
    return false;
  }

  @override
  bool isContainer() {
    return true;
  }

  @override
  bool isUnprotected() {
    return false;
  }

  @override
  int getLoopback() {
    throw StateError('Illegal state');
  }

  @override
  int scopeEnd() {
    return (end - 1) + function.header.version.getOuterBlockScopeAdjustment();
  }

  @override
  void print(Decompiler d, Output out) {
    /* extra return statement */
    int last = statements.length - 1;
    if (last < 0 || !(statements[last] is Return)) {
      throw StateError(statements[last].toString());
    }
    statements.removeAt(last);
    Statement.printSequence(d, out, statements);
  }
}