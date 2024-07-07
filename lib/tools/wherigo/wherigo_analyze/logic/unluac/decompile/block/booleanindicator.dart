import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';

class BooleanIndicator extends Block {
  BooleanIndicator(LFunction function, int line) : super(function, line, line);

  @override
  void addStatement(Statement statement) {
    // No implementation needed
  }

  @override
  bool isContainer() {
    return false;
  }

  @override
  bool isUnprotected() {
    return false;
  }

  @override
  bool breakable() {
    return false;
  }

  @override
  int getLoopback() {
    throw StateError('Illegal state');
  }

  @override
  void print(Decompiler d, Output out) {
    out.print('-- unhandled boolean indicator');
  }
}