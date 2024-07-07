import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';

class GlobalExpression extends Expression {
  final String name;
  final int index;

  GlobalExpression(this.name, this.index) : super(Expression.PRECEDENCE_ATOMIC);

  @override
  int getConstantIndex() {
    return index;
  }

  @override
  bool isDotChain() {
    return true;
  }

  @override
  void print(Decompiler d, Output out) {
    out.print(name);
  }

  @override
  bool isBrief() {
    return true;
  }
}