import 'dart:typed_data';
import '_gemini_id3.dart';

///////////////////////////////////////////////////////////////////////////////
// MP3 FRAME HEADER (kompakt)
///////////////////////////////////////////////////////////////////////////////

class Mp3FrameHeader {
  final int offset;
  final int mpegVersion;
  final int layer;
  final int bitrateKbps;
  final int sampleRate;
  final bool padding;
  final String channelMode;
  final bool hasCrc;
  final int frameLength;

  Mp3FrameHeader({
    required this.offset,
    required this.mpegVersion,
    required this.layer,
    required this.bitrateKbps,
    required this.sampleRate,
    required this.padding,
    required this.channelMode,
    required this.hasCrc,
    required this.frameLength,
  });
}

///////////////////////////////////////////////////////////////////////////////
// XING HEADER (kompakt)
///////////////////////////////////////////////////////////////////////////////

class XingHeader {
  final int? frameCount;
  final int? fileSize;
  final List<int>? toc;
  final int? vbrQuality;

  XingHeader({this.frameCount, this.fileSize, this.toc, this.vbrQuality});
}

class XingDecoder {
  static XingHeader? decode(Uint8List bytes, int frameStart, Mp3FrameHeader h) {
    final pos = frameStart + _offset(h);
    if (pos + 8 >= bytes.length) return null;

    final tag = String.fromCharCodes(bytes.sublist(pos, pos + 4));
    if (tag != 'Xing' && tag != 'Info') return null;

    int p = pos + 4;
    final flags = _u32(bytes, p);
    p += 4;

    int? frames, size, quality;
    List<int>? toc;

    if ((flags & 0x01) != 0) { frames = _u32(bytes, p); p += 4; }
    if ((flags & 0x02) != 0) { size = _u32(bytes, p); p += 4; }
    if ((flags & 0x04) != 0) { toc = bytes.sublist(p, p + 100); p += 100; }
    if ((flags & 0x08) != 0) { quality = _u32(bytes, p); }

    return XingHeader(frameCount: frames, fileSize: size, toc: toc, vbrQuality: quality);
  }

  static int _offset(Mp3FrameHeader h) =>
      h.mpegVersion == 1 ? (h.channelMode == 'Mono' ? 21 : 36)
          : (h.channelMode == 'Mono' ? 13 : 21);

  static int _u32(Uint8List b, int p) =>
      (b[p] << 24) | (b[p + 1] << 16) | (b[p + 2] << 8) | b[p + 3];
}

///////////////////////////////////////////////////////////////////////////////
// LAME HEADER (kompakt)
///////////////////////////////////////////////////////////////////////////////

class LameHeader {
  final String encoder;
  final int vbrQuality;
  final int lowpass;
  final int delay;
  final int padding;

  LameHeader({
    required this.encoder,
    required this.vbrQuality,
    required this.lowpass,
    required this.delay,
    required this.padding,
  });
}

class LameDecoder {
  static LameHeader? decode(Uint8List bytes, int pos) {
    if (pos + 36 >= bytes.length) return null;

    final tag = String.fromCharCodes(bytes.sublist(pos, pos + 4));
    if (tag != 'LAME') return null;

    final encoder = String.fromCharCodes(bytes.sublist(pos, pos + 9)).trim();
    final vbr = bytes[pos + 9];
    final lowpass = bytes[pos + 10] * 100;

    final delay = (bytes[pos + 21] << 4) | (bytes[pos + 22] >> 4);
    final padding = ((bytes[pos + 22] & 0x0F) << 8) | bytes[pos + 23];

    return LameHeader(
      encoder: encoder,
      vbrQuality: vbr,
      lowpass: lowpass,
      delay: delay,
      padding: padding,
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
// MP3 DURATION (kompakt)
///////////////////////////////////////////////////////////////////////////////

class Mp3Duration {
  static double compute({
    required int fileSize,
    required int id3v2Size,
    required int sampleRate,
    required int bitrateKbps,
    int? frameCount,
  }) {
    if (frameCount != null && frameCount > 0) {
      return (frameCount * 1152) / sampleRate * 1000.0;
    }

    final audioBytes = fileSize - id3v2Size;
    return (audioBytes / (bitrateKbps * 125)) * 1000.0;
  }
}

///////////////////////////////////////////////////////////////////////////////
// MP3 INSPECTOR (kompakt)
///////////////////////////////////////////////////////////////////////////////

class Mp3Inspector {
  static Map<String, dynamic> inspect(Uint8List bytes) {
    int offset = 0;

    // --- ID3v2 ---
    Id3v2Tag? id3v2;
    int id3v2Size = 0;

    if (_isId3v2(bytes)) {
      final size = _syncSafe(bytes, 6);
      id3v2Size = size + 10;

      id3v2 = _readId3v2(bytes, size);
      offset = id3v2Size;
    }

    // --- First MP3 frame ---
    final header = _findFrame(bytes, offset);
    if (header == null) {
      return {'error': 'No MP3 frame found'};
    }

    // --- Xing ---
    final xing = XingDecoder.decode(bytes, header.offset, header);

    // --- LAME ---
    LameHeader? lame;
    if (xing != null) {
      final lamePos = header.offset + XingDecoder._offset(header) + 120;
      lame = LameDecoder.decode(bytes, lamePos);
    }

    // --- Duration ---
    final durationMs = Mp3Duration.compute(
      fileSize: bytes.length,
      id3v2Size: id3v2Size,
      sampleRate: header.sampleRate,
      bitrateKbps: header.bitrateKbps,
      frameCount: xing?.frameCount,
    );

    return {
      'id3v2': id3v2,
      'id3v1': Id3v1Decoder.decode(bytes),
      'frame': header,
      'xing': xing,
      'lame': lame,
      'durationMs': durationMs,
    };
  }

  /////////////////////////////////////////////////////////////////////////////
  // INTERNAL HELPERS
  /////////////////////////////////////////////////////////////////////////////

  static bool _isId3v2(Uint8List b) =>
      b.length >= 10 && b[0] == 0x49 && b[1] == 0x44 && b[2] == 0x33;

  static int _syncSafe(Uint8List b, int p) =>
      (b[p] << 21) | (b[p + 1] << 14) | (b[p + 2] << 7) | b[p + 3];

  static Id3v2Tag _readId3v2(Uint8List b, int size) {
    final frames = <Id3v2Frame>[];
    int pos = 10;
    final end = 10 + size;

    while (pos + 10 <= end) {
      final id = String.fromCharCodes(b.sublist(pos, pos + 4));
      final frameSize = _u32(b, pos + 4);
      final flags = (b[pos + 8] << 8) | b[pos + 9];

      if (frameSize == 0 || id.trim().isEmpty) break;

      frames.add(Id3v2Frame(id: id, size: frameSize, flags: flags, offset: pos));
      pos += 10 + frameSize;
    }

    return Id3v2Tag(
      versionMajor: b[3],
      versionMinor: b[4],
      flags: b[5],
      size: size,
      frames: frames,
    );
  }

  static Mp3FrameHeader? _findFrame(Uint8List b, int pos) {
    while (pos + 4 < b.length) {
      if (b[pos] == 0xFF && (b[pos + 1] & 0xE0) == 0xE0) {
        final h = _parseHeader(b, pos);
        if (h != null) return h;
      }
      pos++;
    }
    return null;
  }

  static Mp3FrameHeader? _parseHeader(Uint8List b, int pos) {
    final b1 = b[pos + 1];
    final b2 = b[pos + 2];
    final b3 = b[pos + 3];

    final versionBits = (b1 >> 3) & 0x03;
    final layerBits = (b1 >> 1) & 0x03;
    final hasCrc = (b1 & 0x01) == 0;

    int version;
    switch (versionBits) {
      case 0:
      version = 25;
      break;
      case 2:
      version = 2;
      break;
      case 3:
      version = 1;
      break;
      default:
        version = -1;
    }


    int layer;
    switch (layerBits) {
      case 1:
      layer = 3;
      break;
      case 2:
      layer = 2;
      break;
      case 3:
      layer = 1;
      break;
      default:
        layer = -1;
    }


    if (version == -1 || layer == -1) return null;

    final bitrateIndex = (b2 >> 4) & 0x0F;
    final sampleRateIndex = (b2 >> 2) & 0x03;
    final padding = ((b2 >> 1) & 0x01) == 1;

    final bitrate = _bitrate(version, layer, bitrateIndex);
    final sampleRate = _sampleRate(version, sampleRateIndex);
    if (bitrate == 0 || sampleRate == 0) return null;

    final channelMode = switch ((b3 >> 6) & 0x03) {
      0 => 'Stereo',
      1 => 'Joint Stereo',
      2 => 'Dual Channel',
      3 => 'Mono',
      _ => 'Unknown',
    };

    final frameLength = _frameSize(layer, bitrate, sampleRate, padding);

    return Mp3FrameHeader(
      offset: pos,
      mpegVersion: version,
      layer: layer,
      bitrateKbps: bitrate,
      sampleRate: sampleRate,
      padding: padding,
      channelMode: channelMode,
      hasCrc: hasCrc,
      frameLength: frameLength,
    );
  }

  static int _bitrate(int v, int l, int i) {
    const v1l3 = [0,32,40,48,56,64,80,96,112,128,160,192,224,256,320,0];
    const v2l3 = [0,8,16,24,32,40,48,56,64,80,96,112,128,144,160,0];
    return (v == 1 && l == 3) ? v1l3[i] : v2l3[i];
  }

  static int _sampleRate(int v, int i) {
    const base = [44100, 48000, 32000, 0];
    if (i > 2) return 0;
    return switch (v) {
      1 => base[i],
      2 => base[i] ~/ 2,
      25 => base[i] ~/ 4,
      _ => 0,
    };
  }

  static int _frameSize(int layer, int bitrate, int sr, bool pad) {
    if (layer == 3) return ((144000 * bitrate) ~/ sr) + (pad ? 1 : 0);
    if (layer == 2) return ((144000 * bitrate) ~/ sr) + (pad ? 1 : 0);
    return ((12000 * bitrate) ~/ sr + (pad ? 4 : 0)) * 4;
  }

  static int _u32(Uint8List b, int p) =>
      (b[p] << 24) | (b[p + 1] << 16) | (b[p + 2] << 8) | b[p + 3];
}
