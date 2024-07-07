import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/declaration.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';

class Declare extends Statement {
  final List<Declaration> decls;

  Declare(this.decls);

  @override
  void print(Decompiler d, Output out) {
    out.print('local ');
    out.print(decls[0].name);
    for (int i = 1; i < decls.length; i++) {
      out.print(', ');
      out.print(decls[i].name);
    }
  }
}