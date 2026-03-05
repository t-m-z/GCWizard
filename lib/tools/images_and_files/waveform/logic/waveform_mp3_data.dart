part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

Map<int, String> _mp3ID = {
  0: 'MPEG Version 2.5',
  1: 'reserved',
  2: 'MPEG Version 2',
  3: 'MPEG Version 1',
};

Map<int, String> _mp3Layer = {
  0 : 'reserved',
  1 : 'Layer III',
  2 : 'Layer II',
  3 : 'Layer I,'
};

Map<int, String> _mp3ChannelMode = {
  0 : 'Stereo',
  1 : 'Joint Stereo',
  2 : '2 Mono Kanäle',
  3 : 'Mono',
};

Map<int, String> _mp3Emphasis = {
  0 : '-',
  1 : '50/15 ms',
  2 : 'reserved',
  3 : 'ITU-T J.17',
};

Map<int, Map<int, String>> _mp3SampleRate = {
  0 : {0: '11,025', 2: '22,050', 3: '44,100'},
  1 : {0: '12,000', 2: '24,000', 3: '48,000'},
  2 : {0: '8,000', 2: '16,000', 3: '32,000'},
  3 : {0: 'reserved', 2: 'reserved', 3: 'reserved'},
};

int _getMP3BitRate(){
  return 0;
}

String _getMP3SampleRate(int layer, int sampleRate){
  return _mp3SampleRate[sampleRate]![layer]!;
}



Future<Uint8List> _mp3ToPCM(Uint8List mp3Bytes) async {
  final Uint8List pcmBytes = await AudioDecoder.convertToWavBytes(
    mp3Bytes,
    formatHint: 'mp3',
    includeHeader: true,
  );
  return pcmBytes;
}

SoundfileData MP3Content(Uint8List bytes) {
  // http://mpgedit.org/mpgedit/mpeg_format/MP3Format.html
  // https://de.wikipedia.org/wiki/MP3
  // Frame Header 4 Bytes
  // Framegröße = (144 · Bitrate) : Samplerate + Padding [bytes]

  List<SoundfileDataSection> WaveFormDataSectionList = [];
  SoundfileDataSection section;
  List<SoundfileDataSectionContent> sectionContentList = [];

  Uint8List amplitudesData = Uint8List.fromList([]);
  _mp3ToPCM(bytes).then((value) {
    amplitudesData = value;
    print(String.fromCharCodes(amplitudesData.sublist(0, 4)));
  });

  String header = convertBase(bytes[0].toString(), 10, 2).padLeft(8, '0') +
      convertBase(bytes[1].toString(), 10, 2).padLeft(8, '0') +
      convertBase(bytes[2].toString(), 10, 2).padLeft(8, '0') +
      convertBase(bytes[3].toString(), 10, 2).padLeft(8, '0');

  int id = int.parse(convertBase(header[11] + header[12], 2, 10));
  int layer = int.parse(convertBase(header[13] + header[14], 2, 10));
  int protection = int.parse(header[15]);
  int bitrate = 0; // 4 Bit 16 17 18 19
  double sampleRate = double.parse(_getMP3SampleRate(layer, int.parse(convertBase(header[20] + header[21], 2, 10)))); // 2 Bit 20 21
  int padding = int.parse(header[22]);
  int private = int.parse(header[23]);
  int channelMode = int.parse(convertBase(header[24] + header[25], 2, 10));
  int modeExtension = 0; // 2 Bit 26 27
  int copyright = int.parse(header[28]);
  int original = int.parse(header[29]);
  int emphasis = int.parse(convertBase(header[30] + header[31], 2, 10));

  int frameSize = 144 * bitrate ~/ sampleRate + padding;

  int index = 0;

  return SoundfileData(
    wavFile: wavFileData(
        PCMformat: 0, bits: 0, channels: 0, sampleRate: 0, duration: 0),
    mp3File: mp3FileData(
      id: id,
      layer: layer,
      protection: protection,
      bitrate: bitrate,
      sampleRate: sampleRate,
      padding: padding,
      private: private,
      channelMode: channelMode,
      modeExtension: modeExtension,
      copyright: copyright,
      original: original,
      emphasis: emphasis,
    ),
    amplitudesData: amplitudesData,
    structure: WaveFormDataSectionList,
    status: SoundfileStatus.OK,
    error: '',
  );
}
