part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

List<SoundfileDataSectionContent> _textFrame(
  // <Header for 'Text information frames', ID: "T...">
  // Text encoding          $xx
  // Information            $xx xx xx
  Uint8List frameBytes,
) {
  int index = 0;
  int encoding = 0;
  String text = '';
  String BOM = '';

  List<SoundfileDataSectionContent> result = [];

  encoding = frameBytes[0];
  result.add(SoundfileDataSectionContent(
      Meaning: 'encoding', Bytes: encoding.toString(), Value: _getEncoding(encoding)));

  index = 1;
  if (encoding == 1) {
    BOM = _getBOM(frameBytes.sublist(index, index + 2).join(' '));
    result.add(SoundfileDataSectionContent(
        Meaning: 'bom',
        Bytes: frameBytes.sublist(index, index + 2).join(' '),
        Value: BOM));
    index = 3;
  }

  text = _getEncodedString(encoding, frameBytes.sublist(index));

  result.add(SoundfileDataSectionContent(
      Meaning: 'data',
      Bytes: frameBytes.sublist(index).join(' '),
      Value: text));

  return result;
}
