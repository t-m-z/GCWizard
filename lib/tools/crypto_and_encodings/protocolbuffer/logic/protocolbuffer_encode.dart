part of 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';


/// How [encodeProtocolBuffer] renders the encoded message's bytes as a
/// string, and which key that ends up under in its result map. Mirrors
/// [_ByteInputFormat] on the decode side.
enum _ByteOutputFormat {
  /// Lowercase hex, e.g. `"0a0568656c6c6f"`, returned under the `'hex'` key.
  hex,

  /// Standard (RFC 4648) base64, returned under the `'base64'` key.
  base64,
}

/// Encodes [messages] as a single Protocol Buffers message with one
/// `repeated string` field (field number [fieldNumber], `1` by default) --
/// one occurrence of the field per list entry, in order. This is the
/// counterpart to [decodeProtocolBuffer]/[describeProtocolBuffer] for
/// turning plain strings into wire bytes: a `repeated string` can't be
/// packed (only scalar numeric types can), so on the wire it's exactly
/// what you'd get from repeatedly calling `writer.writeString(fieldNumber,
/// message)` for each string, all sharing the same field number.
///
/// Returns a two-key report, so the encoding can be inspected immediately:
/// - `'hex'` (or `'base64'`, if [format] is [ByteOutputFormat.base64]):
///   the encoded message's bytes, ready to feed straight back into
///   [decodeProtocolBuffer]/[describeProtocolBuffer]/[decodeProtocolBufferFields].
/// - `'detail'`: `describeProtocolBuffer`'s rendering of that same message,
///   i.e. what decoding it back immediately shows.
///
/// ```dart
/// final encoded = encodeProtocolBuffer(['hello', 'world']);
/// print(encoded['hex']);
/// // 0a0568656c6c6f0a05776f726c64
/// print(encoded['detail']);
/// // field 1 (length-delimited, 5 bytes) = 68656c6c6f
/// //   as string: "hello"
/// // field 1 (length-delimited, 5 bytes) = 776f726c64
/// //   as string: "world"
/// ```
///
/// An empty [messages] list encodes to an empty (zero-field) message.
Map<String, String> _encodeProtocolBuffer(
    List<String> messages, {
      int fieldNumber = 1,
      _ByteOutputFormat format = _ByteOutputFormat.hex,
    }) {
  final writer = _ProtoWriter();
  for (final message in messages) {
    writer.writeString(fieldNumber, message);
  }
  final bytes = writer.toBytes();

  final String key;
  final String encoded;
  final _ByteInputFormat inputFormat;

  switch (format) {
    case _ByteOutputFormat.hex:
      key = 'hex';
      encoded = _bytesToHex(bytes);
      inputFormat = _ByteInputFormat.hex;
    case _ByteOutputFormat.base64:
      key = 'base64';
      encoded = base64Encode(bytes);
      inputFormat = _ByteInputFormat.base64;
  }

  // describeProtocolBuffer (like decodeProtocolBuffer) rejects an empty
  // hex/base64 string as ambiguous input, but an empty message here is a
  // legitimate result (an empty messages list), not an error -- its
  // description is trivially "no fields", i.e. the empty string.

  final detail =
  bytes.isEmpty ? '' : describeProtocolBuffer(encoded, format: inputFormat);

  return {key: encoded, 'detail': detail};

}

String _bytesToHex(Uint8List bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();