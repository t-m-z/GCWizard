part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _LConstantType extends _BObjectType<_LObject> {
  _LConstantType._();

  factory _LConstantType.type50() = _LConstantType50;
  factory _LConstantType.type53() = _LConstantType53;
}

class _LConstantType50 extends _LConstantType {
  _LConstantType50() : super._();

  @override
  _LObject parse(_ByteReader buffer, _BHeader header) {
    final type = buffer.get() & 0xFF;
    switch (type) {
      case 0:
        return _LNil.nil;
      case 1:
        return header.bool.parse(buffer, header);
      case 3:
        return header.number!.parse(buffer, header);
      case 4:
        return header.string.parse(buffer, header);
      default:
        throw StateError('Illegal constant type: $type');
    }
  }
}

class _LConstantType53 extends _LConstantType {
  _LConstantType53() : super._();

  @override
  _LObject parse(_ByteReader buffer, _BHeader header) {
    final type = buffer.get() & 0xFF;
    switch (type) {
      case 0:
        return _LNil.nil;
      case 1:
        return header.bool.parse(buffer, header);
      case 3:
        return header.lfloat!.parse(buffer, header);
      case 0x13:
        return header.linteger!.parse(buffer, header);
      case 4:
      case 0x14:
        return header.string.parse(buffer, header);
      default:
        throw StateError('Illegal constant type: $type');
    }
  }
}
