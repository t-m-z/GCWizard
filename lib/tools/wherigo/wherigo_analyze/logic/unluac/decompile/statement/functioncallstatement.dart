import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/functioncall.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';

class FunctionCallStatement extends Statement {
  final FunctionCall call;

  FunctionCallStatement(this.call);

  @override
  void print(Decompiler d, Output out) {
    call.print(d, out);
  }

  @override
  bool beginsWithParen() {
    return call.beginsWithParen();
  }
}