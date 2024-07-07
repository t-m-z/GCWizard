import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/binaryexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/unaryexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class LENode extends Branch {
  final int left;
  final int right;
  final bool _invert;

  LENode(this.left, this.right, this._invert, int line, int begin, int end) : super(line, begin, end);

  @override
  Branch invert() {
    return LENode(left, right, !_invert, line, end, begin);
  }

  @override
  int getRegister() {
    return -1;
  }

  @override
  Expression asExpression(Registers r) {
    bool transpose = false;
    Expression leftExpression = r.getKExpression(left, line);
    Expression rightExpression = r.getKExpression(right, line);
    if (!leftExpression.isConstant() && !rightExpression.isConstant()) {
      transpose = r.getUpdated(left, line) > r.getUpdated(right, line);
    } else {
      transpose = rightExpression.getConstantIndex() < leftExpression.getConstantIndex();
    }
    String op = !transpose ? "<=" : ">=";
    Expression rtn = BinaryExpression(op, !transpose ? leftExpression : rightExpression, !transpose ? rightExpression : leftExpression, Expression.PRECEDENCE_COMPARE, Expression.ASSOCIATIVITY_LEFT);
    if (_invert) {
      rtn = UnaryExpression("not ", rtn, Expression.PRECEDENCE_UNARY);
    }
    return rtn;
  }

  @override
  void useExpression(Expression expression) {
    // Do nothing
  }
}