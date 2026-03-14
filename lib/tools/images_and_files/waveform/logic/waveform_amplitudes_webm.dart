part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';


Future<Uint8List> _webmToPCM(Uint8List mp3Bytes) async {
  final Uint8List pcmBytes = await AudioDecoder.convertToWavBytes(
    mp3Bytes,
    formatHint: 'webm',
    includeHeader: true,
  );
  return pcmBytes;
}

Future<AudioInfo> _webmAudioInfo(Uint8List bytes) async {

  Uint8List amplitudesData = Uint8List.fromList([]);

  await _webmToPCM(bytes).then((value) {
    amplitudesData = value;
  });

  final info = await AudioDecoder.getAudioInfoBytes(bytes, formatHint: 'webm');
  return AudioInfo(
      duration: info.duration,
      sampleRate: info.sampleRate,
      channels: info.channels,
      bitRate: info.bitRate,
      format: info.format,
      bytes: amplitudesData);
}
