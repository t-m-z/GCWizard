part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// Replacement for Java's java.nio.ByteBuffer, tailored to what BHeader and
/// friends need: a cursor, configurable endianness, primitive reads, and a
/// single mark/reset pair (used once, by the Lua 5.0 header sniffer).
class _ByteReader {
  final ByteData _data;
  final Uint8List _bytes;
  int _pos = 0;
  int _mark = 0;
  Endian order = Endian.big;

  _ByteReader(Uint8List bytes)
      : _bytes = bytes,
        _data = ByteData.sublistView(bytes);

  int get position => _pos;

  bool get hasRemaining => _pos < _bytes.length;

  /// Reads one signed byte, exactly like ByteBuffer.get().
  int get() {
    final v = _bytes[_pos];
    _pos += 1;
    return v > 127 ? v - 256 : v;
  }

  int getShort() {
    final v = _data.getInt16(_pos, order);
    _pos += 2;
    return v;
  }

  int getInt() {
    final v = _data.getInt32(_pos, order);
    _pos += 4;
    return v;
  }

  /// Reads a 4-byte word as an unsigned value in [0, 2^32). Lua instruction
  /// words are treated as unsigned bit patterns throughout this port.
  int getUint32() {
    final v = _data.getUint32(_pos, order);
    _pos += 4;
    return v;
  }

  int getLong() {
    final v = _data.getInt64(_pos, order);
    _pos += 8;
    return v;
  }

  double getFloat() {
    final v = _data.getFloat32(_pos, order);
    _pos += 4;
    return v;
  }

  double getDouble() {
    final v = _data.getFloat64(_pos, order);
    _pos += 8;
    return v;
  }

  void mark() {
    _mark = _pos;
  }

  void reset() {
    _pos = _mark;
  }
}
