import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/notbranch.dart';

class TestNode extends Branch {
  final int test;
  final bool _invert;

  TestNode(this.test, this._invert, int line, int begin, int end)
      : super(line, begin, end) {
    isTest = true;
  }

  @override
  Branch invert() {
    return TestNode(test, !_invert, line, end, begin);
  }

  @override
  int getRegister() {
    return test;
  }

  @override
  Expression asExpression(Registers r) {
    if (_invert) {
      return NotBranch(invert()).asExpression(r);
    } else {
      return r.getExpression(test, line);
    }
  }

  @override
  void useExpression(Expression expression) {
    // Do nothing
  }

  @override
  String toString() {
    return 'TestNode[test=$test;invert=$_invert;line=$line;begin=$begin;end=$end]';
  }
}