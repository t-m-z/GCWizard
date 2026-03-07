import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audio_decoder/audio_decoder.dart';
import 'package:gc_wizard/tools/images_and_files/waveform/logic/id3_chunk.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_classes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_wav_data.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_mp3_data.dart';

Future<SoundfileData> getSoundfileData(Uint8List bytes) async {
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return WAVContent(bytes);
    case FileType.MP3:
      return MP3Content(bytes);
    case FileType.OGG:
    default:
      return SoundfileData(
          wavFile: wavFileData(PCMformat: 0,
            bits: 0,
            channels: 0,
            sampleRate: 0,
            duration: 0.0,),
          mp3File: mp3FileData(id: 0, layer: 0, protection: 0, bitrate: 0, sampleRate: 0, padding: 0, private: 0, channelMode: 0, modeExtension: 0, copyright: 0, original: 0, emphasis: 0),
          structure: [],
          amplitudesData: Uint8List.fromList([]),
          status: SoundfileStatus.ZERO,
          error: '');
  }
}
