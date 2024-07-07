import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class TestSetNode extends Branch {
  final int test;
  final bool _invert;
  final int setTarget;

  TestSetNode(int target, this.test, this._invert, int line, int begin, int end)
      : setTarget = target,
        super(line, begin, end);

  @override
  Branch invert() {
    return TestSetNode(setTarget, test, !_invert, line, end, begin);
  }

  @override
  int getRegister() {
    return setTarget;
  }

  @override
  Expression asExpression(Registers r) {
    return r.getExpression(test, line);
  }

  @override
  void useExpression(Expression expression) {
    // Do nothing
  }

  @override
  String toString() {
    return 'TestSetNode[target=$setTarget;test=$test;invert=$_invert;line=$line;begin=$begin;end=$end]';
  }
}