import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';

class AssignNode extends Branch {
  Expression? expression;

  AssignNode(int line, int begin, int end) : super(line, begin, end);

  @override
  Branch invert() {
    throw StateError('Illegal state');
  }

  @override
  int getRegister() {
    throw StateError('Illegal state');
  }

  @override
  Expression asExpression(Registers r) {
    return expression!;
  }

  @override
  void useExpression(Expression expression) {
    this.expression = expression;
  }
}