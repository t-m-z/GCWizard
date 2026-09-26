part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _BinaryExpression extends _Expression {
  final String op;
  final _Expression left;
  final _Expression right;
  final int associativity;

  _BinaryExpression(
      this.op, this.left, this.right, int precedence, this.associativity)
      : super(precedence);

  @override
  bool get isUngrouped => !beginsWithParen;

  @override
  int get constantIndex {
    final l = left.constantIndex;
    final r = right.constantIndex;
    return l > r ? l : r;
  }

  @override
  bool get beginsWithParen => _leftGroup() || left.beginsWithParen;

  @override
  void print(_Decompiler d, _Output out) {
    final leftGroup = _leftGroup();
    final rightGroup = _rightGroup();
    if (leftGroup) out.print('(');
    left.print(d, out);
    if (leftGroup) out.print(')');
    out.print(' ');
    out.print(op);
    out.print(' ');
    if (rightGroup) out.print('(');
    right.print(d, out);
    if (rightGroup) out.print(')');
  }

  bool _leftGroup() =>
      precedence > left.precedence ||
      (precedence == left.precedence &&
          associativity == _Expression.associativityRight);

  bool _rightGroup() =>
      precedence > right.precedence ||
      (precedence == right.precedence &&
          associativity == _Expression.associativityLeft);
}
