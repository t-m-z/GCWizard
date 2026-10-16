part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TestSetNode extends _Branch {
  final int test;
  final bool invert_;

  _TestSetNode(int target, this.test, this.invert_, int line, int begin, int end)
      : super(line, begin, end) {
    setTarget = target;
  }

  @override
  _Branch invert() => _TestSetNode(setTarget, test, !invert_, line, end, begin);

  @override
  int getRegister() => setTarget;

  @override
  _Expression asExpression(_Registers r) => r.getExpression(test, line);

  @override
  void useExpression(_Expression expression) {
    /* Do nothing */
  }

  @override
  String toString() =>
      'TestSetNode[target=$setTarget;test=$test;invert=$invert_;line=$line;begin=$begin;end=$end]';
}
