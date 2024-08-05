import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/version.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/constant.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/constantexpression.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/globalexpression.dart';

class Function_ {
  List<Constant> constants;
  final int constantsOffset;

  Function_(LFunction function)
      : constants = List<Constant>.generate(
            function.constants.length, (i) => Constant(function.constants[i])),
        constantsOffset = function.header.version == Version.LUA50 ? 250 : 256;

  bool isConstant(int register) {
    return register >= constantsOffset;
  }

  int constantIndex(int register) {
    return register - constantsOffset;
  }

  String getGlobalName(int constantIndex) {
    return constants[constantIndex].asName();
  }

  ConstantExpression getConstantExpression(int constantIndex) {
    return ConstantExpression(constants[constantIndex], constantIndex);
  }

  GlobalExpression getGlobalExpression(int constantIndex) {
    return GlobalExpression(getGlobalName(constantIndex), constantIndex);
  }
}


