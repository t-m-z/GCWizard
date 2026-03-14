import 'dart:typed_data';
import 'package:audio_decoder/audio_decoder.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_classes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_oga.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_ogg.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_wav.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_mp3.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_mp4.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_wma.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_aif.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_webm.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_amplitudes_aiff.dart';

Future<AudioInfo> getSoundfileAudioInfo(Uint8List bytes) async {
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return _wavAudioInfo(bytes);
    case FileType.WMA:
      return _wmaAudioInfo(bytes);
    case FileType.WEBM:
      return _webmAudioInfo(bytes);
    case FileType.MP3:
      return _mp3AudioInfo(bytes);
    case FileType.MP4:
      return _mp4AudioInfo(bytes);
    case FileType.OGG:
      return _oggAudioInfo(bytes);
    case FileType.OGA:
      return _ogaAudioInfo(bytes);
    case FileType.AIF:
      return _aifAudioInfo(bytes);
    case FileType.AIFF:
      return _aiffAudioInfo(bytes);
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