import 'dart:typed_data';
import 'package:audio_decoder/audio_decoder.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_classes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_ogg.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_wav.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_mp3.dart';


Future<AudioInfo> getSoundfileAudioInfo(Uint8List bytes) async {
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return _wavAudioInfo(bytes);
    case FileType.MP3:
      return _mp3AudioInfo(bytes);
    case FileType.OGG:
      return _oggAudioInfo(bytes);
    default:
      return AudioInfo(
          duration: Duration(milliseconds: 0),
          sampleRate: 0,
          channels: 0,
          bitRate: 0,
          format: '',
          bytes: Uint8List.fromList([]),
      );
  }
}