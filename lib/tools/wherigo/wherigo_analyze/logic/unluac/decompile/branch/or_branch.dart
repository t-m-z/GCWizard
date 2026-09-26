part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _OrBranch extends _Branch {
  final _Branch left;
  final _Branch right;

  _OrBranch(this.left, this.right) : super(right.line, right.begin, right.end);

  @override
  _Branch invert() => _AndBranch(left.invert(), right.invert());

  @override
  int getRegister() {
    final rleft = left.getRegister();
    final rright = right.getRegister();
    return rleft == rright ? rleft : -1;
  }

  @override
  _Expression asExpression(_Registers r) {
    return _BinaryExpression('or', left.asExpression(r), right.asExpression(r),
        _Expression.precedenceOr, _Expression.associativityNone);
  }

  @override
  void useExpression(_Expression expression) {
    left.useExpression(expression);
    right.useExpression(expression);
  }
}
