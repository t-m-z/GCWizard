import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/binaryexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/orbranch.dart';

class AndBranch extends Branch {
  final Branch left;
  final Branch right;

  AndBranch(this.left, this.right) : super(right.line, right.begin, right.end);

  @override
  Branch invert() {
    return OrBranch(left.invert(), right.invert());
  }

  /*
  @override
  Branch invert() {
    return NotBranch(OrBranch(left.invert(), right.invert()));
  }
  */

  @override
  int getRegister() {
    int rleft = left.getRegister();
    int rright = right.getRegister();
    return rleft == rright ? rleft : -1;
  }

  @override
  Expression asExpression(Registers r) {
    return BinaryExpression("and", left.asExpression(r), right.asExpression(r), Expression.PRECEDENCE_AND, Expression.ASSOCIATIVITY_NONE);
  }

  @override
  void useExpression(Expression expression) {
    left.useExpression(expression);
    right.useExpression(expression);
  }
}