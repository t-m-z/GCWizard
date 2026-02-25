import 'dart:typed_data';

import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

class ID3v4extendedHeader{
  final String header;
  final bool extHeaderB;
  final bool extHeaderC;
  final bool extHeaderD;

  ID3v4extendedHeader(this.header, this.extHeaderB, this.extHeaderC, this.extHeaderD);
}
enum ID3v3FLAGS { UNSYNCHRONISATION, EXTENDED_HEADER, EXPERIMENTAL_TAGS }

final Map<String, String> ID3_FRAMES = {
  'AENC': 'Audio encryption',
  'APIC': 'Attached picture',
  'COMM': 'Comments',
  'COMR': 'Commercial frame',
  'ENCR': 'Encryption method registration',
  'EQUA': 'Equalization',
  'ETCO': 'Event timing codes',
  'GEOB': 'General encapsulated object',
  'GRID': 'Group identificationtion',
  'IPLS': 'Involved people list',
  'LINK': 'Linked information',
  'MCDI': 'Music CD identifier',
  'MLLT': 'MPEG location lookup table',
  'OWNE': 'Ownership frame',
  'PRIV': 'Private frame',
  'PCNT': 'Play counter',
  'POPM': 'Popularimeter',
  'POSS': 'Position synchronisation frame',
  'RBUF': 'Recommended buffer size',
  'RVAD': 'Relative volume adjustment',
  'RVRB': 'Reverb',
  'SYLT': 'Synchronized lyric/text',
  'SYTC': 'Synchronized tempo codes',
  'TALB': 'Album/Movie/Show title',
  'TBPM': 'BPM (beats per minute)',
  'TCOM': 'Composer',
  'TCON': 'Content type',
  'TCOP': 'Copyright message',
  'TDAT': 'Date',
  'TDLY': 'Playlist delay',
  'TENC': 'Encoded by',
  'TEXT': 'Lyricist/Text writer',
  'TFLT': 'File type',
  'TIME': 'Time',
  'TIT1': 'Content group description',
  'TIT2': 'Title/songname/content ion',
  'TIT3': 'Subtitle/Description refinement',
  'TKEY': 'Initial key',
  'TLAN': 'Language(s)',
  'TLEN': 'Length',
  'TMED': 'Media type',
  'TOAL': 'Original album/movie/show title',
  'TOFN': 'Original filename',
  'TOLY': 'Original lyricist(s)/text',
  'TOPE': 'Original artist(s)/performer(s)',
  'TORY': 'Original release year',
  'TOWN': 'File owner/licensee',
  'TPE1': 'Lead performer(s)/Soloist(s)',
  'TPE2': 'Band/orchestra/accompaniment',
  'TPE3': 'Conductor/performer refinement',
  'TPE4': 'Interpreted, remixed, or otherwise modified by',
  'TPOS': 'Part of a set',
  'TPUB': 'Publisher',
  'TRCK': 'Track number/Position in set',
  'TRDA': 'Recording dates',
  'TRSN': 'Internet radio station name',
  'TRSO': 'Internet radio station owner',
  'TSIZ': 'Size',
  'TSRC': 'ISRC (international standard g code)',
  'TSSE': 'Software/Hardware and settings  encoding',
  'TYER': 'Year',
  'TXXX': 'User defined text information',
  'UFID': 'Unique file identifier',
  'USER': 'Terms of use',
  'USLT': 'Unsychronized lyric/text transcription',
  'WCOM': 'Commercial information',
  'WCOP': 'Copyright/Legal information',
  'WOAF': 'Official audio file webpage',
  'WOAR': 'Official artist/performer webpage',
  'WOAS': 'Official audio source webpage',
  'WORS': 'Official internet radio station',
  'WPAY': 'Payment',
  'WPUB': 'Publishers official webpage',
  'WXXX': 'User defined URL link frame',
};

final List<String> ID3_TEXT_FRAMES = [
  'TALB',
  'TBPM',
  'TCOM',
  'TCON',
  'TCOP',
  'TDAT',
  'TDLY',
  'TENC',
  'TEXT',
  'TFLT',
  'TIME',
  'TIT1',
  'TIT2',
  'TIT3',
  'TKEY',
  'TLAN',
  'TLEN',
  'TMED',
  'TOAL',
  'TOFN',
  'TOLY',
  'TOPE',
  'TORY',
  'TOWN',
  'TPE1',
  'TPE2',
  'TPE3',
  'TPE4',
  'TPOS',
  'TPUB',
  'TRCK',
  'TRDA',
  'TRSN',
  'TRSO',
  'TSIZ',
  'TSRC',
  'TSSE',
  'TYER',
  'TXXX',
];

int sizeID3(Uint8List bytes) {
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

ID3v4extendedHeader ID4HeaderFlags(Uint8List bytes) {
  List<String> flags = [];
  print('get header flags');
  print(bytes);
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
  return ID3v4extendedHeader(flags.join('\n'), b, c, d);
}

String ID3v4TagRestrictions(int tag){
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

String ID3v3HeaderFlags(Uint8List bytes) {
  List<String> flags = [];
  if (bytes[0] & 128 == 128) flags.add('Unsynchronisation is used');
  if (bytes[0] & 64 == 64) flags.add('Extended Header is used');
  if (bytes[0] & 32 == 32) flags.add('Experimental tags are used');
  return flags.join('\n');
}

bool checkID3v3ExtendedHeader(Uint8List bytes) {
  return (bytes[0] & 64 == 64);
}

String ID3FrameFlags(Uint8List bytes) {
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

List<SoundfileDataSectionContent> _analyzeFrameChunk(Uint8List bytes) {
  List<SoundfileDataSectionContent> result = [];
  int index = 0;

  try {
    print('analyze id3 chunk');
    print(bytes);
    while (index < bytes.length) {
      String frame = String.fromCharCodes(bytes.sublist(index, index + 4));
      String flags = '';

      result.add(SoundfileDataSectionContent(
        Meaning: 'frame',
        Bytes: bytes.sublist(index, index + 4).join(' '),
        Value: frame,
      ));
print(bytes.sublist(index, index + 4).join(' '));
print(frame);
      int size = ByteData.sublistView(bytes).getInt32(index + 4, Endian.big);
      result.add(SoundfileDataSectionContent(
        Meaning: 'size',
        Bytes: bytes.sublist(index + 4, index + 8).join(' '),
        Value: size.toString(),
      ));
print(bytes.sublist(index + 4, index + 8).join(' '));
print(size);
      flags = convertBase(bytes.sublist(index + 8, index + 9).join(), 10, 2).padLeft(8, '0') +
          ' ' +
          convertBase(bytes.sublist(index + 9, index + 10).join(), 10, 2).padLeft(8, '0');
      result.add(SoundfileDataSectionContent(
          Meaning: 'flags', Bytes: bytes.sublist(index + 8, index + 10).join(' '), Value: flags));

      if (frame.startsWith('T')) {
        // Txxx Frames
        int encoding = bytes[index + 10];
print(bytes[index + 10]); print(encoding);
        if (encoding == 0) {
          size = size - 1;
          print(size);
          result.add(SoundfileDataSectionContent(
              Meaning: 'encoding', Bytes: '0', Value: 'ISO 8859-1'));
print(bytes.sublist(index + 11, index + 11 + size));
print(String.fromCharCodes(bytes.sublist(index + 11, index + 11 + size)));
          result.add(SoundfileDataSectionContent(
              Meaning: 'data',
              Bytes: bytes.sublist(index + 11, index + 11 + size).join(' '),
              Value: String.fromCharCodes(bytes.sublist(index + 11, index + 11 + size))));

          index = index + 11 + size;
        } else {
          result.add(SoundfileDataSectionContent(
              Meaning: 'encoding', Bytes: '1', Value: 'UTF-16'));

          String BOM = _getBOM(bytes.sublist(index + 11, index + 13).join(' '));
          result.add(SoundfileDataSectionContent(
              Meaning: 'BOM', Bytes: bytes.sublist(index + 11, index + 13).join(' '), Value: BOM));
print(BOM);
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
      } // Txxx
    }
    return result;
  } catch (e) {
    print('error in getting id3 chunk');
    print(e);
    return result;
  }
}

List<SoundfileDataSectionContent> analyzeID3Chunk(Uint8List bytes) {
  List<SoundfileDataSectionContent> result = [];
  String flags = '';
  int version = 3;
  int size = 0;
print('analyze id3 chunk');
print(bytes);
  try {
    int index = 0;
    result.add(SoundfileDataSectionContent(
        Meaning: 'sign',
        Bytes: bytes.sublist(0, 3).join(' '),
        Value: String.fromCharCodes(bytes.sublist(0, 3)))); // 3 Byte ASCII
print(bytes.sublist(0, 3).join(' '));
    result.add(SoundfileDataSectionContent(
        Meaning: 'version',
        Bytes: bytes.sublist(3, 5).join(' '),
        Value: bytes[3].toString() + '.' + bytes[4].toString())); // 2 Byte
    version = bytes[3];
    print(bytes.sublist(3, 5).join(' '));
    flags = convertBase(bytes.sublist(5, 6).join(''), 10, 2).padLeft(8, '0');
    result.add(SoundfileDataSectionContent(
        Meaning: 'flags',
        Bytes: bytes.sublist(5, 6).join(' '),
        Value: flags)); // 1 Byte
    print(bytes.sublist(5, 6).join(' '));
    if (ID3v3HeaderFlags(bytes.sublist(5, 6)) != '') {
      result.add(SoundfileDataSectionContent(
          Meaning: '',
          Bytes: ID3v3HeaderFlags(bytes.sublist(5, 6)),
          Value: '')); // 1 Byte binary
    }
    print(bytes.sublist(6, 10).join(' '));
    size = sizeID3(bytes.sublist(6, 10));
    result.add(SoundfileDataSectionContent(
        Meaning: 'size',
        Bytes: bytes.sublist(6, 10).join(' '),
        Value: size.toString() +
            ' Byte')); // 4 Bytes, special Format

    if (version == 3) {
      if (checkID3v3ExtendedHeader(bytes.sublist(5, 6))) {
        // Extended header size   $xx xx xx xx
        // Extended Flags         $xx xx
        // Size of padding        $xx xx xx xx
        index = 20;
      } else {
        index = 10;
      }
    } else {
      if (checkID3v3ExtendedHeader(bytes.sublist(5, 6))) {
        index = 10;
        int extHeaderSize = sizeID3(bytes.sublist(index, index + 4));
        print('extHaderSize $extHeaderSize');
        result.add(SoundfileDataSectionContent(
          Meaning: 'extended header size',
          Bytes: bytes.sublist(index, index + 4).join(' '),
          Value: extHeaderSize.toString() + ' Byte'));

        index = index + 4;
        print(bytes.sublist(index, index + 1).join(' '));
        result.add(SoundfileDataSectionContent(
          Meaning: 'extended flags',
          Bytes: bytes.sublist(index, index + 1).join(' '),
          Value: convertBase(bytes[index].toString(), 10, 2)));

        index = index + 1;
        print(bytes.sublist(index, index + 1));
        var headerFlags = ID4HeaderFlags(bytes.sublist(index, index + 1));
        print(headerFlags.header);
        index = index + 1;
        result.add(SoundfileDataSectionContent(
          Meaning: '',
          Bytes: '',
          Value: headerFlags.header));
        if (headerFlags.extHeaderB) {
          index = index + 1;
        }
        if (headerFlags.extHeaderC) {
          print(bytes[index]);
          int crcByte = bytes[index];
          result.add(SoundfileDataSectionContent(
            Meaning: 'Number of CRC bytes',
            Bytes: bytes[index].toString(),
            Value: bytes.sublist(index + 1, index + 1 + crcByte).join(' ')));
          print(bytes.sublist(index + 1, index + 1 + crcByte).join(' '));
          index = index + 1 + crcByte;
        }
        if (headerFlags.extHeaderD) {
          index = index + 2;
          result.add(SoundfileDataSectionContent(
            Meaning: 'Tag restrictions',
            Bytes: bytes[index].toString(),
            Value: ID3v4TagRestrictions(bytes[index])));
          index = index + 1;
       }
        print('index $index');
      }
    }
    print(bytes.sublist(index));
    result.addAll(_analyzeFrameChunk(bytes.sublist(index)));

    return result;
  } catch (e) {
    print(e.toString());
    return result;
  }
}
