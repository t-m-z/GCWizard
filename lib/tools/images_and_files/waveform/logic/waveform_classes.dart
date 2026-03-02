part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

class SoundfileOutput {
  final List<Widget> Widgets;

  SoundfileOutput({required this.Widgets});
}

enum SoundfileStatus {OK, ERROR, ZERO}

class SoundfileData {
  final List<SoundfileDataSection> structure;
  final int PCMformat;
  final int bits;
  final int channels;
  final int sampleRate;
  final double duration;
  final Uint8List amplitudesData;
  final SoundfileStatus status;
  final String error;

  SoundfileData({required this.PCMformat, required this.bits, required this.channels, required this.sampleRate, required this.structure, required this.duration, required this.amplitudesData, required this.status, required this.error});
}

class SoundfileDataSection {
  final String SectionTitle;
  final List<SoundfileDataSectionContent> SectionContent;

  SoundfileDataSection({required this.SectionTitle, required this.SectionContent});
}

class SoundfileDataSectionContent {
  final String Meaning;
  final String Bytes;
  final String Value;

  SoundfileDataSectionContent({required this.Meaning, required this.Bytes, required this.Value});
}

class SoundfileDataSectionContentAnalyze {
  final List<SoundfileDataSectionContent> output;
  final SoundfileStatus status;
  final String error;

  SoundfileDataSectionContentAnalyze({required this.output, required this.status, required this.error});

}



