part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';


Future<AudioInfo> wavAudioInfo(Uint8List bytes) async {
  final info = await AudioDecoder.getAudioInfoBytes(bytes, formatHint: 'wav');
  return AudioInfo(
      duration: info.duration,
      sampleRate: info.sampleRate,
      channels: info.channels,
      bitRate: info.bitRate,
      format: info.format,
      bytes: bytes);
}
