part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Statement {
  /// Prints a sequence of statements on separate lines, informing the last
  /// statement that it is last in the block.
  static void printSequence(_Decompiler d, _Output out, List<_Statement> stmts) {
    final n = stmts.length;
    for (var i = 0; i < n; i++) {
      final last = i + 1 == n;
      final stmt = stmts[i];
      if (stmt.beginsWithParen &&
          (i > 0 || d.getVersion().isAllowedPreceedingSemicolon())) {
        out.print(';');
      }
      if (last) {
        stmt.printTail(d, out);
      } else {
        stmt.print(d, out);
      }
      if (stmt is! _IfThenElseBlock) {
        out.println();
      }
    }
  }

  void print(_Decompiler d, _Output out);

  void printTail(_Decompiler d, _Output out) {
    print(d, out);
  }

  String? comment;

  void addComment(String comment) {
    this.comment = comment;
  }

  bool get beginsWithParen => false;
}
