import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/target.dart';

class GlobalTarget extends Target {
  final String name;

  GlobalTarget(this.name);

  @override
  void print(Decompiler d, Output out) {
    out.print(name);
  }

  @override
  void printMethod(Decompiler d, Output out) {
    throw StateError('Illegal state');
  }
}
