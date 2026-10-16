part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ConstantExpression extends _Expression {
  final _Constant constant;
  final int index;

  _ConstantExpression(this.constant, this.index)
      : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex => index;

  @override
  void print(_Decompiler d, _Output out) {
    constant.print(d, out, false);
  }

  @override
  void printBraced(_Decompiler d, _Output out) {
    constant.print(d, out, true);
  }

  @override
  bool get isConstant => true;

  @override
  bool get isUngrouped => true;

  @override
  bool get isNil => constant.isNil;

  @override
  bool get isBoolean => constant.isBoolean;

  @override
  bool get isInteger => constant.isInteger;

  @override
  int asInteger() => constant.asInteger();

  @override
  bool get isString => constant.isString;

  @override
  bool get isIdentifier => constant.isIdentifier;

  @override
  String asName() => constant.asName();

  @override
  bool get isBrief => !constant.isString || constant.asName().length <= 10;
}
