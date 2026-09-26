part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Vararg extends _Expression {
  final int length;
  final bool multiple;

  _Vararg(this.length, this.multiple) : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex => -1;

  @override
  void print(_Decompiler d, _Output out) {
    out.print(multiple ? '...' : '(...)');
  }

  @override
  void printMultiple(_Decompiler d, _Output out) {
    out.print(multiple ? '...' : '(...)');
  }

  @override
  bool get isMultiple => multiple;
}
