import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/globaltarget.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/assignment.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/operation.dart';

class GlobalSet extends Operation {
  String global;
  Expression value;

  GlobalSet(int line, this.global, this.value) : super(line);

  @override
  Statement process(Registers r, Block block) {
    return Assignment(GlobalTarget(global), value);
  }
}




