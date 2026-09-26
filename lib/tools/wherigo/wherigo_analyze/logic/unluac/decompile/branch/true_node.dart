part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TrueNode extends _Branch {
  final int register;
  final bool invert_;

  _TrueNode(this.register, this.invert_, int line, int begin, int end)
      : super(line, begin, end) {
    setTarget = register;
  }

  @override
  _Branch invert() => _TrueNode(register, !invert_, line, end, begin);

  @override
  int getRegister() => register;

  @override
  _Expression asExpression(_Registers r) {
    return _ConstantExpression(
        _Constant(invert_ ? _LBoolean.ltrue : _LBoolean.lfalse), -1);
  }

  @override
  void useExpression(_Expression expression) {
    /* Do nothing */
  }

  @override
  String toString() =>
      'TrueNode[invert=$invert_;line=$line;begin=$begin;end=$end]';
}
