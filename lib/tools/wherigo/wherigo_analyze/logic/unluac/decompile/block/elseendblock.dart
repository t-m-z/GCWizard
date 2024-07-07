import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/ifthenelseblock.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/ifthenendblock.dart';

class ElseEndBlock extends Block {
  final List<Statement> statements;
  IfThenElseBlock? partner;

  ElseEndBlock(LFunction function, int begin, int end)
      : statements = List<Statement>.filled(end - begin + 1, Statement()),
        super(function, begin, end);

  @override
  int compareTo(Block block) {
    if (block == partner) {
      return 1;
    } else {
      int result = super.compareTo(block);
      if (result == 0 && block is ElseEndBlock) {
        print("HEY HEY HEY");
      }
      return result;
    }
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
  void addStatement(Statement statement) {
    statements.add(statement);
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
  void print(Decompiler d, Output out) {
    if (statements.length == 1 && statements[0] is IfThenEndBlock) {
      out.print('else');
      statements[0].print(d, out);
    } else if (statements.length == 2 &&
        statements[0] is IfThenElseBlock &&
        statements[1] is ElseEndBlock) {
      out.print('else');
      statements[0].print(d, out);
      statements[1].print(d, out);
    } else {
      out.print('else');
      out.println();
      out.indent();
      Statement.printSequence(d, out, statements);
      out.dedent();
      out.print('end');
    }
  }
}