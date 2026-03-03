part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

List<SoundfileDataSectionContent> _textFrame(
  Uint8List frameBytes,
) {
  print('analyze textframe');
  print(frameBytes);
  int index = 0;
  int size = frameBytes.length;
  int encoding = frameBytes[0];
  String text = '';
  String BOM = '';
  List<int> content = [];

  List<SoundfileDataSectionContent> result = [];

  encoding = frameBytes[0];
  result.add(SoundfileDataSectionContent(
      Meaning: 'encoding', Bytes: encoding.toString(), Value: _getEncoding(encoding)));

  result.add(SoundfileDataSectionContent(
      Meaning: 'data', Bytes: frameBytes.sublist(1).join(' '), Value: _getEncodedString(encoding, frameBytes.sublist(1))));

  if (encoding == 0) { // ISO 8859-1
    text = String.fromCharCodes(frameBytes.sublist(1));
    result.add(SoundfileDataSectionContent(
        Meaning: 'data', Bytes: frameBytes.sublist(1).join(' '), Value: text));
  } else {
    BOM = _getBOM(frameBytes.sublist(index + 1, index + 3).join(' '));
    result.add(SoundfileDataSectionContent(
        Meaning: 'BOM',
        Bytes: frameBytes.sublist(index + 1, index + 3).join(' '),
        Value: BOM));
    text = '';

    size = size - 3;

    if (BOM == 'big endian') {
    } else {
      // little endian
      final codeUnits = <int>[];
      for (var i = 3; i < 3 + size; i += 2) {
        codeUnits.add(frameBytes[i] + frameBytes[i + 1] * 256);
      }
      text = String.fromCharCodes(codeUnits);
      text = text.substring(0, text.length - 1);

      result.add(SoundfileDataSectionContent(
          Meaning: 'data',
          Bytes: frameBytes.sublist(index + 3, index + 3 + size).join(' '),
          Value: text));
    }
    index = index + 3 + size;
  } // encoding = 1
  return result;
}
