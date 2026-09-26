part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Version {
  static final _Version lua50 = _Version50();
  static final _Version lua51 = _Version51();
  static final _Version lua52 = _Version52();
  static final _Version lua53 = _Version53();

  final int versionNumber;

  const _Version(this.versionNumber);

  _LHeaderType getLHeaderType();

  _OpcodeMap getOpcodeMap() => _OpcodeMap(versionNumber);

  int getOuterBlockScopeAdjustment();

  bool usesOldLoadNilEncoding();

  bool usesInlineUpvalueDeclarations();

  _Op? getTForTarget();

  _Op? getForTarget();

  bool isBreakableLoopEnd(_Op? op);

  bool isAllowedPreceedingSemicolon();

  bool isEnvironmentTable(String? name);
}

class _Version50 extends _Version {
  _Version50() : super(0x50);

  @override
  _LHeaderType getLHeaderType() => _LHeaderType.type50;

  @override
  int getOuterBlockScopeAdjustment() => -1;

  @override
  bool usesOldLoadNilEncoding() => true;

  @override
  bool usesInlineUpvalueDeclarations() => true;

  @override
  _Op? getTForTarget() => _Op.tforloop;

  @override
  _Op? getForTarget() => _Op.forloop;

  @override
  bool isBreakableLoopEnd(_Op? op) => op == _Op.jmp || op == _Op.forloop;

  @override
  bool isAllowedPreceedingSemicolon() => false;

  @override
  bool isEnvironmentTable(String? upvalue) => false;
}

class _Version51 extends _Version {
  _Version51() : super(0x51);

  @override
  _LHeaderType getLHeaderType() => _LHeaderType.type51;

  @override
  int getOuterBlockScopeAdjustment() => -1;

  @override
  bool usesOldLoadNilEncoding() => true;

  @override
  bool usesInlineUpvalueDeclarations() => true;

  @override
  _Op? getTForTarget() => _Op.tforloop;

  @override
  _Op? getForTarget() => null;

  @override
  bool isBreakableLoopEnd(_Op? op) => op == _Op.jmp || op == _Op.forloop;

  @override
  bool isAllowedPreceedingSemicolon() => false;

  @override
  bool isEnvironmentTable(String? upvalue) => false;
}

class _Version52 extends _Version {
  _Version52() : super(0x52);

  @override
  _LHeaderType getLHeaderType() => _LHeaderType.type52;

  @override
  int getOuterBlockScopeAdjustment() => 0;

  @override
  bool usesOldLoadNilEncoding() => false;

  @override
  bool usesInlineUpvalueDeclarations() => false;

  @override
  _Op? getTForTarget() => _Op.tforcall;

  @override
  _Op? getForTarget() => null;

  @override
  bool isBreakableLoopEnd(_Op? op) =>
      op == _Op.jmp || op == _Op.forloop || op == _Op.tforloop;

  @override
  bool isAllowedPreceedingSemicolon() => true;

  @override
  bool isEnvironmentTable(String? name) => name == '_ENV';
}

class _Version53 extends _Version {
  _Version53() : super(0x53);

  @override
  _LHeaderType getLHeaderType() => _LHeaderType.type53;

  @override
  int getOuterBlockScopeAdjustment() => 0;

  @override
  bool usesOldLoadNilEncoding() => false;

  @override
  bool usesInlineUpvalueDeclarations() => false;

  @override
  _Op? getTForTarget() => _Op.tforcall;

  @override
  _Op? getForTarget() => null;

  @override
  bool isBreakableLoopEnd(_Op? op) =>
      op == _Op.jmp || op == _Op.forloop || op == _Op.tforloop;

  @override
  bool isAllowedPreceedingSemicolon() => true;

  @override
  bool isEnvironmentTable(String? name) => name == '_ENV';
}
