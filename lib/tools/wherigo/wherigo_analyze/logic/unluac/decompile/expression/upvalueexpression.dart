import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';

class UpvalueExpression extends Expression {
  final String name;

  UpvalueExpression(this.name) : super(Expression.PRECEDENCE_ATOMIC);

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
    out.print(name);
  }

  @override
  bool isBrief() {
    return true;
  }

  @override
  bool isEnvironmentTable(Decompiler d) {
    return d.getVersion().isEnvironmentTable(name);
  }
}