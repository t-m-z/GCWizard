import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';

class WhileBlock extends Block {
  final Branch branch;
  final int loopback;
  final Registers r;
  final List<Statement> statements;

  WhileBlock(LFunction function, Branch branch, int loopback, Registers r)
      : branch = branch,
        loopback = loopback,
        r = r,
        statements = List<Statement>.filled(branch.end - branch.begin + 1, Statement(), growable: true),
        super(function, branch.begin, branch.end);

  @override
  int scopeEnd() {
    return end - 2;
  }

  @override
  bool breakable() {
    return true;
  }

  @override
  bool isContainer() {
    return true;
  }

  @override
  void addStatement(Statement statement) {
    statements.add(statement);
  }

  @override
  bool isUnprotected() {
    return true;
  }

  @override
  int getLoopback() {
    return loopback;
  }

  @override
  void print(Decompiler d, Output out) {
    out.print('while ');
    branch.asExpression(r).print(d, out);
    out.print(' do');
    out.println();
    out.indent();
    Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }
}