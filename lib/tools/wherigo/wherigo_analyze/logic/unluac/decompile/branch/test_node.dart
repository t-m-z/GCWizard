part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TestNode extends _Branch {
  final int test;
  final bool invert_;

  _TestNode(this.test, this.invert_, int line, int begin, int end)
      : super(line, begin, end) {
    isTest = true;
  }

  @override
  _Branch invert() => _TestNode(test, !invert_, line, end, begin);

  @override
  int getRegister() => test;

  @override
  _Expression asExpression(_Registers r) {
    if (invert_) {
      return _NotBranch(invert()).asExpression(r);
    } else {
      return r.getExpression(test, line);
    }
  }

  @override
  void useExpression(_Expression expression) {
    /* Do nothing */
  }

  @override
  String toString() =>
      'TestNode[test=$test;invert=$invert_;line=$line;begin=$begin;end=$end]';
}
