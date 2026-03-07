import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audio_decoder/audio_decoder.dart';
import 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_classes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_ogg_data.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_wav_data.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_mp3_data.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_ogg_amplitudes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_wav_amplitudes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_mp3_amplitudes.dart';

Future<SoundfileData> getSoundfileData(Uint8List bytes) async {
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return wavContent(bytes);
    case FileType.MP3:
      return mp3Content(bytes);
    case FileType.OGG:
      return oggContent(bytes);
    default:
      return SoundfileData(
          wavFile: null,
          mp3File: null,
          oggFile: null,
          structure: [],
          status: SoundfileStatus.ZERO,
          error: '');
  }
}

Future<AudioInfo> getSoundfileAudioInfo(Uint8List bytes) async {
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return wavAudioInfo(bytes);
    case FileType.MP3:
      return mp3AudioInfo(bytes);
    case FileType.OGG:
      return oggAudioInfo(bytes);
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