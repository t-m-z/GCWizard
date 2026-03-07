part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

class SoundfileOutput {
  final List<Widget> Widgets;

  SoundfileOutput({required this.Widgets});
}

enum SoundfileStatus { OK, ERROR, ZERO }

class wavFileData {
  final int PCMformat;
  final int bits;
  final int channels;
  final int sampleRate;
  final double duration;

  wavFileData(
      {required this.PCMformat,
      required this.bits,
      required this.channels,
      required this.sampleRate,
      required this.duration});
}

class mp3FileData {
  final int id;
  final int layer;
  final int protection;
  final int bitrate;
  final double sampleRate;
  final int padding;
  final int private;
  final int channelMode;
  final int modeExtension;
  final int copyright;
  final int original;
  final int emphasis;

  mp3FileData({
    required this.id,
    required this.layer,
    required this.protection,
    required this.bitrate,
    required this.sampleRate,
    required this.padding,
    required this.private,
    required this.channelMode,
    required this.modeExtension,
    required this.copyright,
    required this.original,
    required this.emphasis,
  });
}

class oggFileData {
  final int id;
  final int layer;
  final int protection;
  final int bitrate;
  final double sampleRate;
  final int padding;
  final int private;
  final int channelMode;
  final int modeExtension;
  final int copyright;
  final int original;
  final int emphasis;

  oggFileData({
    required this.id,
    required this.layer,
    required this.protection,
    required this.bitrate,
    required this.sampleRate,
    required this.padding,
    required this.private,
    required this.channelMode,
    required this.modeExtension,
    required this.copyright,
    required this.original,
    required this.emphasis,
  });
}

class SoundfileData {
  final wavFileData? wavFile;
  final mp3FileData? mp3File;
  final oggFileData? oggFile;
  final List<SoundfileDataSection> structure;
  final SoundfileStatus status;
  final String error;

  SoundfileData(
      {required this.wavFile,
      required this.mp3File,
      required this.oggFile,
      required this.structure,
      required this.status,
      required this.error});
}

class SoundfileDataSection {
  final String SectionTitle;
  final List<SoundfileDataSectionContent> SectionContent;

  SoundfileDataSection(
      {required this.SectionTitle, required this.SectionContent});
}

class SoundfileDataSectionContent {
  final String Meaning;
  final String Bytes;
  final String Value;

  SoundfileDataSectionContent(
      {required this.Meaning, required this.Bytes, required this.Value});
}

class SoundfileDataSectionContentAnalyze {
  final List<SoundfileDataSectionContent> output;
  final SoundfileStatus status;
  final String error;

  SoundfileDataSectionContentAnalyze(
      {required this.output, required this.status, required this.error});
}
