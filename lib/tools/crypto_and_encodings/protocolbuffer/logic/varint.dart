part of 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';


/// A decoded varint together with the number of bytes it occupied.
typedef _VarintResult = ({int value, int bytesRead});

/// The maximum number of bytes a 64-bit varint can occupy.
const int _maxVarintBytes = 10;

/// Appends the base-128 varint encoding of [value] to [out].
///
/// [value] is treated as the bit pattern of a 64-bit two's complement
/// integer, matching the behaviour of the reference protobuf
/// implementations for `int32`/`int64`/`uint32`/`uint64` (a negative
/// `int32`/`int64` therefore always encodes as 10 bytes).
void _writeVarint(BytesBuilder out, int value) {
  var v = value;
  while (true) {
    if ((v & ~0x7F) == 0) {
      out.addByte(v & 0x7F);
      return;
    }
    out.addByte((v & 0x7F) | 0x80);
    // Unsigned right shift: negative Dart ints are stored as 64-bit two's
    // complement on the platforms this library targets, so `>>>` correctly
    // pulls in zero bits from the top rather than sign-extending.
    v = v >>> 7;
  }
}

/// Encodes [value] as a standalone varint byte list. Prefer [_writeVarint]
/// when writing into a larger buffer.
List<int> _encodeVarint(int value) {
  final bytes = <int>[];
  var v = value;
  while (true) {
    if ((v & ~0x7F) == 0) {
      bytes.add(v & 0x7F);
      break;
    }
    bytes.add((v & 0x7F) | 0x80);
    v = v >>> 7;
  }
  return bytes;
}

/// Reads a varint from [data] starting at [offset], returning both the
/// decoded value (as a 64-bit two's complement bit pattern) and the number
/// of bytes consumed. Reading never goes past [end] (defaults to
/// `data.length`), which matters when [data] is a shared backing buffer for
/// several nested message views.
_VarintResult _readVarint(List<int> data, int offset, [int? end]) {
  final limit = end ?? data.length;
  var result = 0;
  var shift = 0;
  var pos = offset;
  while (true) {
    if (pos >= limit) {
      throw _ProtoDecodeException('Truncated varint at offset $offset');
    }
    if (shift >= 64) {
      throw _ProtoDecodeException('Varint at offset $offset is too long');
    }
    final byte = data[pos++];
    result |= (byte & 0x7F) << shift;
    if ((byte & 0x80) == 0) {
      return (value: result, bytesRead: pos - offset);
    }
    shift += 7;
  }
}

/// ZigZag-encodes a signed integer so that small-magnitude negative numbers
/// map to small unsigned varints, as used by `sint32`/`sint64` fields.
///
/// Works uniformly for values in the `int32` and `int64` range because Dart
/// integers are 64-bit two's complement: for `sint32` values the result
/// fits in 32 bits, for `sint64` values it uses the full 64 bits.
int _zigZagEncode(int n) => (n << 1) ^ (n >> 63);

/// Reverses [_zigZagEncode].
int _zigZagDecode(int n) => (n >>> 1) ^ -(n & 1);