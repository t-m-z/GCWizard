import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';

class Operation {
  final int line;

  Operation(this.line);

  Statement? process(Registers r, Block block) {
    // TODO: implement process
    throw UnimplementedError();
  }
}


