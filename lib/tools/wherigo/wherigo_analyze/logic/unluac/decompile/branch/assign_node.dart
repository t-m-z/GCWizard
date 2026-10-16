part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _AssignNode extends _Branch {
  _Expression? _expression;

  _AssignNode(super.line, super.begin, super.end);

  @override
  _Branch invert() => throw StateError('AssignNode cannot be inverted');

  @override
  int getRegister() => throw StateError('AssignNode has no register');

  @override
  _Expression asExpression(_Registers r) => _expression!;

  @override
  void useExpression(_Expression expression) {
    _expression = expression;
  }
}
