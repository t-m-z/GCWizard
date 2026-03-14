part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';


Future<Uint8List> _oggToPCM(Uint8List oggBytes) async {
  final Uint8List pcmBytes = await AudioDecoder.convertToWavBytes(
    oggBytes,
    formatHint: 'ogg',
    includeHeader: true,
  );
  return pcmBytes;
}

Future<AudioInfo> _oggAudioInfo(Uint8List bytes) async {

  Uint8List amplitudesData = Uint8List.fromList([]);

  await _oggToPCM(bytes).then((value) {
    amplitudesData = value;
  });

  final info = await AudioDecoder.getAudioInfoBytes(bytes, formatHint: 'ogg');
  return AudioInfo(
      duration: info.duration,
      sampleRate: info.sampleRate,
      channels: info.channels,
      bitRate: info.bitRate,
      format: info.format,
      bytes: amplitudesData);
}

