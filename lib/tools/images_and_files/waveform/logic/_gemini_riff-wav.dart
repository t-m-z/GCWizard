import 'dart:typed_data';
import 'dart:convert';


class RiffChunk {
  final String id;
  final int size;
  final Uint8List data;

  RiffChunk({
    required this.id,
    required this.size,
    required this.data,
  });
}

class RiffFile {
  final String format;
  final List<RiffChunk> chunks;

  RiffFile({
    required this.format,
    required this.chunks,
  });
}

class RiffParser {
  static RiffFile parse(Uint8List bytes) {
    if (bytes.length < 12 ||
        bytes[0] != 0x52 || bytes[1] != 0x49 || bytes[2] != 0x46 || bytes[3] != 0x46) {
      throw FormatException("Not a RIFF file");
    }

    final format = String.fromCharCodes(bytes.sublist(8, 12));
    final chunks = <RiffChunk>[];

    int pos = 12;
    while (pos + 8 <= bytes.length) {
      final id = String.fromCharCodes(bytes.sublist(pos, pos + 4));
      final size = _u32(bytes, pos + 4);

      final start = pos + 8;
      final end = start + size;
      if (end > bytes.length) break;

      chunks.add(RiffChunk(
        id: id,
        size: size,
        data: bytes.sublist(start, end),
      ));

      pos = end + (size.isOdd ? 1 : 0); // padding byte
    }

    return RiffFile(format: format, chunks: chunks);
  }

  static int _u32(Uint8List b, int p) =>
      b[p] | (b[p + 1] << 8) | (b[p + 2] << 16) | (b[p + 3] << 24);
}





class WavFormat {
  final int audioFormat;
  final int channels;
  final int sampleRate;
  final int byteRate;
  final int blockAlign;
  final int bitsPerSample;

  WavFormat({
    required this.audioFormat,
    required this.channels,
    required this.sampleRate,
    required this.byteRate,
    required this.blockAlign,
    required this.bitsPerSample,
  });
}

class WavData {
  final int dataSize;
  final double durationMs;

  WavData({
    required this.dataSize,
    required this.durationMs,
  });
}

class WavBext {
  final String description;
  final String originator;
  final String originatorRef;
  final String origDate;
  final String origTime;
  final int timeRefLow;
  final int timeRefHigh;
  final int version;
  final String umid;

  WavBext({
    required this.description,
    required this.originator,
    required this.originatorRef,
    required this.origDate,
    required this.origTime,
    required this.timeRefLow,
    required this.timeRefHigh,
    required this.version,
    required this.umid,
  });
}

class WavCuePoint {
  final int id;
  final int position;
  final String dataChunkId;
  final int chunkStart;
  final int blockStart;
  final int sampleOffset;

  WavCuePoint({
    required this.id,
    required this.position,
    required this.dataChunkId,
    required this.chunkStart,
    required this.blockStart,
    required this.sampleOffset,
  });
}

class WavSmpl {
  final int manufacturer;
  final int product;
  final int samplePeriod;
  final int midiUnityNote;
  final int midiPitchFraction;
  final int smpteFormat;
  final int smpteOffset;
  final List<WavSmplLoop> loops;

  WavSmpl({
    required this.manufacturer,
    required this.product,
    required this.samplePeriod,
    required this.midiUnityNote,
    required this.midiPitchFraction,
    required this.smpteFormat,
    required this.smpteOffset,
    required this.loops,
  });
}

class WavSmplLoop {
  final int id;
  final int type;
  final int start;
  final int end;
  final int fraction;
  final int playCount;

  WavSmplLoop({
    required this.id,
    required this.type,
    required this.start,
    required this.end,
    required this.fraction,
    required this.playCount,
  });
}

class WavFact {
  final int sampleLength;

  WavFact({required this.sampleLength});
}

class WavFile {
  final WavFormat? format;
  final WavData? data;
  final Map<String, String> infoTags;
  final WavBext? bext;
  final List<WavCuePoint> cue;
  final WavSmpl? smpl;
  final WavFact? fact;
  final List<RiffChunk> otherChunks;

  WavFile({
    required this.format,
    required this.data,
    required this.infoTags,
    required this.bext,
    required this.cue,
    required this.smpl,
    required this.fact,
    required this.otherChunks,
  });
}

class WavParser {
  static WavFile parse(Uint8List bytes) {
    final riff = RiffParser.parse(bytes);
    if (riff.format != "WAVE") {
      throw FormatException("Not a WAVE file");
    }

    WavFormat? fmt;
    WavData? data;
    WavBext? bext;
    WavSmpl? smpl;
    WavFact? fact;
    final cue = <WavCuePoint>[];
    final info = <String, String>{};
    final others = <RiffChunk>[];

    for (final chunk in riff.chunks) {
      switch (chunk.id) {
        case "fmt ":
          fmt = _parseFmt(chunk.data);
          break;

        case "data":
          if (fmt != null) {
            final duration = (chunk.size / fmt.byteRate) * 1000.0;
            data = WavData(dataSize: chunk.size, durationMs: duration);
          }
          break;

        case "LIST":
          info.addAll(_parseList(chunk.data));
          break;

        case "bext":
          bext = _parseBext(chunk.data);
          break;

        case "cue ":
          cue.addAll(_parseCue(chunk.data));
          break;

        case "smpl":
          smpl = _parseSmpl(chunk.data);
          break;

        case "fact":
          fact = _parseFact(chunk.data);
          break;

        default:
          others.add(chunk);
      }
    }

    return WavFile(
      format: fmt,
      data: data,
      infoTags: info,
      bext: bext,
      cue: cue,
      smpl: smpl,
      fact: fact,
      otherChunks: others,
    );
  }

  // --------------------------------------------------------------------------
  // fmt CHUNK
  // --------------------------------------------------------------------------

  static WavFormat _parseFmt(Uint8List d) {
    final audioFormat = _u16(d, 0);
    final channels = _u16(d, 2);
    final sampleRate = _u32(d, 4);
    final byteRate = _u32(d, 8);
    final blockAlign = _u16(d, 12);
    final bitsPerSample = _u16(d, 14);

    return WavFormat(
      audioFormat: audioFormat,
      channels: channels,
      sampleRate: sampleRate,
      byteRate: byteRate,
      blockAlign: blockAlign,
      bitsPerSample: bitsPerSample,
    );
  }

  // --------------------------------------------------------------------------
  // LIST/INFO CHUNK
  // --------------------------------------------------------------------------

  static Map<String, String> _parseList(Uint8List d) {
    final tags = <String, String>{};

    if (d.length < 4) return tags;
    final type = String.fromCharCodes(d.sublist(0, 4));
    if (type != "INFO") return tags;

    int pos = 4;
    while (pos + 8 <= d.length) {
      final id = String.fromCharCodes(d.sublist(pos, pos + 4));
      final size = _u32(d, pos + 4);

      final start = pos + 8;
      final end = start + size;
      if (end > d.length) break;

      final value = utf8.decode(d.sublist(start, end)).trimRight();
      tags[id] = value;

      pos = end + (size.isOdd ? 1 : 0);
    }

    return tags;
  }

  // --------------------------------------------------------------------------
  // bext CHUNK
  // --------------------------------------------------------------------------

  static WavBext _parseBext(Uint8List d) {
    String _str(int start, int len) =>
        ascii.decode(d.sublist(start, start + len)).trimRight();

    final desc = _str(0, 256);
    final originator = _str(256, 32);
    final originatorRef = _str(288, 32);
    final origDate = _str(320, 10);
    final origTime = _str(330, 8);

    final timeLow = _u32(d, 338);
    final timeHigh = _u32(d, 342);

    final version = _u16(d, 346);

    final umid = ascii.decode(d.sublist(348, 348 + 64));

    return WavBext(
      description: desc,
      originator: originator,
      originatorRef: originatorRef,
      origDate: origDate,
      origTime: origTime,
      timeRefLow: timeLow,
      timeRefHigh: timeHigh,
      version: version,
      umid: umid,
    );
  }

  // --------------------------------------------------------------------------
  // cue CHUNK
  // --------------------------------------------------------------------------

  static List<WavCuePoint> _parseCue(Uint8List d) {
    final count = _u32(d, 0);
    final list = <WavCuePoint>[];

    int p = 4;
    for (int i = 0; i < count; i++) {
      final id = _u32(d, p); p += 4;
      final pos = _u32(d, p); p += 4;
      final chunkId = String.fromCharCodes(d.sublist(p, p + 4)); p += 4;
      final chunkStart = _u32(d, p); p += 4;
      final blockStart = _u32(d, p); p += 4;
      final sampleOffset = _u32(d, p); p += 4;

      list.add(WavCuePoint(
        id: id,
        position: pos,
        dataChunkId: chunkId,
        chunkStart: chunkStart,
        blockStart: blockStart,
        sampleOffset: sampleOffset,
      ));
    }

    return list;
  }

  // --------------------------------------------------------------------------
  // smpl CHUNK
  // --------------------------------------------------------------------------

  static WavSmpl _parseSmpl(Uint8List d) {
    int p = 0;

    final manufacturer = _u32(d, p); p += 4;
    final product = _u32(d, p); p += 4;
    final samplePeriod = _u32(d, p); p += 4;
    final midiUnityNote = _u32(d, p); p += 4;
    final midiPitchFraction = _u32(d, p); p += 4;
    final smpteFormat = _u32(d, p); p += 4;
    final smpteOffset = _u32(d, p); p += 4;

    final loopCount = _u32(d, p); p += 4;
    p += 4; // sampler data length

    final loops = <WavSmplLoop>[];

    for (int i = 0; i < loopCount; i++) {
      final id = _u32(d, p); p += 4;
      final type = _u32(d, p); p += 4;
      final start = _u32(d, p); p += 4;
      final end = _u32(d, p); p += 4;
      final fraction = _u32(d, p); p += 4;
      final playCount = _u32(d, p); p += 4;

      loops.add(WavSmplLoop(
        id: id,
        type: type,
        start: start,
        end: end,
        fraction: fraction,
        playCount: playCount,
      ));
    }

    return WavSmpl(
      manufacturer: manufacturer,
      product: product,
      samplePeriod: samplePeriod,
      midiUnityNote: midiUnityNote,
      midiPitchFraction: midiPitchFraction,
      smpteFormat: smpteFormat,
      smpteOffset: smpteOffset,
      loops: loops,
    );
  }

  // --------------------------------------------------------------------------
  // fact CHUNK
  // --------------------------------------------------------------------------

  static WavFact _parseFact(Uint8List d) {
    final sampleLength = _u32(d, 0);
    return WavFact(sampleLength: sampleLength);
  }

  // --------------------------------------------------------------------------
  // Helpers
  // --------------------------------------------------------------------------

  static int _u16(Uint8List b, int p) => b[p] | (b[p + 1] << 8);

  static int _u32(Uint8List b, int p) =>
      b[p] | (b[p + 1] << 8) | (b[p + 2] << 16) | (b[p + 3] << 24);
}
