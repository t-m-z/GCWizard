part of 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';


/// How the input string passed to [decodeProtocolBuffer] encodes the raw
/// message bytes.
enum _ByteInputFormat {
  /// Try hex first, then fall back to base64. This is almost always the
  /// right choice: hex and base64 alphabets barely overlap in practice
  /// (base64 uses `+`, `/`, `=`, and mixed case beyond `a-f`/`A-F`).
  auto,

  /// A hex string, e.g. `"0a0568656c6c6f"`. Whitespace between/around bytes
  /// is tolerated and stripped; case-insensitive.
  hex,

  /// A standard (RFC 4648) base64 string.
  base64,
}

/// One decoded field from a Protocol Buffers message, read without any
/// `.proto` schema.
///
/// The wire format always tells you a field's number and wire type
/// unambiguously; it never tells you what the field *means* (its intended
/// name or scalar type). For `lengthDelimited` fields in particular, the
/// same bytes on the wire represent a `string`, `bytes`, an embedded
/// message, or a packed repeated scalar -- there's no way to tell which
/// without the schema. [text] and [message] carry best-effort guesses for
/// the first two cases; [value] always carries the raw decoded data.
class _DecodedField {
  _DecodedField({
    required this.fieldNumber,
    required this.wireType,
    required this.value,
    this.text,
    this.message,
  });

  /// The field number recovered from the tag.
  final int fieldNumber;

  /// The wire type recovered from the tag.
  final _WireType wireType;

  /// The raw decoded value:
  /// - `varint`: an [int] (the 64-bit two's complement bit pattern; this is
  ///   the right value whether the field is really an `int32`/`int64`,
  ///   `uint32`/`uint64`, `sint32`/`sint64` (still ZigZag-encoded here),
  ///   `bool`, or `enum` -- telling those apart needs the schema)
  /// - `fixed32`/`fixed64`: an [int] (the unsigned bit pattern; could
  ///   likewise be a `float`/`double` bit pattern, or `sfixed*`)
  /// - `lengthDelimited`: the raw [Uint8List] payload
  /// - `startGroup`: the `List<DecodedField>` of fields found inside the
  ///   (deprecated) group, same as [message]
  final Object value;

  /// Set when a `lengthDelimited` field's bytes are valid, printable UTF-8
  /// -- the shape of a `string` field.
  final String? text;

  /// Set when a `lengthDelimited` field's bytes, taken on their own, fully
  /// parse as a well-formed Protocol Buffers message (every byte consumed,
  /// no invalid tags) -- the shape of an embedded message field. This is a
  /// heuristic: some byte strings that are not actually submessages
  /// (arbitrary binary blobs, some `bytes`/packed-scalar fields) can still
  /// happen to parse this way, especially when short.
  final List<_DecodedField>? message;

  /// A multi-line, indented rendering of this field for humans inspecting
  /// an unknown payload -- includes the raw value plus any [text]/[message]
  /// guesses.
  String describe({int indent = 0}) {
    final pad = '  ' * indent;
    final buffer = StringBuffer();
    switch (wireType) {
      case _WireType.varint:
        buffer.writeln('${pad}field $fieldNumber (varint) = $value');
      case _WireType.fixed32:
        buffer.writeln('${pad}field $fieldNumber (fixed32) = $value');
      case _WireType.fixed64:
        buffer.writeln('${pad}field $fieldNumber (fixed64) = $value');
      case _WireType.lengthDelimited:
        final bytes = value as Uint8List;
        buffer.writeln(
          '${pad}field $fieldNumber (length-delimited, ${bytes.length} '
              'bytes) = ${_hex(bytes)}',
        );
        final text = this.text;
        if (text != null) {
          buffer.writeln('$pad  as string: ${jsonEncode(text)}');
        }
        final nested = message;
        if (nested != null && nested.isNotEmpty) {
          buffer.writeln('$pad  as nested message:');
          for (final field in nested) {
            buffer.write(field.describe(indent: indent + 2));
          }
        }
      case _WireType.startGroup:
        buffer.writeln('${pad}field $fieldNumber (group):');
        for (final field in message ?? const []) {
          buffer.write(field.describe(indent: indent + 1));
        }
      case _WireType.endGroup:
      // Never produced standalone by decodeProtocolBuffer.
        buffer.writeln('${pad}field $fieldNumber (end group)');
    }
    return buffer.toString();
  }

  @override
  String toString() => describe();
}

String _hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

/// Decodes [input] -- a string holding raw Protocol Buffers message bytes,
/// hex- or base64-encoded (see [format]) -- into its top-level fields,
/// without needing a `.proto` schema.
///
/// Every field's number and wire type is always recovered exactly; see
/// [_DecodedField] for what can (and can't) be inferred beyond that.
/// `lengthDelimited` fields are recursively decoded the same way for the
/// [_DecodedField.message] guess, so nested/repeated embedded messages come
/// back as a full tree.
///
/// This is the structured counterpart to [decodeProtocolBuffer], which
/// wraps the same decode into a two-key report ('json'/'detail') more
/// convenient for printing or handing to a caller that just wants text.
///
/// Throws [FormatException] if [input] isn't valid hex/base64, or
/// [ProtoDecodeException] if the decoded bytes aren't a well-formed
/// sequence of protobuf tag/value pairs.
List<_DecodedField> decodeProtocolBufferFields(
    String input, {
      _ByteInputFormat format = _ByteInputFormat.auto,
    }) {
  final bytes = _stringToBytes(input, format);
  return _decodeFields(_ProtoReader(bytes));
}

/// Convenience wrapper around [decodeProtocolBufferFields] that renders the
/// result as a human-readable, indented multi-line string (see
/// [_DecodedField.describe]) instead of a [_DecodedField] tree.
String describeProtocolBuffer(
    String input, {
      _ByteInputFormat format = _ByteInputFormat.auto,
    }) {
  final fields = decodeProtocolBufferFields(input, format: format);
  return fields.map((f) => f.describe()).join();
}

/// Decodes [input] -- a string holding raw Protocol Buffers message bytes,
/// hex- or base64-encoded (see [format]) -- generically, with no `.proto`
/// schema, and returns a two-key report:
///
/// - `'json'`: a compact `Message { fieldNumber: value, ... }` rendering
///   (nested messages recurse as `Message { ... }`, strings are quoted,
///   numbers are bare). This is a JSON-*like* pretty structure, not
///   parseable JSON -- field numbers, not names, are the only keys the
///   wire format gives us -- meant for a quick glance at the shape of the
///   data.
/// - `'detail'`: the same result as [describeProtocolBuffer]: one line per
///   field with its wire type, raw bytes, and the [_DecodedField.text]/
///   [_DecodedField.message] guesses spelled out.
///
/// For the example bytes used throughout this package's tests/README:
/// ```dart
/// final report = decodeProtocolBuffer(
///   '0a180a0a0a014e10251815209703120a0a0157107a180320c704'
///   '122248616e6765722c20757020686967682c206e6f7420696e2076656765'
///   '746174696f6e',
/// );
/// print(report['json']);
/// ```
/// prints:
/// ```
/// Message {
///   1: Message {
///     1: Message {
///       1: "N"
///       2: 37
///       3: 21
///       4: 407
///     }
///     2: Message {
///       1: "W"
///       2: 122
///       3: 3
///       4: 583
///     }
///   }
///   2: "Hanger, up high, not in vegetation"
/// }
/// ```
/// (Field numbers are all the wire format gives us -- there's no schema
/// here to say field 1 "means" a coordinate or that its sub-fields are a
/// hemisphere/degrees/minutes/tenths-of-a-second, so unlike a hand-written
/// `.proto`-derived comment, `decodeProtocolBuffer` can't label them; the
/// tree above is exactly what the bytes contain.)
///
/// Throws [FormatException] if [input] isn't valid hex/base64, or
/// [ProtoDecodeException] if the decoded bytes aren't a well-formed
/// sequence of protobuf tag/value pairs.
Map<String, String> _decodeProtocolBuffer(
    String input, {
      _ByteInputFormat format = _ByteInputFormat.auto,
    }) {
  final fields = decodeProtocolBufferFields(input, format: format);
  return {
    'json': _fieldsToPseudoJson(fields, 0),
    'detail': fields.map((f) => f.describe()).join(),
  };
}

String _fieldsToPseudoJson(List<_DecodedField> fields, int indent) {
  final outerPad = '  ' * indent;
  final innerPad = '  ' * (indent + 1);
  final buffer = StringBuffer('Message {\n');
  for (final field in fields) {
    buffer.writeln(
      '$innerPad${field.fieldNumber}: ${_pseudoJsonValue(field, indent + 1)}',
    );
  }
  buffer.write('$outerPad}');
  return buffer.toString();
}

String _pseudoJsonValue(_DecodedField field, int indent) {
  switch (field.wireType) {
    case _WireType.varint:
    case _WireType.fixed32:
    case _WireType.fixed64:
      return '${field.value}';
    case _WireType.lengthDelimited:
    // Prefer text over a nested-message guess when both match: for real
    // embedded messages, the bytes containing arbitrary binary (varints,
    // deeper nested content, ...) coincidentally also being valid,
    // printable UTF-8 is rare, whereas ordinary text coincidentally also
    // parsing as *some* short well-formed message is common enough (see
    // the "52° 13.456"-style example in the README) to otherwise hide
    // the correct, more useful reading.
      final text = field.text;
      if (text != null) {
        return jsonEncode(text);
      }
      final nested = field.message;
      if (nested != null) {
        return _fieldsToPseudoJson(nested, indent);
      }
      return '0x${_hex(field.value as Uint8List)}';
    case _WireType.startGroup:
      return _fieldsToPseudoJson(field.message ?? const [], indent);
    case _WireType.endGroup:
      return 'null'; // unreachable: never produced standalone
  }
}

List<_DecodedField> _decodeFields(_ProtoReader reader,
    {bool insideGroup = false}) {
  final fields = <_DecodedField>[];
  while (!reader.isAtEnd) {
    final tag = reader.readTag();
    if (tag.wireType == _WireType.endGroup) {
      if (insideGroup) return fields;
      throw _ProtoDecodeException('Unexpected standalone end-group marker');
    }
    switch (tag.wireType) {
      case _WireType.varint:
        fields.add(_DecodedField(
          fieldNumber: tag.fieldNumber,
          wireType: tag.wireType,
          value: reader.readInt64(),
        ));
      case _WireType.fixed32:
        fields.add(_DecodedField(
          fieldNumber: tag.fieldNumber,
          wireType: tag.wireType,
          value: reader.readFixed32(),
        ));
      case _WireType.fixed64:
        fields.add(_DecodedField(
          fieldNumber: tag.fieldNumber,
          wireType: tag.wireType,
          value: reader.readFixed64(),
        ));
      case _WireType.lengthDelimited:
        final data = reader.readBytesField();
        fields.add(_DecodedField(
          fieldNumber: tag.fieldNumber,
          wireType: tag.wireType,
          value: data,
          text: _tryDecodeText(data),
          message: _tryDecodeNested(data),
        ));
      case _WireType.startGroup:
      // Deprecated groups have no length prefix: their fields are inline
      // in the same byte stream, terminated by a matching end-group tag.
        final groupFields = _decodeFields(reader, insideGroup: true);
        fields.add(_DecodedField(
          fieldNumber: tag.fieldNumber,
          wireType: tag.wireType,
          value: groupFields,
          message: groupFields,
        ));
      case _WireType.endGroup:
        break; // unreachable: handled above before the switch
    }
  }
  if (insideGroup) {
    throw _ProtoDecodeException('Truncated group: missing end-group tag');
  }
  return fields;
}

List<_DecodedField>? _tryDecodeNested(Uint8List bytes) {
  // Unlike _tryDecodeText, empty bytes are deliberately not treated as a
  // (trivially valid, zero-field) nested message here -- reporting that
  // would be uninformative and indistinguishable from an empty string or
  // empty bytes field.
  if (bytes.isEmpty) return null;
  try {
    // _decodeFields only returns once the reader is fully consumed (or
    // throws), so success here already means every byte parsed cleanly.
    return _decodeFields(_ProtoReader(bytes));
  } on _ProtoDecodeException {
    return null;
  }
}

String? _tryDecodeText(Uint8List bytes) {
  // Note: empty bytes are NOT special-cased to null here -- an empty
  // `string` field is valid and real (e.g. writeString(field, '')), and
  // utf8.decode/the printable check both handle it correctly, yielding ''.
  String text;
  try {
    text = utf8.decode(bytes, allowMalformed: false);
  } on FormatException {
    return null;
  }
  // "Printable" here means "not a control character" rather than "pure
  // ASCII": real `string` fields routinely hold non-ASCII UTF-8 (accents,
  // "°", CJK, emoji, ...), and rejecting all of that would make this
  // heuristic useless for most real-world text. So this excludes only the
  // C0 controls (0x00-0x1F, except tab/LF/CR), DEL (0x7F), and the C1
  // controls (0x80-0x9F, which never legitimately appear in text and are
  // a common false-positive source when non-UTF-8 binary happens to
  // re-decode as Latin-1-range code points).
  final printable = text.runes.every(
        (r) =>
    r == 0x09 ||
        r == 0x0a ||
        r == 0x0d ||
        (r >= 0x20 && r != 0x7f && !(r >= 0x80 && r <= 0x9f)),
  );
  return printable ? text : null;
}

Uint8List _stringToBytes(String input, _ByteInputFormat format) {
  switch (format) {
    case _ByteInputFormat.hex:
      return _hexToBytes(input);
    case _ByteInputFormat.base64:
      return base64.decode(_stripWhitespace(input));
    case _ByteInputFormat.auto:
      if (_looksLikeHex(input)) {
        return _hexToBytes(input);
      }
      try {
        return base64.decode(_stripWhitespace(input));
      } on FormatException {
        throw FormatException(
          'Input is neither a valid hex string nor valid base64',
          input,
        );
      }
  }
}

String _stripWhitespace(String s) => s.replaceAll(RegExp(r'\s+'), '');

bool _looksLikeHex(String s) {
  final clean = _stripWhitespace(s);
  if (clean.isEmpty || clean.length.isOdd) return false;
  return RegExp(r'^[0-9a-fA-F]+$').hasMatch(clean);
}

Uint8List _hexToBytes(String s) {
  final clean = _stripWhitespace(s);
  if (clean.isEmpty || clean.length.isOdd) {
    throw FormatException(
      'Hex string must be non-empty with an even number of digits',
      s,
    );
  }
  final out = Uint8List(clean.length ~/ 2);
  for (var i = 0; i < out.length; i++) {
    final byteStr = clean.substring(i * 2, i * 2 + 2);
    final byte = int.tryParse(byteStr, radix: 16);
    if (byte == null) {
      throw FormatException('Invalid hex byte "$byteStr"', s, i * 2);
    }
    out[i] = byte;
  }
  return out;
}