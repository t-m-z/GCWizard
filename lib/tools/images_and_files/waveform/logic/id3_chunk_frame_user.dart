part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

//      <Header for 'Terms of use frame', ID: "USER">
//      Text encoding        $xx
//      Language             $xx xx xx
//      The actual text      <text string according to encoding>

List<SoundfileDataSectionContent> _userFrame(
    Uint8List frameBytes,
    ) {
  int index = 0;
  int encoding = frameBytes[0];
  String text = '';
  String BOM = '';
  List <int> content = [];

  String language = frameBytes.sublist(1, 4).join(' '); // Byte 1 2 3

  List<SoundfileDataSectionContent> result = [];

  result.add(SoundfileDataSectionContent(
      Meaning: 'encoding',
      Bytes: encoding.toString(),
      Value: _getEncoding(encoding)));

  result.add(SoundfileDataSectionContent(
      Meaning: 'language',
      Bytes: language,
      Value: language));

  index = 4;
  if (encoding == 1) {
    BOM = _getBOM(frameBytes.sublist(index, index + 2).join(' '));
    result.add(SoundfileDataSectionContent(
        Meaning: 'bom',
        Bytes: frameBytes.sublist(index, index + 2).join(' '),
        Value: BOM));
  }

  text = _getEncodedString(encoding, frameBytes.sublist(index, ));
  result.add(SoundfileDataSectionContent(
      Meaning: 'value',
      Bytes: content.join(' '),
      Value: text));

  return result;
}
