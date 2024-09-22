import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
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
import 'package:gc_wizard/common_widgets/spinners/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/logic/animated_image_morse_code.dart';
import 'package:gc_wizard/tools/images_and_files/hex_viewer/widget/hex_viewer.dart';
import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';

class WaveForm extends StatefulWidget {
  const WaveForm({Key? key}) : super(key: key);

  @override
  WaveFormState createState() => WaveFormState();
}

class WaveFormState extends State<WaveForm> {
  Uint8List _bytes = Uint8List.fromList([]);
  Uint8List _soundfileImagePolygon = Uint8List.fromList([]);
  Uint8List _soundfileImageRectangle = Uint8List.fromList([]);
  SoundfileData _soundfileData = SoundfileData(
      PCMformat: 0,
      bits: 0,
      channels: 0,
      sampleRate: 0,
      structure: [],
      duration: 0.0,
      amplitudesData: Uint8List.fromList([]));
  AmplitudeData _amplitudesData = AmplitudeData(maxAmplitude: 0.0, minAmplitude: 0.0, Amplitudes: []);
  MorseCodeOutput? _decodedMorse = MorseCodeOutput('', '');
  List<bool> _soundfileMorsecode = [];

  int _currentTolerance = 12;
  int _currentBlocksize = 4;
  final _blocksizes = [1, 2, 4, 8, 16, 32, 64, 128, 256, 384, 441, 512, 1024, 2048];

  GCWSwitchPosition _currentDisplayMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentInvert = GCWSwitchPosition.left;

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
          onLoaded: (_file) {
            if (_file == null) {
              showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
              return;
            }
            _setData(_file.bytes);
            _soundfileData = getSoundfileData(_bytes);
            _amplitudesData = calculateRMSAmplitudes(
              PCMformat: _soundfileData.PCMformat,
              bits: _soundfileData.bits,
              channels: _soundfileData.channels,
              sampleRate: _soundfileData.sampleRate,
              PCMamplitudesData: _soundfileData.amplitudesData,
              blocksize: _blocksizes[_currentBlocksize],
            );
            PCMamplitudes2Image(
              duration: _soundfileData.duration,
              RMSperPoint: _amplitudesData.Amplitudes,
              maxAmplitude: _amplitudesData.maxAmplitude,
              minAmplitude: _amplitudesData.minAmplitude,
            ).then((value) {
              setState(() {
                _soundfileImagePolygon = value.MorseImagePolygon;
                _soundfileImageRectangle = value.MorseImageRectangle;
                _soundfileMorsecode = value.MorseCode;
                _decodeMorseData();
              });
            });
          },
        ),
        GCWSoundPlayer(
          file: GCWFile(bytes: _bytes),
        ),
        GCWDropDownSpinner(
          title: i18n(context, 'waveform_settings_waveform_blocksize'),
          index: _currentBlocksize,
          items: _blocksizes.map((item) => Text(item.toString(), style: gcwTextStyle())).toList(),
          onChanged: (value) {
            setState(() {
              _currentBlocksize = value;
              _amplitudesData = calculateRMSAmplitudes(
                PCMformat: _soundfileData.PCMformat,
                bits: _soundfileData.bits,
                channels: _soundfileData.channels,
                sampleRate: _soundfileData.sampleRate,
                PCMamplitudesData: _soundfileData.amplitudesData,
                blocksize: _blocksizes[_currentBlocksize],
              );
              PCMamplitudes2Image(
                duration: _soundfileData.duration,
                RMSperPoint: _amplitudesData.Amplitudes,
                maxAmplitude: _amplitudesData.maxAmplitude,
                minAmplitude: _amplitudesData.minAmplitude,
              ).then((value) {
                setState(() {
                  _soundfileImagePolygon = value.MorseImagePolygon;
                  _soundfileImageRectangle = value.MorseImageRectangle;
                  _soundfileMorsecode = value.MorseCode;
                  _decodeMorseData();
                });
              });
            });
          },
        ),
        _buildOutputWaveFormImage(),
        _buildOutputWaveFormMorse(),
        _buildOutputWaveFormStructure(),
      ],
    );
  }

  Widget _buildOutputWaveFormImage() {
    return Column(children: [
      (_soundfileImagePolygon.isNotEmpty)
          ? GCWExpandableTextDivider(
              text: i18n(context, 'waveform_output_amplitudes_graph'),
              suppressTopSpace: false,
              child: Column(
                children: <Widget>[
                  GCWTwoOptionsSwitch(
                    value: _currentDisplayMode,
                      leftValue: i18n(context, 'waveform_output_image_polygon'),
                      rightValue: i18n(context, 'waveform_output_image_rectangle'),
                    onChanged: (value) {
                      setState(() {
                        _currentDisplayMode = value;
                      });
                    },),
                  _currentDisplayMode == GCWSwitchPosition.left
                  ? GCWImageView(
                    imageData: GCWImageViewData(GCWFile(bytes: _soundfileImagePolygon)),
                    suppressOpenInTool: const {GCWImageViewOpenInTools.METADATA},
                  )
                  : GCWImageView(
                    imageData: GCWImageViewData(GCWFile(bytes: _soundfileImageRectangle)),
                    suppressOpenInTool: const {GCWImageViewOpenInTools.METADATA},
                  ),
                ],
              ))
          : GCWOutputText(text: i18n(context, 'waveform_output_image_error'),),
    ]);
  }

  Widget _buildOutputWaveFormMorse() {
    return Column(children: [
      (_soundfileImagePolygon.isNotEmpty)
          ? GCWExpandableTextDivider(
        text: i18n(context, 'waveform_output_morsecode'),
        expanded: false,
        suppressTopSpace: false,
        child: Column(
          children: <Widget>[
            GCWTwoOptionsSwitch(
                leftValue: i18n(context, 'waveform_output_image_normal'),
                rightValue: i18n(context, 'waveform_output_image_inverted'),
                value: _currentInvert,
                onChanged: (value) {
                  setState(() {
                    _currentInvert = value;
                    _decodeMorseData();
                    });
                }),
            GCWIntegerSpinner(
              title: i18n(context, 'waveform_settings_morse_tolerance'),
              min: 0,
              max: 24,
              value: _currentTolerance,
              onChanged: (value) {
                setState(() {
                  _currentTolerance = value;
                  _decodeMorseData();
                });
              },
            ),
            GCWOutputText(text: _decodedMorse!.morseCode),
            GCWOutputText(text: _decodedMorse!.text),
          ],
        ),
      )
          : GCWOutputText(text: i18n(context, 'waveform_output_image_error'),),
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
        content.add([i18n(context, 'waveform_output_' + element.Meaning), element.Bytes, element.Value]);
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

  void _decodeMorseData(){
    if (_currentInvert == GCWSwitchPosition.right) {
      _decodedMorse = decodeMorseCode(
        List.filled(_soundfileMorsecode.length, 1),
        _invertMorseCode(_soundfileMorsecode),
        tolerance: 1.2 + (_currentTolerance - 12) / 10,
      );    } else {
      _decodedMorse = decodeMorseCode(
        List.filled(_soundfileMorsecode.length, 1),
        _soundfileMorsecode,
        tolerance: 1.2 + (_currentTolerance - 12) / 10,
      );
    }
  }

  List<bool> _invertMorseCode(List<bool> soundfileMorsecode) {
    List<bool> result = [];
          soundfileMorsecode.forEach((element) {
        result.add(!element);
      });
     return result;
  }
}
