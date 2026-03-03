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

  List<SoundfileDataSectionContent> result = [];

  encoding = frameBytes[0];
  result.add(SoundfileDataSectionContent(
      Meaning: 'encoding', Bytes: encoding.toString(), Value: _getEncoding(encoding)));

  result.add(SoundfileDataSectionContent(
      Meaning: 'data', Bytes: frameBytes.sublist(1).join(' '), Value: _getEncodedString(encoding, frameBytes.sublist(1))));

  switch (encoding) {
    case 0: // ISO 8859-1
      text = _getEncodedString(encoding, frameBytes.sublist(1));
      result.add(SoundfileDataSectionContent(
          Meaning: 'data', Bytes: frameBytes.sublist(1).join(' '), Value: text));
      break;
    case 1: // UNICODE with BOM
      BOM = _getBOM(frameBytes.sublist(index + 1, index + 3).join(' '));
      result.add(SoundfileDataSectionContent(
          Meaning: 'BOM',
          Bytes: frameBytes.sublist(index + 1, index + 3).join(' '),
          Value: BOM));

        text = _getEncodedString(encoding, frameBytes.sublist(1));

        result.add(SoundfileDataSectionContent(
            Meaning: 'data',
            Bytes: frameBytes.sublist(1).join(' '),
            Value: text));
      break;
    case 2: // UNICODE BigEndian
      text = _getEncodedString(encoding, frameBytes.sublist(1));
      result.add(SoundfileDataSectionContent(
          Meaning: 'data', Bytes: frameBytes.sublist(1).join(' '), Value: text));
      break;
    case 3: // UTF-8
      text = _getEncodedString(encoding, frameBytes.sublist(1));
      result.add(SoundfileDataSectionContent(
          Meaning: 'data', Bytes: frameBytes.sublist(1).join(' '), Value: text));
      break;
  }
  return result;
}
