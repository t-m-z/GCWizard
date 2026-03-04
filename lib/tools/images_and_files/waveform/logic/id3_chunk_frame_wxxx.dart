part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

List<SoundfileDataSectionContent> _wurlFrame(
    // <Header for 'URL link frames', ID: "W...">
    // URL          <text string>> ISO-8859-1
    Uint8List frameBytes,
    ) {
  int index = 0;
  int encoding = 0;
  String text = '';

  List<SoundfileDataSectionContent> result = [];

  encoding = 0;
  result.add(SoundfileDataSectionContent(
      Meaning: 'encoding', Bytes: encoding.toString(), Value: _getEncoding(encoding)));

  text = _getEncodedString(encoding, frameBytes.sublist(index));

  result.add(SoundfileDataSectionContent(
      Meaning: 'data',
      Bytes: frameBytes.sublist(index).join(' '),
      Value: text));

  return result;
}
