import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lboolean.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/constant.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/constantexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class TrueNode extends Branch {
  final int register;
  final bool _invert;

  TrueNode(this.register, this._invert, int line, int begin, int end) : super(line, begin, end) {
    setTarget = register;
    // isTest = true;
  }

  @override
  Branch invert() {
    return TrueNode(register, !_invert, line, end, begin);
  }

  @override
  int getRegister() {
    return register;
  }

  @override
  Expression asExpression(Registers r) {
    return ConstantExpression(Constant(_invert ? LBoolean.LTRUE : LBoolean.LFALSE), -1);
  }

  @override
  void useExpression(Expression expression) {
    /* Do nothing */
  }

  @override
  String toString() {
    return 'TrueNode[invert=$_invert;line=$line;begin=$begin;end=$end]';
  }
}