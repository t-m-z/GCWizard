import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';

class UnaryExpression extends Expression {
  final String op;
  final Expression expression;

  UnaryExpression(this.op, this.expression, int precedence) : super(precedence);

  @override
  bool isUngrouped() {
    return true;
  }

  @override
  int getConstantIndex() {
    return expression.getConstantIndex();
  }

  @override
  void print(Decompiler d, Output out) {
    out.print(op);
    if (precedence > expression.precedence) out.print("(");
    expression.print(d, out);
    if (precedence > expression.precedence) out.print(")");
  }
}