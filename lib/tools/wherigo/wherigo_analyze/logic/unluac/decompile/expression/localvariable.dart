import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/declaration.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';

class LocalVariable extends Expression {
  final Declaration decl;

  LocalVariable(this.decl) : super(Expression.PRECEDENCE_ATOMIC);

  @override
  int getConstantIndex() {
    return -1;
  }

  @override
  bool isDotChain() {
    return true;
  }

  @override
  void print(Decompiler d, Output out) {
    out.print(decl.name);
  }

  @override
  bool isBrief() {
    return true;
  }
}
