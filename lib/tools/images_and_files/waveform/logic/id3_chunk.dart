import 'dart:typed_data';

import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk_data.dart';


int _sizeID3(Uint8List bytes) {
  // The ID3v2 tag size is encoded with four bytes where the most significant bit (bit 7) is set to zero in every byte,
  // making a total of 28 bits. The zeroed bits are ignored, so a 257 bytes long tag is represented as $00 00 02 01.
  String byte0 =
      convertBase(bytes[0].toString(), 10, 2).padLeft(8, '0').substring(1);
  String byte1 =
      convertBase(bytes[1].toString(), 10, 2).padLeft(8, '0').substring(1);
  String byte2 =
      convertBase(bytes[2].toString(), 10, 2).padLeft(8, '0').substring(1);
  String byte3 =
      convertBase(bytes[3].toString(), 10, 2).padLeft(8, '0').substring(1);
  return int.parse(convertBase(byte0 + byte1 + byte2 + byte3, 2, 10));
}

_ID3v4extendedHeader _ID3v4HeaderFlags(Uint8List bytes) {
  List<String> flags = [];
  bool b = false;
  bool c = false;
  bool d = false;
  if (bytes[0] & 64 == 64) {
    flags.add('Tag is an update');
    b = true;
  }
  if (bytes[0] & 32 == 32) {
    flags.add('CRC data present');
    c = true;
  }
  if (bytes[0] & 16 == 16) {
    flags.add('UTag restrictions');
    d = true;
  }
  return _ID3v4extendedHeader(flags.join('\n'), b, c, d);
}

String _ID3v4TagRestrictions(int tag){
  String result = 'Tag size restrictions\n';
  String binaryTag = convertBase(tag.toString(), 10, 2).padLeft(8, '0');
  switch (binaryTag.substring(0, 2))  {
    case '00' : result = result + ' - No more than 128 frames and 1 MB total tag size\n'; break;
    case '01' : result = result + ' - No more than 64 frames and 128 KB total tag size\n'; break;
    case '10' : result = result + ' - No more than 32 frames and 40 KB total tag size\n'; break;
    case '11' : result = result + ' - No more than 32 frames and 4 KB total tag size\n'; break;
  }
  result = result + 'Text encoding restrictions\n';
  switch (binaryTag.substring(0, 2))  {
    case '0' : result = result + ' - No restrictions\n'; break;
    case '1' : result = result + ' - Strings are encoded with ISO-8859-1 or UTF-8\n'; break;
  }
  result = result + 'Text field size restrictions\n';
  switch (binaryTag.substring(0, 2))  {
    case '00' : result = result + ' - No restrictions\n'; break;
    case '01' : result = result + ' - No string is longer than 1024 characters\n'; break;
    case '10' : result = result + ' - NNo string is longer than 128 characters\n'; break;
    case '11' : result = result + ' - No string is longer than 30 characters\n'; break;
  }
  result = result + 'Image encoding restrictions\n';
  switch (binaryTag.substring(0, 2))  {
    case '0' : result = result + ' - No restrictions\n'; break;
    case '1' : result = result + ' - Images are encoded only with PNG [PNG] or JPEG [JFIF]\n'; break;
  }
  result = result + 'Image size restrictions\n';
  switch (binaryTag.substring(0, 2))  {
    case '00' : result = result + ' - No restrictions\n'; break;
    case '01' : result = result + ' - All images are 256x256 pixels or smaller\n'; break;
    case '10' : result = result + ' - All images are 64x64 pixels or smaller\n'; break;
    case '11' : result = result + ' - All images are exactly 64x64 pixels, unless required otherwise\n'; break;
  }
  return result;
}

String _ID3v3HeaderFlags(Uint8List bytes) {
  List<String> flags = [];
  if (bytes[0] & 128 == 128) flags.add('Unsynchronisation is used');
  if (bytes[0] & 64 == 64) flags.add('Extended Header is used');
  if (bytes[0] & 32 == 32) flags.add('Experimental tags are used');
  return flags.join('\n');
}

bool _checkID3ExtendedHeader(Uint8List bytes) {
  return (bytes[0] & 64 == 64);
}

String _ID3FrameFlags(Uint8List bytes) {
  List<String> flags = [];
  if (bytes[0] & 128 == 128) {
    flags.add('Unknown frame: Frame should be discarded');
  }
  if (bytes[0] & 64 == 64) flags.add('Frame should be discarded');
  if (bytes[0] & 32 == 128) flags.add('Frame is read only');
  if (bytes[1] & 128 == 128) flags.add('Frame is compressed');
  if (bytes[1] & 64 == 64) flags.add('Frame is encrypted');
  if (bytes[1] & 32 == 128) flags.add('Frame contains group information');
  return flags.join('\n');
}

String _getBOM(String bom) {
  if (bom == '255 255') {
    return 'big endian';
  } else {
    return 'little endian';
  }
}

SoundfileDataSectionContentAnalyze _analyzeID3ChunkFrames(Uint8List bytes) {
  List<SoundfileDataSectionContent> result = [];
  int index = 0;
  int encoding = 0;
  String text = '';
  String BOM = '';
  String frame = '';
  String flags = '';
  List <int> content = [];

  try {
    while (index < bytes.length) {
      //  Frame ID   $xx xx xx xx  (four characters)
      //  Size       $xx xx xx xx
      //  Flags      $xx xx
      frame = String.fromCharCodes(bytes.sublist(index, index + 4));

      result.add(SoundfileDataSectionContent(
        Meaning: 'frame',
        Bytes: bytes.sublist(index, index + 4).join(' '),
        Value: frame,
      ));

      int size = ByteData.sublistView(bytes).getInt32(index + 4, Endian.big);
      result.add(SoundfileDataSectionContent(
        Meaning: 'size',
        Bytes: bytes.sublist(index + 4, index + 8).join(' '),
        Value: size.toString(),
      ));

      flags = convertBase(bytes.sublist(index + 8, index + 9).join(), 10, 2).padLeft(8, '0') +
          ' ' +
          convertBase(bytes.sublist(index + 9, index + 10).join(), 10, 2).padLeft(8, '0');
      result.add(SoundfileDataSectionContent(
          Meaning: 'flags', Bytes: bytes.sublist(index + 8, index + 10).join(' '), Value: flags));

      if (frame.startsWith('T')) {
        // Txxx Frames
        encoding = bytes[index + 10];
        if (encoding == 0) {
          size = size - 1;
          result.add(SoundfileDataSectionContent(
              Meaning: 'encoding', Bytes: '0', Value: 'ISO 8859-1'));
          if (bytes[index + 11 + size - 1] == 0) {
            size--;
          }
          result.add(SoundfileDataSectionContent(
              Meaning: 'data',
              Bytes: bytes.sublist(index + 11, index + 11 + size).join(' '),
              Value: String.fromCharCodes(bytes.sublist(index + 11, index + 11 + size))));

          index = index + 11 + size;
          if (bytes[index] == 0) {
            index++;
          }
        } else {
          result.add(SoundfileDataSectionContent(
              Meaning: 'encoding', Bytes: '1', Value: 'UTF-16'));

          String BOM = _getBOM(bytes.sublist(index + 11, index + 13).join(' '));
          result.add(SoundfileDataSectionContent(
              Meaning: 'BOM', Bytes: bytes.sublist(index + 11, index + 13).join(' '), Value: BOM));
          String text = '';

          size = size - 3;

          if (BOM == 'big endian') {

          } else { // little endian
            final codeUnits = <int>[];
            for (var i = 13; i < 13 + size; i += 2) {
              codeUnits.add(bytes[i] + bytes[i + 1] * 256);
            }
            text = String.fromCharCodes(codeUnits);
            text = text.substring(0, text.length - 1);

            result.add(SoundfileDataSectionContent(
                Meaning: 'data',
                Bytes: bytes.sublist(index + 13, index + 13 + size).join(' '),
                Value: text)
            );
          }
          index = index + 13 + size;
        } // encoding = 1
      } else if (frame == 'COMM') {
        // <Header for 'Comment', ID: "COMM">
        // Text encoding          $xx
        // Language               $xx xx xx
        // Short content descrip. <text string according to encoding> $00 (00)
        // The actual text        <full text string according to encoding>
        encoding = bytes[10];
        String language = bytes.sublist(11, 14).join(' '); // Byte 11 12 13
        result.add(SoundfileDataSectionContent(
            Meaning: 'language',
            Bytes: language,
            Value: language));
        BOM = _getBOM(bytes.sublist(14, 16).join(' '));
        content = [];
        index = 16;
        while (bytes[index] != 255) {
          content.add(bytes[index]);
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
        BOM = _getBOM(bytes.sublist(index, index + 2).join(' '));
        content = [];
        index = index + 2;
        while (index < size + 10) {
          content.add(bytes[index]);
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
      }// COMM
    }
    return SoundfileDataSectionContentAnalyze(
        output: result,
        status: SoundfileStatus.OK,
        error: ''
    );
  } catch (e) {
    return SoundfileDataSectionContentAnalyze(
        output: result,
        status: SoundfileStatus.ERROR,
        error: 'waveform_error_unsupported_structure'
    );
  }
}

SoundfileDataSectionContentAnalyze analyzeID3Chunk(Uint8List bytes) {
  List<SoundfileDataSectionContent> result = [];
  String flags = '';
  int version = 3;
  int size = 0;
  int index = 0;

  try {

    result.add(SoundfileDataSectionContent(
        Meaning: 'sign',
        Bytes: bytes.sublist(0, 3).join(' '),
        Value: String.fromCharCodes(bytes.sublist(0, 3)))); // 3 Byte ASCII

    result.add(SoundfileDataSectionContent(
        Meaning: 'version',
        Bytes: bytes.sublist(3, 5).join(' '),
        Value: bytes[3].toString() + '.' + bytes[4].toString())); // 2 Byte

    version = bytes[3];
    flags = convertBase(bytes.sublist(5, 6).join(''), 10, 2).padLeft(8, '0');
        result.add(SoundfileDataSectionContent(
        Meaning: 'flags',
        Bytes: bytes.sublist(5, 6).join(' '),
        Value: flags)); // 1 Byte

    if (_ID3v3HeaderFlags(bytes.sublist(5, 6)) != '') {
      result.add(SoundfileDataSectionContent(
          Meaning: '',
          Bytes: _ID3v3HeaderFlags(bytes.sublist(5, 6)),
          Value: '')); // 1 Byte binary
    }

    size = _sizeID3(bytes.sublist(6, 10));
    result.add(SoundfileDataSectionContent(
        Meaning: 'size',
        Bytes: bytes.sublist(6, 10).join(' '),
        Value: size.toString() +
            ' Byte')); // 4 Bytes, special Format

    index = 10;

    if (_checkID3ExtendedHeader(bytes.sublist(5, 6))) {
      // Extended header size   $xx xx xx xx
      int extHeaderSize = _sizeID3(bytes.sublist(index, index + 4));
      result.add(SoundfileDataSectionContent(
          Meaning: 'extendedheadersize',
          Bytes: bytes.sublist(index, index + 4).join(' '),
          Value: extHeaderSize.toString() + ' Byte'));

      index = index + 4;

      if (version == 3) {
        // Extended Flags         $xx xx
        // Size of padding        $xx xx xx xx
        result.add(SoundfileDataSectionContent(
            Meaning: 'extendedflags',
            Bytes: bytes.sublist(index, index + 2).join(' '),
            Value: convertBase(bytes[index].toString(), 10, 2)));

        var headerFlags = _ID3v3HeaderFlags(bytes.sublist(index, index + 2));
        result.add(SoundfileDataSectionContent(
            Meaning: '',
            Bytes: '',
            Value: headerFlags));
        index = index + 2;

        result.add(SoundfileDataSectionContent(
            Meaning: 'padding',
            Bytes: bytes.sublist(index, index + 4).join(' '),
            Value: ByteData.sublistView(bytes)
                .getInt32(index + 4, Endian.little).toString()));
        index = index + 4;

        if (headerFlags.startsWith('1')) {
          result.add(SoundfileDataSectionContent(
              Meaning: 'numberofcrcbytes',
              Bytes: bytes.sublist(index, index + 4).join(' '),
              Value: ''));
          index = index + 4;
        }

      } else { // version == 4
        // Number of flag bytes       $01
        // Extended Flags             $xx
        result.add(SoundfileDataSectionContent(
            Meaning: 'extendedflags',
            Bytes: bytes.sublist(index, index + 1).join(' '),
            Value: convertBase(bytes[index].toString(), 10, 2)));

        index = index + 1;
        var headerFlags = _ID3v4HeaderFlags(bytes.sublist(index, index + 1));
        index = index + 1;
        result.add(SoundfileDataSectionContent(
            Meaning: '',
            Bytes: '',
            Value: headerFlags.header));

        if (headerFlags.extHeaderB) {
          index = index + 1;
        }

        if (headerFlags.extHeaderC) {
          int crcByte = bytes[index];
          result.add(SoundfileDataSectionContent(
              Meaning: 'numberofcrcbytes',
              Bytes: bytes[index].toString(),
              Value: bytes.sublist(index + 1, index + 1 + crcByte).join(' ')));
          index = index + 1 + crcByte;
        }

        if (headerFlags.extHeaderD) {
          index = index + 2;
          result.add(SoundfileDataSectionContent(
              Meaning: 'tagrestrictions',
              Bytes: bytes[index].toString(),
              Value: _ID3v4TagRestrictions(bytes[index])));
          index = index + 1;
        }

      }
    }

    SoundfileDataSectionContentAnalyze data = _analyzeID3ChunkFrames(bytes.sublist(index));
    result.addAll(data.output);

    return SoundfileDataSectionContentAnalyze(
      output: result,
      status: SoundfileStatus.OK,
      error: '',
    );
  } catch (e) {
    return SoundfileDataSectionContentAnalyze(
      output: result,
      status: SoundfileStatus.ERROR,
      error: 'waveform_error_unsupported_structure',
    );
  }
}
