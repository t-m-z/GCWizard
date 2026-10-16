part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _GlobalExpression extends _Expression {
  final String name;
  final int index;

  _GlobalExpression(this.name, this.index) : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex => index;

  @override
  bool get isDotChain => true;

  @override
  void print(_Decompiler d, _Output out) {
    out.print(name);
  }

  @override
  bool get isBrief => true;
}
