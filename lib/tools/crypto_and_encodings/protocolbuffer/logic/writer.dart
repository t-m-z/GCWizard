part of 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';


/// Encodes a single Protocol Buffers message into the binary wire format.
///
/// A [ProtoWriter] is a thin, append-only builder: call one `writeXxx`
/// method per field, in any order, then read the result off with
/// [toBytes]. Field values equal to the proto3 default (0, "", empty
/// bytes/false) are *not* skipped automatically -- callers decide whether a
/// field should be emitted, mirroring how generated proto3 code only
/// serializes fields that differ from the default.
class _ProtoWriter {
  final BytesBuilder _out = BytesBuilder(copy: false);

  /// The number of bytes written so far.
  int get length => _out.length;

  // ---------------------------------------------------------------------
  // Varint-encoded fields (wire type 0)
  // ---------------------------------------------------------------------

  /// Writes an `int32` field. Negative values are encoded as 10-byte
  /// varints, matching the reference implementation.
  void writeInt32(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, value);

  /// Writes an `int64` field.
  void writeInt64(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, value);

  /// Writes a `uint32` field.
  void writeUint32(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, value.toUnsigned(32));

  /// Writes a `uint64` field. Values with the top bit set must be passed as
  /// the equivalent negative [int] bit pattern (Dart has no native unsigned
  /// 64-bit integer).
  void writeUint64(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, value);

  /// Writes an `sint32` field using ZigZag encoding.
  void writeSint32(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, _zigZagEncode(value));

  /// Writes an `sint64` field using ZigZag encoding.
  void writeSint64(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, _zigZagEncode(value));

  /// Writes a `bool` field.
  void writeBool(int fieldNumber, bool value) =>
      _writeVarintField(fieldNumber, value ? 1 : 0);

  /// Writes an `enum` field (the enum's integer value).
  void writeEnum(int fieldNumber, int value) =>
      _writeVarintField(fieldNumber, value);

  void _writeVarintField(int fieldNumber, int value) {
    writeTag(fieldNumber, _WireType.varint);
    _writeVarint(_out, value);
  }

  // ---------------------------------------------------------------------
  // Fixed-width fields (wire types 1 and 5)
  // ---------------------------------------------------------------------

  /// Writes a `fixed32` field (unsigned, little-endian, 4 bytes).
  void writeFixed32(int fieldNumber, int value) {
    writeTag(fieldNumber, _WireType.fixed32);
    final bd = ByteData(4)..setUint32(0, value, Endian.little);
    _out.add(bd.buffer.asUint8List());
  }

  /// Writes an `sfixed32` field (signed, little-endian, 4 bytes).
  void writeSfixed32(int fieldNumber, int value) {
    writeTag(fieldNumber, _WireType.fixed32);
    final bd = ByteData(4)..setInt32(0, value, Endian.little);
    _out.add(bd.buffer.asUint8List());
  }

  /// Writes a `float` field (IEEE-754 single precision, little-endian).
  void writeFloat(int fieldNumber, double value) {
    writeTag(fieldNumber, _WireType.fixed32);
    final bd = ByteData(4)..setFloat32(0, value, Endian.little);
    _out.add(bd.buffer.asUint8List());
  }

  /// Writes a `fixed64` field (unsigned, little-endian, 8 bytes). As with
  /// [writeUint64], values with the top bit set must be passed as the
  /// equivalent negative [int] bit pattern.
  ///
  /// Split into two 32-bit writes rather than `ByteData.setUint64`:
  /// dart2js does not implement that accessor at all (it throws
  /// `UnsupportedError` unconditionally, for every value, unlike the
  /// ordinary bitwise int ops used here) -- see the "64-bit integers on
  /// the web" note in the README for the resulting precision caveat above
  /// 2^53 under dart2js.
  void writeFixed64(int fieldNumber, int value) {
    writeTag(fieldNumber, _WireType.fixed64);
    _writeFixed64Bytes(value);
  }

  /// Writes an `sfixed64` field (signed, little-endian, 8 bytes). Same bit
  /// pattern as [writeFixed64] -- the sign is already encoded in bit 63.
  void writeSfixed64(int fieldNumber, int value) {
    writeTag(fieldNumber, _WireType.fixed64);
    _writeFixed64Bytes(value);
  }

  void _writeFixed64Bytes(int value) {
    final low = value & 0xFFFFFFFF;
    final high = (value >>> 32) & 0xFFFFFFFF;
    final bd = ByteData(8)
      ..setUint32(0, low, Endian.little)
      ..setUint32(4, high, Endian.little);
    _out.add(bd.buffer.asUint8List());
  }

  /// Writes a `double` field (IEEE-754 double precision, little-endian).
  void writeDouble(int fieldNumber, double value) {
    writeTag(fieldNumber, _WireType.fixed64);
    final bd = ByteData(8)..setFloat64(0, value, Endian.little);
    _out.add(bd.buffer.asUint8List());
  }

  // ---------------------------------------------------------------------
  // Length-delimited fields (wire type 2)
  // ---------------------------------------------------------------------

  /// Writes a `string` field (UTF-8 encoded).
  void writeString(int fieldNumber, String value) =>
      writeBytesField(fieldNumber, utf8.encode(value));

  /// Writes a `bytes` field.
  void writeBytesField(int fieldNumber, List<int> value) {
    writeTag(fieldNumber, _WireType.lengthDelimited);
    _writeVarint(_out, value.length);
    _out.add(value);
  }

  /// Writes an embedded message field, given the already-encoded bytes of
  /// the nested message (see [ProtoMessage.toBuffer]).
  void writeMessageField(int fieldNumber, List<int> encodedMessage) =>
      writeBytesField(fieldNumber, encodedMessage);

  /// Writes a packed repeated varint-typed field (e.g. `repeated int32`
  /// with the `packed` option, the proto3 default for scalar numerics).
  /// [values] are written through [convert] (identity by default), so this
  /// also covers packed `bool`/`enum`/`sint32`/`sint64` by passing an
  /// appropriate converter (e.g. `zigZagEncode` for `sint*`).
  void writePackedVarint(
      int fieldNumber,
      Iterable<int> values, {
        int Function(int value) convert = _identity,
      }) {
    final packed = BytesBuilder(copy: false);
    for (final v in values) {
      _writeVarint(packed, convert(v));
    }
    writeBytesField(fieldNumber, packed.toBytes());
  }

  /// Writes a packed repeated `fixed32`/`sfixed32`/`float` field.
  void writePackedFixed32(
      int fieldNumber,
      Iterable<num> values, {
        required void Function(ByteData bd, num value) put,
      }) {
    final list = values.toList(growable: false);
    final data = ByteData(4 * list.length);
    for (var i = 0; i < list.length; i++) {
      put(ByteData.sublistView(data, i * 4, i * 4 + 4), list[i]);
    }
    writeBytesField(fieldNumber, data.buffer.asUint8List());
  }

  /// Writes a packed repeated `fixed64`/`sfixed64`/`double` field.
  void writePackedFixed64(
      int fieldNumber,
      Iterable<num> values, {
        required void Function(ByteData bd, num value) put,
      }) {
    final data = ByteData(8 * values.length);
    var offset = 0;
    for (final v in values) {
      put(ByteData.sublistView(data, offset, offset + 8), v);
      offset += 8;
    }
    writeBytesField(fieldNumber, data.buffer.asUint8List());
  }

  // ---------------------------------------------------------------------
  // Low level
  // ---------------------------------------------------------------------

  /// Writes a raw field tag (field number + wire type). Exposed for callers
  /// that need to compose fields not covered by the `writeXxx` helpers
  /// above (e.g. deprecated groups).
  void writeTag(int fieldNumber, _WireType wireType) =>
      _writeVarint(_out, _makeTag(fieldNumber, wireType));

  /// Appends already-encoded bytes verbatim, e.g. to round-trip an unknown
  /// field captured while decoding.
  void writeRawBytes(List<int> bytes) => _out.add(bytes);

  /// Returns the encoded message bytes. The writer can keep being used
  /// afterwards; each call returns everything written so far.
  Uint8List toBytes() => _out.toBytes();

  static int _identity(int value) => value;
}