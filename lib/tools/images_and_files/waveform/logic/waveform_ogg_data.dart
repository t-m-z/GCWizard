part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';




Future<SoundfileData> oggContent(Uint8List bytes) async {
// https://en.wikipedia.org/wiki/Ogg

  return SoundfileData(
      wavFile: null,
      mp3File: null,
      oggFile: null,
      structure: [],
      status: SoundfileStatus.OK,
      error: '');
}
