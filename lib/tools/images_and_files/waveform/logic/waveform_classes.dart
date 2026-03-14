part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

class AudioInfo {
  final Duration duration;
  final int sampleRate;
  final int channels;
  final int bitRate;
  final String format;
  final Uint8List bytes;

  AudioInfo(
      {required this.duration,
      required this.sampleRate,
      required this.channels,
      required this.bitRate,
      required this.format,
      required this.bytes});
}
