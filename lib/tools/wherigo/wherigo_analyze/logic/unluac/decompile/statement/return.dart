import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';

class Return extends Statement {
  List<Expression> values;

  Return() : values = [];

  Return.single(Expression value) : values = [value];

  Return.multiple(this.values);

  @override
  void print(Decompiler d, Output out) {
    out.print('do ');
    printTail(d, out);
    out.print(' end');
  }

  @override
  void printTail(Decompiler d, Output out) {
    out.print('return');
    if (values.isNotEmpty) {
      out.print(' ');
      Expression.printSequence(d, out, values, false, true);
    }
  }
}