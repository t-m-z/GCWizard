part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// Parser/config for LNumber values (mirrors unluac's LNumberType).
class _LNumberType extends _BObjectType<_LNumber> {
  final int size;
  final bool integral;
  final _NumberMode mode;

  _LNumberType(this.size, this.integral, this.mode) {
    if (!(size == 4 || size == 8)) {
      throw StateError(
          'The input chunk has an unsupported Lua number size: $size');
    }
  }

  double convert(double number) {
    if (integral) {
      switch (size) {
        case 4:
          return number.truncate().toSigned(32).toDouble();
        case 8:
          return number.truncate().toSigned(64).toDouble();
      }
    } else {
      switch (size) {
        case 4:
          // Round-trip through 32-bit float precision.
          return _toFloat32(number);
        case 8:
          return number;
      }
    }
    throw StateError('The input chunk has an unsupported Lua number format');
  }

  @override
  _LNumber parse(_ByteReader buffer, _BHeader header) {
    _LNumber? value;
    if (integral) {
      switch (size) {
        case 4:
          value = _LIntNumber(buffer.getInt());
          break;
        case 8:
          value = _LLongNumber(buffer.getLong());
          break;
      }
    } else {
      switch (size) {
        case 4:
          value = _LFloatNumber(buffer.getFloat(), mode);
          break;
        case 8:
          value = _LDoubleNumber(buffer.getDouble(), mode);
          break;
      }
    }
    if (value == null) {
      throw StateError('The input chunk has an unsupported Lua number format');
    }
    return value;
  }
}

double _toFloat32(double value) {
  final bd = ByteData(4);
  bd.setFloat32(0, value);
  return bd.getFloat32(0);
}
