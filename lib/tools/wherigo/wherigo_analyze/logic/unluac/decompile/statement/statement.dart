import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/ifthenelseblock.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';

class Statement {
  /// Prints out a sequence of statements on separate lines. Correctly
  /// informs the last statement that it is last in a block.
  static void printSequence(Decompiler d, Output out, List<Statement> stmts) {
    int n = stmts.length;
    for (int i = 0; i < n; i++) {
      bool last = (i + 1 == n);
      Statement stmt = stmts[i];
      if ((stmt.beginsWithParen() ?? false) && (i > 0 || d.getVersion().isAllowedPreceedingSemicolon())) {
        out.print(";");
      }
      if (last) {
        stmt.printTail(d, out);
      } else {
        stmt.print(d, out);
      }
      if (!(stmt is IfThenElseBlock)) {
        out.println();
      }
    }
  }

  void print(Decompiler d, Output out) {
    // TODO: implement print
  }

  void printTail(Decompiler d, Output out) {
    print(d, out);
  }

  String? comment;

  void addComment(String comment) {
    this.comment = comment;
  }

  bool? beginsWithParen() {
    return false;
  }
}