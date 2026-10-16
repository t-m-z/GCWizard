part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LFunction extends _BObject {
  late _BHeader header;
  _LFunction? parent;
  List<int> code;
  List<_LLocal> locals;
  List<_LObject> constants;
  List<_LUpvalue> upvalues;
  List<_LFunction> functions;
  int maximumStackSize;
  int numUpvalues;
  int numParams;
  int vararg;
  bool stripped = false;

  _LFunction(
    this.code,
    this.locals,
    this.constants,
    this.upvalues,
    this.functions,
    this.maximumStackSize,
    this.numUpvalues,
    this.numParams,
    this.vararg,
  );
}
