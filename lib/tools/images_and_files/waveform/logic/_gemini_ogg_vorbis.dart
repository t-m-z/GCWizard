import 'dart:typed_data';
import 'dart:convert';

class OggPage {
  final int version;
  final int headerType;
  final int granulePosition;
  final int bitstreamSerial;
  final int pageSequence;
  final int checksum;
  final List<int> segments;
  final Uint8List payload;

  OggPage({
    required this.version,
    required this.headerType,
    required this.granulePosition,
    required this.bitstreamSerial,
    required this.pageSequence,
    required this.checksum,
    required this.segments,
    required this.payload,
  });
}

class OggContainer {
  final List<OggPage> pages;
  final VorbisIdentificationHeader? identification;
  final VorbisCommentHeader? comments;

  OggContainer({
    required this.pages,
    required this.identification,
    required this.comments,
  });
}

class OggParser {
  static OggContainer parse(Uint8List bytes) {
    final pages = <OggPage>[];
    int pos = 0;

    VorbisIdentificationHeader? ident;
    VorbisCommentHeader? comments;

    while (pos + 27 < bytes.length) {
      // Magic
      if (bytes[pos] != 0x4F || bytes[pos + 1] != 0x67 || bytes[pos + 2] != 0x67 || bytes[pos + 3] != 0x53) {
        break;
      }

      final version = bytes[pos + 4];
      final headerType = bytes[pos + 5];
      final granule = _u64(bytes, pos + 6);
      final serial = _u32(bytes, pos + 14);
      final seq = _u32(bytes, pos + 18);
      final checksum = _u32(bytes, pos + 22);
      final segCount = bytes[pos + 26];

      final segments = bytes.sublist(pos + 27, pos + 27 + segCount);
      final payloadSize = segments.fold<int>(0, (a, b) => a + b);

      final payloadStart = pos + 27 + segCount;
      final payloadEnd = payloadStart + payloadSize;

      if (payloadEnd > bytes.length) break;

      final payload = bytes.sublist(payloadStart, payloadEnd);

      final page = OggPage(
        version: version,
        headerType: headerType,
        granulePosition: granule,
        bitstreamSerial: serial,
        pageSequence: seq,
        checksum: checksum,
        segments: segments,
        payload: payload,
      );

      pages.add(page);

      // Vorbis header detection
      if (payload.length > 7 && payload[0] == 1 && _isVorbis(payload)) {
        ident = VorbisParser.parseIdentification(payload);
      }
      if (payload.length > 7 && payload[0] == 3 && _isVorbis(payload)) {
        comments = VorbisParser.parseComments(payload);
      }

      pos = payloadEnd;
    }

    return OggContainer(
      pages: pages,
      identification: ident,
      comments: comments,
    );
  }

  static bool _isVorbis(Uint8List p) =>
      p[1] == 0x76 && p[2] == 0x6F && p[3] == 0x72 && p[4] == 0x62 && p[5] == 0x69 && p[6] == 0x73;

  static int _u32(Uint8List b, int p) =>
      (b[p]) | (b[p + 1] << 8) | (b[p + 2] << 16) | (b[p + 3] << 24);

  static int _u64(Uint8List b, int p) {
    int v = 0;
    for (int i = 0; i < 8; i++) {
      v |= (b[p + i] << (i * 8));
    }
    return v;
  }
}



class VorbisIdentificationHeader {
  final int version;
  final int channels;
  final int sampleRate;
  final int bitrateMax;
  final int bitrateNominal;
  final int bitrateMin;
  final int blocksize0;
  final int blocksize1;

  VorbisIdentificationHeader({
    required this.version,
    required this.channels,
    required this.sampleRate,
    required this.bitrateMax,
    required this.bitrateNominal,
    required this.bitrateMin,
    required this.blocksize0,
    required this.blocksize1,
  });
}

class VorbisCommentHeader {
  final String vendor;
  final Map<String, String> comments;

  VorbisCommentHeader({
    required this.vendor,
    required this.comments,
  });
}

class VorbisParser {
  static VorbisIdentificationHeader parseIdentification(Uint8List payload) {
    int p = 7; // skip header type + "vorbis"

    final version = _u32(payload, p); p += 4;
    final channels = payload[p++];
    final sampleRate = _u32(payload, p); p += 4;

    final max = _u32(payload, p); p += 4;
    final nominal = _u32(payload, p); p += 4;
    final min = _u32(payload, p); p += 4;

    final block = payload[p++];
    final block0 = block & 0x0F;
    final block1 = (block >> 4) & 0x0F;

    return VorbisIdentificationHeader(
      version: version,
      channels: channels,
      sampleRate: sampleRate,
      bitrateMax: max,
      bitrateNominal: nominal,
      bitrateMin: min,
      blocksize0: block0,
      blocksize1: block1,
    );
  }

  static VorbisCommentHeader parseComments(Uint8List payload) {
    int p = 7;

    final vendorLen = _u32(payload, p); p += 4;
    final vendor = utf8.decode(payload.sublist(p, p + vendorLen));
    p += vendorLen;

    final count = _u32(payload, p); p += 4;

    final comments = <String, String>{};

    for (int i = 0; i < count; i++) {
      final len = _u32(payload, p); p += 4;
      final entry = utf8.decode(payload.sublist(p, p + len));
      p += len;

      final eq = entry.indexOf('=');
      if (eq > 0) {
        comments[entry.substring(0, eq).toUpperCase()] = entry.substring(eq + 1);
      }
    }

    return VorbisCommentHeader(
      vendor: vendor,
      comments: comments,
    );
  }

  static int _u32(Uint8List b, int p) =>
      (b[p]) | (b[p + 1] << 8) | (b[p + 2] << 16) | (b[p + 3] << 24);
}
