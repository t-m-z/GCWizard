import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/binaryexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class EQNode extends Branch {
  final int left;
  final int right;
  final bool _invert;

  EQNode(this.left, this.right, this._invert, int line, int begin, int end)
      : super(line, begin, end);

  @override
  Branch invert() {
    return EQNode(left, right, !_invert, line, end, begin);
  }

  @override
  int getRegister() {
    return -1;
  }

  @override
  Expression asExpression(Registers r) {
    bool transpose = false;
    String op = _invert ? "!=" : "==";
    return BinaryExpression(
      op,
      r.getKExpression(!transpose ? left : right, line),
      r.getKExpression(!transpose ? right : left, line),
      Expression.PRECEDENCE_COMPARE,
      Expression.ASSOCIATIVITY_LEFT,
    );
  }

  @override
  void useExpression(Expression expression) {
    // Do nothing
  }
}