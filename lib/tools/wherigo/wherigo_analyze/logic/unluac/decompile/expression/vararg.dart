import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';

class Vararg extends Expression {
  final int length;
  final bool multiple;

  Vararg(this.length, this.multiple) : super(Expression.PRECEDENCE_ATOMIC);

  @override
  int getConstantIndex() {
    return -1;
  }

  @override
  void print(Decompiler d, Output out) {
    out.print(multiple ? "..." : "(...)");
  }

  @override
  void printMultiple(Decompiler d, Output out) {
    out.print(multiple ? "..." : "(...)");
  }

  @override
  bool isMultiple() {
    return multiple;
  }
}