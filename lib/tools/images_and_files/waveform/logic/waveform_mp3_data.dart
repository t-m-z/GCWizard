part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

Map<int, String> _mp3ID = {
  0: 'MPEG Version 2.5',
  1: 'reserved',
  2: 'MPEG Version 2',
  3: 'MPEG Version 1',
};

Map<int, String> _mp3Layer = {
  0: 'reserved',
  1: 'Layer III',
  2: 'Layer II',
  3: 'Layer I,'
};

Map<int, String> _mp3ChannelMode = {
  0: 'Stereo',
  1: 'Joint Stereo',
  2: '2 Mono Kanäle',
  3: 'Mono',
};

Map<int, String> _mp3Emphasis = {
  0: '-',
  1: '50/15 ms',
  2: 'reserved',
  3: 'ITU-T J.17',
};

Map<int, Map<int, double>> _mp3SampleRate = {
  0: {0: 11.025, 2: 22.05, 3: 44.1},
  1: {0: 12.0, 2: 24.0, 3: 48.0},
  2: {0: 8.0, 2: 16.0, 3: 32.0},
  //3: {0: 'reserved', 2: 'reserved', 3: 'reserved'},
};

Map<int, Map<int, Map<int, int>>> _mp3BitRate = {
  // MPEG-Layer-bitrate
  20: {
    3: {
      1: 32,
      2: 48,
      3: 56,
      4: 64,
      5: 80,
      6: 96,
      7: 112,
      8: 128,
      9: 144,
      10: 160,
      11: 176,
      12: 192,
      13: 224,
      14: 256,
    },
    2: {
      1: 8,
      2: 16,
      3: 24,
      4: 32,
      5: 40,
      6: 48,
      7: 56,
      8: 64,
      9: 80,
      10: 96,
      11: 112,
      12: 128,
      13: 144,
      14: 160,
    },
    1: {
      1: 8,
      2: 16,
      3: 24,
      4: 32,
      5: 40,
      6: 48,
      7: 56,
      8: 64,
      9: 80,
      10: 96,
      11: 112,
      12: 128,
      13: 144,
      14: 160,
    }
  },
  3: {
    3: {
      1: 32,
      2: 64,
      3: 96,
      4: 128,
      5: 160,
      6: 192,
      7: 224,
      8: 256,
      9: 288,
      10: 320,
      11: 352,
      12: 384,
      13: 416,
      14: 448,
    },
    2: {
      1: 32,
      2: 48,
      3: 56,
      4: 64,
      5: 80,
      6: 96,
      7: 112,
      8: 128,
      9: 160,
      10: 192,
      11: 224,
      12: 256,
      13: 320,
      14: 384,
    },
    1: {
      1: 32,
      2: 40,
      3: 48,
      4: 56,
      5: 64,
      6: 80,
      7: 96,
      8: 112,
      9: 128,
      10: 160,
      11: 192,
      12: 224,
      13: 256,
      14: 320,
    }
  },
};

int _getMP3BitRate(int id, int layer, int bitRate) {
  if (id == 2 || id == 0) {
    return _mp3BitRate[20]![layer]![bitRate]!;

  } else { // id == 3
    return _mp3BitRate[3]![layer]![bitRate]!;
  }
}

double _getMP3SampleRate(int id, int sampleRate) {
  return _mp3SampleRate[sampleRate]![id]!;
}

Future<SoundfileData> mp3Content(Uint8List bytes) async {
  // http://mpgedit.org/mpgedit/mpeg_format/MP3Format.html
  // https://de.wikipedia.org/wiki/MP3
  // Frame Header 4 Bytes
  // Framegröße = (144 · Bitrate) : Samplerate + Padding [bytes]

  List<SoundfileDataSection> WaveFormDataSectionList = [];
  SoundfileDataSection section;
  List<SoundfileDataSectionContent> sectionContentList = [];

  String header = '';
  int id = 0;
  int layer = 0;
  int protection = 0;
  int bitRateID = 0; // 4 Bit 16 17 18 19
  int bitRate = 0;
  int sampleRateID = 0;
  double sampleRate = 0.0;
  int padding = 0;
  int private = 0;
  int channelMode = 0;
  int modeExtension = 0; // 2 Bit 26 27
  int copyright = 0;
  int original = 0;
  int emphasis = 0;

  int frameSize = 0;

  int index = 0;
  while (index < bytes.length) {
    header = convertBase(bytes[0].toString(), 10, 2).padLeft(8, '0') +
        convertBase(bytes[1].toString(), 10, 2).padLeft(8, '0') +
        convertBase(bytes[2].toString(), 10, 2).padLeft(8, '0') +
        convertBase(bytes[3].toString(), 10, 2).padLeft(8, '0');
    id = int.parse(convertBase(header[11] + header[12], 2, 10));
    layer = int.parse(convertBase(header[13] + header[14], 2, 10));
    protection = int.parse(header[15]);
    bitRateID = int.parse(convertBase(header[16] + header[17] + header[18] + header[19], 2, 10)); // 4 Bit 16 17 18 19
    bitRate = _getMP3BitRate(id, layer, bitRateID);
    sampleRateID = int.parse(convertBase(header[20] + header[21], 2, 10)); // 2 Bit 20 21
    sampleRate = _getMP3SampleRate(id, sampleRateID);
    padding = int.parse(header[22]);
    private = int.parse(header[23]);
    channelMode = int.parse(convertBase(header[24] + header[25], 2, 10));
    modeExtension = 0; // 2 Bit 26 27
    copyright = int.parse(header[28]);
    original = int.parse(header[29]);
    emphasis = int.parse(convertBase(header[30] + header[31], 2, 10));
    frameSize = (144 * bitRate ~/ sampleRate + padding).toInt();

    index = index + frameSize;
  }
  return SoundfileData(
    wavFile: null,
    oggFile: null,
    mp3File: mp3FileData(
      id: id,
      layer: layer,
      protection: protection,
      bitrate: bitRate,
      sampleRate: sampleRate,
      padding: padding,
      private: private,
      channelMode: channelMode,
      modeExtension: modeExtension,
      copyright: copyright,
      original: original,
      emphasis: emphasis,
    ),
    structure: WaveFormDataSectionList,
    status: SoundfileStatus.OK,
    error: '',
  );
}
