part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LocalVariable extends _Expression {
  final _Declaration decl;

  _LocalVariable(this.decl) : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex => -1;

  @override
  bool get isDotChain => true;

  @override
  void print(_Decompiler d, _Output out) {
    out.print(decl.name);
  }

  @override
  bool get isBrief => true;
}
