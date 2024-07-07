import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/unaryexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class NotBranch extends Branch {
  final Branch branch;

  NotBranch(this.branch) : super(branch.line, branch.begin, branch.end);

  @override
  Branch invert() {
    return branch;
  }

  @override
  int getRegister() {
    return branch.getRegister();
  }

  @override
  Expression asExpression(Registers r) {
    return UnaryExpression("not ", branch.asExpression(r), Expression.PRECEDENCE_UNARY);
  }

  @override
  void useExpression(Expression expression) {
    // Do nothing
  }
}