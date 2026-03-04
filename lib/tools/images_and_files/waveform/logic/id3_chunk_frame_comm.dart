part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

List<SoundfileDataSectionContent> _commFrame(Uint8List frameBytes,) {
  // <Header for 'Comment', ID: "COMM">
  // Text encoding          $xx
  // Language               $xx xx xx
  // Short content descrip. <text string according to encoding> $00 (00)
  // The actual text        <full text string according to encoding>

  List<SoundfileDataSectionContent> result = [];
  int index = 0;
  int encoding = frameBytes[0];
  String text = '';
  String BOM = '';
  List <int> content = [];

  String language = frameBytes.sublist(1, 4).join(' '); // Byte 1 2 3

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

  if (encoding == 1) { // UTF-16 with BOM
    while (!(frameBytes[index] == 0 && frameBytes[index + 1] == 0) ) {
      content.add(frameBytes[index]);
      content.add(frameBytes[index + 1]);
      index = index + 2;
    }
    content.add(frameBytes[index]);
    content.add(frameBytes[index + 1]);
    index = index + 2;
  } else if (encoding == 2){ // UTF-16BE without BOM
    while (!(frameBytes[index] == 0 && frameBytes[index + 1] == 0)) {
      content.add(frameBytes[index]);
      content.add(frameBytes[index + 1]);
      index = index + 2;
    }
    content.add(frameBytes[index]);
    content.add(frameBytes[index + 1]);
    index = index + 2;
  } else { //UTF-8, ISO-8859-1
    while (frameBytes[index] != 0) {
      content.add(frameBytes[index]);
      index++;
    }
  }

  text = _getEncodedString(encoding, Uint8List.fromList(content));
  result.add(SoundfileDataSectionContent(
      Meaning: 'shortcontent',
      Bytes: content.join(' '),
      Value: text));

  if (encoding == 1) {
    BOM = _getBOM(frameBytes.sublist(index, index + 2).join(' '));
    result.add(SoundfileDataSectionContent(
        Meaning: 'bom',
        Bytes: frameBytes.sublist(index, index + 2).join(' '),
        Value: BOM));
  }

  text = _getEncodedString(encoding, frameBytes.sublist(index, ));
  result.add(SoundfileDataSectionContent(
      Meaning: 'comment',
      Bytes: content.join(' '),
      Value: text));

  return result;
}