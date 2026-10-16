part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _UpvalueExpression extends _Expression {
  final String name;

  _UpvalueExpression(this.name) : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex => -1;

  @override
  bool get isDotChain => true;

  @override
  void print(_Decompiler d, _Output out) {
    out.print(name);
  }

  @override
  bool get isBrief => true;

  @override
  bool isEnvironmentTable(_Decompiler d) =>
      d.getVersion().isEnvironmentTable(name);
}
