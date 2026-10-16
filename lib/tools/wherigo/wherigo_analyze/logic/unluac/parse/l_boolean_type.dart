part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LBooleanType extends _BObjectType<_LBoolean> {
  @override
  _LBoolean parse(_ByteReader buffer, _BHeader header) {
    final value = buffer.get();
    if ((value & 0xFFFFFFFE) != 0) {
      throw StateError('Invalid boolean constant value: $value');
    }
    return value == 0 ? _LBoolean.lfalse : _LBoolean.ltrue;
  }
}
