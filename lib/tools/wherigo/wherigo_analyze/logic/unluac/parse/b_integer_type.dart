part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _BIntegerType extends _BObjectType<_BInteger> {
  final int intSize;

  _BIntegerType(this.intSize);

  _BInteger rawParse(_ByteReader buffer, _BHeader header) {
    switch (intSize) {
      case 0:
        return _BInteger(0);
      case 1:
        return _BInteger(buffer.get());
      case 2:
        return _BInteger(buffer.getShort());
      case 4:
        return _BInteger(buffer.getInt());
      case 8:
        return _BInteger(buffer.getLong());
      default:
        final bytes = Uint8List(intSize);
        int start = 0;
        int delta = 1;
        if (buffer.order == Endian.little) {
          start = intSize - 1;
          delta = -1;
        }
        for (var i = start; i >= 0 && i < intSize; i += delta) {
          bytes[i] = buffer.get() & 0xFF;
        }
        // Interpret as a big-endian two's complement value of `intSize` bytes.
        var value = BigInt.zero;
        for (final b in bytes) {
          value = (value << 8) | BigInt.from(b);
        }
        if (bytes.isNotEmpty && (bytes[0] & 0x80) != 0) {
          value -= BigInt.one << (intSize * 8);
        }
        return _BInteger.big(value);
    }
  }

  @override
  _BInteger parse(_ByteReader buffer, _BHeader header) {
    return rawParse(buffer, header);
  }
}
