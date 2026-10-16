part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _EQNode extends _Branch {
  final int left;
  final int right;
  final bool invert_;

  _EQNode(this.left, this.right, this.invert_, int line, int begin, int end)
      : super(line, begin, end);

  @override
  _Branch invert() => _EQNode(left, right, !invert_, line, end, begin);

  @override
  int getRegister() => -1;

  @override
  _Expression asExpression(_Registers r) {
    final op = invert_ ? '~=' : '==';
    return _BinaryExpression(
        op,
        r.getKExpression(left, line),
        r.getKExpression(right, line),
        _Expression.precedenceCompare,
        _Expression.associativityLeft);
  }

  @override
  void useExpression(_Expression expression) {
    /* Do nothing */
  }
}
