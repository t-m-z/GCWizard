import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/binaryexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/andbranch.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class OrBranch extends Branch {
  final Branch left;
  final Branch right;

  OrBranch(this.left, this.right) : super(right.line, right.begin, right.end);

  @override
  Branch invert() {
    return AndBranch(left.invert(), right.invert());
  }

  /*
  @override
  Branch invert() {
    return NotBranch(AndBranch(left.invert(), right.invert()));
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
    return BinaryExpression("or", left.asExpression(r), right.asExpression(r), Expression.PRECEDENCE_OR, Expression.ASSOCIATIVITY_NONE);
  }

  @override
  void useExpression(Expression expression) {
    left.useExpression(expression);
    right.useExpression(expression);
  }
}