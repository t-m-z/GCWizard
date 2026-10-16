part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _UnaryExpression extends _Expression {
  final String op;
  final _Expression expression;

  _UnaryExpression(this.op, this.expression, int precedence) : super(precedence);

  @override
  bool get isUngrouped => true;

  @override
  int get constantIndex => expression.constantIndex;

  @override
  void print(_Decompiler d, _Output out) {
    out.print(op);
    final group = precedence > expression.precedence;
    if (group) out.print('(');
    expression.print(d, out);
    if (group) out.print(')');
  }
}
