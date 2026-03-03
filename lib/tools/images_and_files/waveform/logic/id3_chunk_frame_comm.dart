part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

List<SoundfileDataSectionContent> _commFrame(Uint8List frameBytes,) {
  // <Header for 'Comment', ID: "COMM">
  // Text encoding          $xx
  // Language               $xx xx xx
  // Short content descrip. <text string according to encoding> $00 (00)
  // The actual text        <full text string according to encoding>

  List<SoundfileDataSectionContent> result = [];
  int index = 0;
  int size = frameBytes.length;
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

  switch (encoding) {
    case 0: break;
    case 1: break;
    case 2: break;
    case 3: break;
  }

  BOM = _getBOM(frameBytes.sublist(4, 6).join(' '));
  content = [];
  index = 6;
  while (frameBytes[index] != 255) {
    content.add(frameBytes[index]);
    index++;
  }
  if (BOM == 'big endian') {

  } else { // little endian
    final codeUnits = <int>[];
    for (var i = 0; i < content.length; i += 2) {
      codeUnits.add(content[i] + content[i + 1] * 256);
    }
    text = String.fromCharCodes(codeUnits);
    text = text.substring(0, text.length - 1);
    result.add(SoundfileDataSectionContent(
        Meaning: 'shortcontent',
        Bytes: content.join(' '),
        Value: text)
    );
  }
  BOM = _getBOM(frameBytes.sublist(index, index + 2).join(' '));
  content = [];
  index = index + 2;
  while (index < size) {
    content.add(frameBytes[index]);
    index++;
  }
  if (BOM == 'big endian') {

  } else { // little endian
    final codeUnits = <int>[];
    for (var i = 0; i < content.length; i += 2) {
      codeUnits.add(content[i] + content[i + 1] * 256);
    }
    text = String.fromCharCodes(codeUnits);
    codeUnits.last == 0 ? text = text.substring(0, text.length - 1) : text = text.substring(0, text.length);
    result.add(SoundfileDataSectionContent(
        Meaning: 'comment',
        Bytes: content.join(' '),
        Value: text)
    );
  }
  return result;
}