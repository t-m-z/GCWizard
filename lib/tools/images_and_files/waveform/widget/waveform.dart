import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';

import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/gcw_soundplayer.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/logic/animated_image_morse_code.dart';
import 'package:gc_wizard/tools/images_and_files/hex_viewer/widget/hex_viewer.dart';
import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';
import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_rms_image.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';

class WaveForm extends StatefulWidget {
  const WaveForm({Key? key}) : super(key: key);

  @override
  WaveFormState createState() => WaveFormState();
}

class WaveFormState extends State<WaveForm> {
  Uint8List _bytes = Uint8List.fromList([]);
  Uint8List _soundfileRGBAImage = Uint8List.fromList([]);
  Uint8List _soundfilePNGImage = Uint8List.fromList([]);
  SoundfileData _soundfileData = SoundfileData(
      PCMformat: 0,
      bits: 0,
      channels: 0,
      sampleRate: 0,
      structure: [],
      duration: 0.0,
      amplitudesData: Uint8List.fromList([]));

  MorseCodeOutput? _decodedMorse = MorseCodeOutput('', '');
  List<bool> _soundfileMorsecode = [];

  int _currentTolerance = 12;

  GCWSwitchPosition _currentInvert = GCWSwitchPosition.left;

  bool _spectrumCreated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setData(Uint8List bytes) {
    _bytes = bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWOpenFile(
          supportedFileTypes: const [FileType.WAV],
          onLoaded: (_file) async {
            if (_file == null) {
              showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'),
                  context);
              return;
            }
            _setData(_file.bytes);

            _soundfileData = getSoundfileData(_bytes);
            renderWavWaveformAsRgbaAndPng(
              wavBytes: _bytes,
              width: 1200,
              height: 400,
            ).then((value) {
              setState(() {
                _soundfileRGBAImage = value.rgbaBytes;
                _soundfilePNGImage = value.pngBytes;
                _spectrumCreated = true;
                _decodeMorseData();
              });
            });
          },
        ),
        GCWSoundPlayer(
          file: GCWFile(bytes: _bytes),
        ),

        _buildOutputWaveFormImage(),
        _buildOutputWaveFormMorse(),
        _buildOutputWaveFormStructure(),
      ],
    );
  }

  Widget _buildOutputWaveFormImage() {
    return Column(children: [
      (_spectrumCreated)
      ? GCWImageView(
                           imageData: GCWImageViewData(
                               GCWFile(bytes: _soundfilePNGImage)),
                           suppressOpenInTool: const {
                             GCWImageViewOpenInTools.METADATA
                           },
                         )
          //? WavWaveformWidget(
          //    wavBytes: _bytes,
          //    height: 240,
          //    backgroundColor: Colors.black,
          //    waveformColor: Colors.orange,
          //    strokeWidth: 1.0,
          //  )
          : GCWOutputText(
        text: i18n(context, 'waveform_output_image_error'),
      ),
      // (_soundfileImagePolygon.isNotEmpty)
      //     ? GCWExpandableTextDivider(
      //         text: i18n(context, 'waveform_output_amplitudes_graph'),
      //         suppressTopSpace: false,
      //         child: Column(
      //           children: <Widget>[
      //
      //             _currentDisplayMode == GCWSwitchPosition.left
      //                 ? GCWImageView(
      //                     imageData: GCWImageViewData(
      //                         GCWFile(bytes: _soundfileImagePolygon)),
      //                     suppressOpenInTool: const {
      //                       GCWImageViewOpenInTools.METADATA
      //                     },
      //                   )
      //                 : GCWImageView(
      //                     imageData: GCWImageViewData(
      //                         GCWFile(bytes: _soundfileImageRectangle)),
      //                     suppressOpenInTool: const {
      //                       GCWImageViewOpenInTools.METADATA
      //                     },
      //                   ),
      //           ],
      //         ))
      //     : GCWOutputText(
      //         text: i18n(context, 'waveform_output_image_error'),
      //       ),
    ]);
  }

  Widget _buildOutputWaveFormMorse() {
    return Column(children: [
      (_soundfileRGBAImage.isNotEmpty)
          ? GCWExpandableTextDivider(
              text: i18n(context, 'waveform_output_morsecode'),
              expanded: false,
              suppressTopSpace: false,
              child: Column(
                children: <Widget>[
                  GCWOutputText(text: _decodedMorse!.morseCode),
                  GCWOutputText(text: _decodedMorse!.text),
                ],
              ),
            )
          : GCWOutputText(
              text: i18n(context, 'waveform_output_image_error'),
            ),
    ]);
  }

  Widget _buildOutputWaveFormStructure() {
    List<Widget> output = _SoundfileStructure(_bytes);
    return Column(children: [
      GCWExpandableTextDivider(
        text: i18n(context, 'waveform_output_section_structure'),
        expanded: false,
        suppressTopSpace: false,
        child: Column(
          children: output,
        ),
      ),
      GCWOutput(
        title: i18n(context, 'waveform_output_hexview'),
        child: i18n(context, 'waveform_output_size') +
            ': ' +
            _bytes.length.toString() +
            '\n\n' +
            i18n(context, 'waveform_hint_openinhexviewer'),
        suppressCopyButton: true,
        trailing: Row(children: <Widget>[
          GCWIconButton(
            iconColor: themeColors().mainFont(),
            size: IconButtonSize.SMALL,
            icon: Icons.input,
            onPressed: () {
              openInHexViewer(context, GCWFile(bytes: _bytes));
            },
          ),
        ]),
      )
    ]);
  }

  List<Widget> _SoundfileStructure(Uint8List bytes) {
    List<Widget> result = [];

    for (var section in _soundfileData.structure) {
      List<List<dynamic>> content = [];
      content = [
        [
          i18n(context, 'waveform_output_meaning'),
          i18n(context, 'waveform_output_bytes'),
          i18n(context, 'waveform_output_value'),
        ]
      ];
      for (var element in section.SectionContent) {
        content.add([
          i18n(context, 'waveform_output_' + element.Meaning),
          element.Bytes,
          element.Value
        ]);
      }
      result.add(GCWExpandableTextDivider(
        text: i18n(context, 'waveform_output_section_' + section.SectionTitle),
        expanded: false,
        child: GCWColumnedMultilineOutput(
          data: content,
          flexValues: const [2, 3, 2],
          suppressCopyButtons: true,
          hasHeader: true,
        ),
      ));
    }

    return result;
  }

  void _decodeMorseData() {
    // if (_currentInvert == GCWSwitchPosition.left) {
    //   _decodedMorse = decodeMorseCode(
    //     List.filled(_soundfileMorsecode.length, 1),
    //     _invertMorseCode(_soundfileMorsecode),
    //     tolerance: 1.2 + (_currentTolerance - 12) / 10,
    //   );
    // } else {
    //   _decodedMorse = decodeMorseCode(
    //     List.filled(_soundfileMorsecode.length, 1),
    //     _soundfileMorsecode,
    //     tolerance: 1.2 + (_currentTolerance - 12) / 10,
    //   );
    // }
  }

  List<bool> _invertMorseCode(List<bool> soundfileMorsecode) {
    List<bool> result = [];
    soundfileMorsecode.forEach((element) {
      result.add(!element);
    });
    return result;
  }
}
