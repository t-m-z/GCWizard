import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/target.dart';

class UpvalueTarget extends Target {
  final String name;

  UpvalueTarget(this.name);

  @override
  void print(Decompiler d, Output out) {
    out.print(name);
  }

  @override
  void printMethod(Decompiler d, Output out) {
    throw StateError('Illegal state');
  }
}
