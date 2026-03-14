part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';


Future<Uint8List> _mp4ToPCM(Uint8List mp3Bytes) async {
  final Uint8List pcmBytes = await AudioDecoder.convertToWavBytes(
    mp3Bytes,
    formatHint: 'mp4',
    includeHeader: true,
  );
  return pcmBytes;
}

Future<AudioInfo> _mp4AudioInfo(Uint8List bytes) async {

  Uint8List amplitudesData = Uint8List.fromList([]);

  await _mp4ToPCM(bytes).then((value) {
    amplitudesData = value;
  });

  final info = await AudioDecoder.getAudioInfoBytes(bytes, formatHint: 'mp4');
  return AudioInfo(
      duration: info.duration,
      sampleRate: info.sampleRate,
      channels: info.channels,
      bitRate: info.bitRate,
      format: info.format,
      bytes: amplitudesData);
}
