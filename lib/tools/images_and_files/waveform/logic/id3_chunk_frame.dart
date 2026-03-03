part of 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';

String _getEncoding(int encoding) {
  switch (encoding) {
    case 0: return 'ISO 8859-1';
    case 1: return 'UTF-16 BOM';
    case 2: return 'UTF-16 Big Endian';
    case 3: return 'UTF-8';
    default: return 'unknown';
  }
}

String _getBOM(String bom) {
  if (bom == '255 255') {
    return 'big endian';
  } else {
    return 'little endian';
  }
}

String _getEncodedString(int encoding, List<int> content) {
  String text = '';
  return text;
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
List<SoundfileDataSectionContent> _getFrameData(
  String frame,
  Uint8List frameBytes,
) {
  switch (frame) {
    case 'TALB':
    case 'TBPM':
    case 'TCOM':
    case 'TCON':
    case 'TCOP':
    case 'TDAT':
    case 'TDRC':
    case 'TDLR':
    case 'TDLY':
    case 'TENC':
    case 'TEXT':
    case 'TFLT':
    case 'TIME':
    case 'TIT1':
    case 'TIT2':
    case 'TIT3':
    case 'TKEY':
    case 'TLAN':
    case 'TLEN':
    case 'TMED':
    case 'TOAL':
    case 'TOFN':
    case 'TOLY':
    case 'TOPE':
    case 'TORY':
    case 'TOWN':
    case 'TPE1':
    case 'TPE2':
    case 'TPE3':
    case 'TPE4':
    case 'TPOS':
    case 'TPUB':
    case 'TRCK':
    case 'TRDA':
    case 'TRSN':
    case 'TRSO':
    case 'TSIZ':
    case 'TSRC':
    case 'TSSE':
    case 'TSST':
    case 'TYER':
    case 'TXXX': return _textFrame(frameBytes);
    case 'COMM': return _commFrame(frameBytes);
    case 'APIC':
    case 'USER':
    case 'OWNE':
    case 'WCOM':
    case 'WCOP':
    case 'WOAF':
    case 'WOAR':
    case 'WOAS':
    case 'WORS':
    case 'WPAY':
    case 'WPUB':
    case 'WXXX':
    default:
      return [];
  }
}
