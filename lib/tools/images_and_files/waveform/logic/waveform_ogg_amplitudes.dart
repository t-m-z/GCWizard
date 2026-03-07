part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';


Future<Uint8List> _oggToPCM(Uint8List oggBytes) async {
  final Uint8List pcmBytes = await AudioDecoder.convertToWavBytes(
    oggBytes,
    formatHint: 'ogg',
    includeHeader: true,
  );
  return pcmBytes;
}

Future<Uint8List> oggAmplitudes(Uint8List bytes) async {

  Uint8List amplitudesData = Uint8List.fromList([]);

  await _oggToPCM(bytes).then((value) {
    amplitudesData = value;
  });

  return amplitudesData;
}
