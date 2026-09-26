part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LTNode extends _Branch {
  final int left;
  final int right;
  final bool invert_;

  _LTNode(this.left, this.right, this.invert_, int line, int begin, int end)
      : super(line, begin, end);

  @override
  _Branch invert() => _LTNode(left, right, !invert_, line, end, begin);

  @override
  int getRegister() => -1;

  @override
  _Expression asExpression(_Registers r) {
    bool transpose;
    final leftExpression = r.getKExpression(left, line);
    final rightExpression = r.getKExpression(right, line);
    if (!leftExpression.isConstant && !rightExpression.isConstant) {
      transpose = r.getUpdated(left, line) > r.getUpdated(right, line);
    } else {
      transpose = rightExpression.constantIndex < leftExpression.constantIndex;
    }
    final op = !transpose ? '<' : '>';
    _Expression rtn = _BinaryExpression(
        op,
        !transpose ? leftExpression : rightExpression,
        !transpose ? rightExpression : leftExpression,
        _Expression.precedenceCompare,
        _Expression.associativityLeft);
    if (invert_) {
      rtn = _UnaryExpression('not ', rtn, _Expression.precedenceUnary);
    }
    return rtn;
  }

  @override
  void useExpression(_Expression expression) {
    /* Do nothing */
  }
}
