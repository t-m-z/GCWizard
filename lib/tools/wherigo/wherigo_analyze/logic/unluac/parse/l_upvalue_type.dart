part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LUpvalueType extends _BObjectType<_LUpvalue> {
  @override
  _LUpvalue parse(_ByteReader buffer, _BHeader header) {
    final upvalue = _LUpvalue();
    upvalue.instack = buffer.get() != 0;
    upvalue.idx = buffer.get() & 0xFF;
    return upvalue;
  }
}
