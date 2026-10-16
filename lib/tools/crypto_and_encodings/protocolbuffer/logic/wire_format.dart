part of 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';

/// The wire types defined by the Protocol Buffers binary encoding.
///
/// See: https://protobuf.dev/programming-guides/encoding/#structure
enum _WireType {
  /// int32, int64, uint32, uint64, sint32, sint64, bool, enum
  varint(0),

  /// fixed64, sfixed64, double
  fixed64(1),

  /// string, bytes, embedded messages, packed repeated fields
  lengthDelimited(2),

  /// groups (deprecated, kept only so unknown fields can be skipped)
  startGroup(3),

  /// groups (deprecated, kept only so unknown fields can be skipped)
  endGroup(4),

  /// fixed32, sfixed32, float
  fixed32(5);

  const _WireType(this.value);

  /// The 3-bit value stored in the low bits of a field tag.
  final int value;

  static _WireType fromValue(int value) {
    switch (value) {
      case 0:
        return _WireType.varint;
      case 1:
        return _WireType.fixed64;
      case 2:
        return _WireType.lengthDelimited;
      case 3:
        return _WireType.startGroup;
      case 4:
        return _WireType.endGroup;
      case 5:
        return _WireType.fixed32;
      default:
        throw _ProtoDecodeException('Unknown wire type: $value');
    }
  }
}

/// A decoded field tag: the field number together with its wire type.
typedef _FieldTag = ({int fieldNumber, _WireType wireType});

/// Combines a field number and wire type into the varint-encoded tag that
/// precedes every field in the wire format.
int _makeTag(int fieldNumber, _WireType wireType) {
  if (fieldNumber <= 0) {
    throw ArgumentError.value(
      fieldNumber,
      'fieldNumber',
      'Field numbers must be positive',
    );
  }
  return (fieldNumber << 3) | wireType.value;
}

/// Splits a raw tag value back into its field number and wire type.
_FieldTag _decodeTag(int tag) {
  final wireType = _WireType.fromValue(tag & 0x7);
  final fieldNumber = tag >>> 3;
  return (fieldNumber: fieldNumber, wireType: wireType);
}

/// Thrown when a byte sequence cannot be interpreted as valid Protocol
/// Buffers wire format data.
class _ProtoDecodeException implements Exception {
  _ProtoDecodeException(this.message);

  final String message;

  @override
  String toString() => 'ProtoDecodeException: $message';
}