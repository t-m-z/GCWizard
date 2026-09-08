part of 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';

/// Decodes a single Protocol Buffers message from the binary wire format.
///
/// Typical usage mirrors generated proto3 decoders: loop while [isAtEnd] is
/// false, read a tag with [readTag], `switch` on `tag.fieldNumber`, and call
/// the matching `readXxx` method for the field's declared type. Any field
/// number that isn't recognised should be passed to [skipField] so unknown
/// fields (e.g. from a newer schema version) don't break decoding -- the
/// same forward-compatibility guarantee the official implementations give.
class _ProtoReader {
  _ProtoReader(this._data) : _end = _data.length;

  /// Creates a reader over a slice of [data] (used for embedded messages).
  _ProtoReader.view(Uint8List data, int start, int end)
      : _data = data,
        _pos = start,
        _end = end;

  final Uint8List _data;
  int _pos = 0;
  final int _end;

  /// Whether every byte in this reader's range has been consumed.
  bool get isAtEnd => _pos >= _end;

  /// The number of bytes not yet consumed.
  int get remaining => _end - _pos;

  /// Reads the next field's tag (field number + wire type).
  _FieldTag readTag() {
    final tag = _readRawVarint();
    return _decodeTag(tag);
  }

  int _readRawVarint() {
    final result = _readVarint(_data, _pos, _end);
    _pos += result.bytesRead;
    return result.value;
  }

  // ---------------------------------------------------------------------
  // Varint-encoded fields
  // ---------------------------------------------------------------------

  /// Reads an `int32` field value.
  int readInt32() => _readRawVarint().toSigned(32);

  /// Reads an `int64` field value.
  int readInt64() => _readRawVarint();

  /// Reads a `uint32` field value.
  int readUint32() => _readRawVarint().toUnsigned(32);

  /// Reads a `uint64` field value. If the value's top bit is set, the
  /// result is the equivalent negative [int] bit pattern, since Dart has no
  /// native unsigned 64-bit integer.
  int readUint64() => _readRawVarint();

  /// Reads an `sint32` field value (ZigZag decoded).
  int readSint32() => _zigZagDecode(_readRawVarint()).toSigned(32);

  /// Reads an `sint64` field value (ZigZag decoded).
  int readSint64() => _zigZagDecode(_readRawVarint());

  /// Reads a `bool` field value.
  bool readBool() => _readRawVarint() != 0;

  /// Reads an `enum` field's raw integer value.
  int readEnum() => _readRawVarint().toSigned(32);

  // ---------------------------------------------------------------------
  // Fixed-width fields
  // ---------------------------------------------------------------------

  /// Reads a `fixed32` field value.
  int readFixed32() => _readByteData(4).getUint32(0, Endian.little);

  /// Reads an `sfixed32` field value.
  int readSfixed32() => _readByteData(4).getInt32(0, Endian.little);

  /// Reads a `float` field value.
  double readFloat() => _readByteData(4).getFloat32(0, Endian.little);

  /// Reads a `fixed64` field value. As with [readUint64], a value with the
  /// top bit set comes back as the equivalent negative [int] bit pattern.
  int readFixed64() => _readByteData(8).getUint64(0, Endian.little);

  /// Reads an `sfixed64` field value.
  int readSfixed64() => _readByteData(8).getInt64(0, Endian.little);

  /// Reads a `double` field value.
  double readDouble() => _readByteData(8).getFloat64(0, Endian.little);

  ByteData _readByteData(int byteCount) {
    _requireRemaining(byteCount);
    final bd = ByteData.sublistView(_data, _pos, _pos + byteCount);
    _pos += byteCount;
    return bd;
  }

  // ---------------------------------------------------------------------
  // Length-delimited fields
  // ---------------------------------------------------------------------

  /// Reads a `string` field value (UTF-8 decoded).
  String readString() => utf8.decode(readBytesField());

  /// Reads a `bytes` field value.
  Uint8List readBytesField() {
    final len = _readRawVarint();
    if (len < 0) {
      throw _ProtoDecodeException('Negative length-delimited size: $len');
    }
    _requireRemaining(len);
    final bytes = Uint8List.sublistView(_data, _pos, _pos + len);
    _pos += len;
    return bytes;
  }

  /// Reads an embedded message field as a nested [_ProtoReader], scoped to
  /// exactly that message's bytes.
  _ProtoReader readMessageField() {
    final len = _readRawVarint();
    if (len < 0) {
      throw _ProtoDecodeException('Negative length-delimited size: $len');
    }
    _requireRemaining(len);
    final nested = _ProtoReader.view(_data, _pos, _pos + len);
    _pos += len;
    return nested;
  }

  /// Reads a packed repeated varint-typed field, applying [convert]
  /// (identity by default) to each raw value -- pass `zigZagDecode` for
  /// packed `sint32`/`sint64` fields.
  List<int> readPackedVarint({int Function(int value) convert = _identity}) {
    final nested = readMessageField();
    final result = <int>[];
    while (!nested.isAtEnd) {
      result.add(convert(nested._readRawVarint()));
    }
    return result;
  }

  /// Reads a packed repeated `fixed32`/`sfixed32`/`float` field.
  List<T> readPackedFixed32<T>(T Function(ByteData bd) get) {
    final bytes = readBytesField();
    if (bytes.length % 4 != 0) {
      throw _ProtoDecodeException(
        'Packed fixed32 field length ${bytes.length} is not a multiple of 4',
      );
    }
    return [
      for (var i = 0; i < bytes.length; i += 4)
        get(ByteData.sublistView(bytes, i, i + 4)),
    ];
  }

  /// Reads a packed repeated `fixed64`/`sfixed64`/`double` field.
  List<T> readPackedFixed64<T>(T Function(ByteData bd) get) {
    final bytes = readBytesField();
    if (bytes.length % 8 != 0) {
      throw _ProtoDecodeException(
        'Packed fixed64 field length ${bytes.length} is not a multiple of 8',
      );
    }
    return [
      for (var i = 0; i < bytes.length; i += 8)
        get(ByteData.sublistView(bytes, i, i + 8)),
    ];
  }

  // ---------------------------------------------------------------------
  // Unknown fields
  // ---------------------------------------------------------------------

  /// Skips the value of a field with the given [wireType], for forward
  /// compatibility with unknown field numbers. Handles (deprecated) groups
  /// by skipping to the matching end-group marker.
  void skipField(_WireType wireType) {
    switch (wireType) {
      case _WireType.varint:
        _readRawVarint();
      case _WireType.fixed64:
        _requireRemaining(8);
        _pos += 8;
      case _WireType.lengthDelimited:
        readBytesField();
      case _WireType.fixed32:
        _requireRemaining(4);
        _pos += 4;
      case _WireType.startGroup:
        _skipGroup();
      case _WireType.endGroup:
        throw _ProtoDecodeException('Unexpected standalone end-group marker');
    }
  }

  void _skipGroup() {
    while (true) {
      if (isAtEnd) {
        throw _ProtoDecodeException('Truncated group: missing end-group tag');
      }
      final tag = readTag();
      if (tag.wireType == _WireType.endGroup) {
        return;
      }
      skipField(tag.wireType);
    }
  }

  void _requireRemaining(int byteCount) {
    if (_pos + byteCount > _end) {
      throw _ProtoDecodeException(
        'Truncated message: need $byteCount bytes, only $remaining remain',
      );
    }
  }

  static int _identity(int value) => value;
}