part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _NotBranch extends _Branch {
  final _Branch branch;

  _NotBranch(this.branch) : super(branch.line, branch.begin, branch.end);

  @override
  _Branch invert() => branch;

  @override
  int getRegister() => branch.getRegister();

  @override
  _Expression asExpression(_Registers r) {
    return _UnaryExpression(
        'not ', branch.asExpression(r), _Expression.precedenceUnary);
  }

  @override
  void useExpression(_Expression expression) {
    /* Do nothing */
  }
}
