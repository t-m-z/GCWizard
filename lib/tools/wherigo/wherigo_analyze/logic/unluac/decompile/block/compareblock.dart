import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/operation.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/registerset.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';

class CompareBlock extends Block {
  int target;
  Branch branch;

  CompareBlock(LFunction function, int begin, int end, this.target, this.branch) 
      : super(function, begin, end);

  @override
  bool isContainer() {
    return false;
  }

  @override
  bool breakable() {
    return false;
  }

  @override
  void addStatement(Statement statement) {
    // Do nothing
  }

  @override
  bool isUnprotected() {
    return false;
  }

  @override
  int getLoopback() {
    throw StateError('Illegal state');
  }

  @override
  void print(Decompiler d, Output out) {
    out.print('-- unhandled compare assign');
  }

  @override
  Operation process(Decompiler d) {
    return Operation(end - 1, (Registers r, Block block) {
      return RegisterSet(end - 1, target, branch.asExpression(r)).process(r, block);
    });
  }
}