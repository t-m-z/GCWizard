part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// Wraps a function's constant table and the register-encoded-constant
/// convention used by Lua 5.1+ bytecode (mirrors unluac's `Function` class;
/// renamed here to avoid colliding with dart:core's Function type).
class _ConstantPool {
  final List<_Constant> _constants;
  final int _constantsOffset;

  _ConstantPool(_LFunction function)
      : _constants =
            function.constants.map((c) => _Constant(c)).toList(growable: false),
        _constantsOffset = function.header.version == _Version.lua50 ? 250 : 256;

  bool isConstant(int register) => register >= _constantsOffset;

  int constantIndex(int register) => register - _constantsOffset;

  String getGlobalName(int constantIndex) => _constants[constantIndex].asName();

  _ConstantExpression getConstantExpression(int constantIndex) {
    return _ConstantExpression(_constants[constantIndex], constantIndex);
  }

  _GlobalExpression getGlobalExpression(int constantIndex) {
    return _GlobalExpression(getGlobalName(constantIndex), constantIndex);
  }
}
