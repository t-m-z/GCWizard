import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';

import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/gcw_soundplayer.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
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
  Uint8List _soundfilePNGImage = Uint8List.fromList([]);
  SoundfileData _soundfileData = SoundfileData(
      PCMformat: 0,
      bits: 0,
      channels: 0,
      sampleRate: 0,
      structure: [],
      duration: 0.0,
      amplitudesData: Uint8List.fromList([]));

  String _decodedMorseCode = '';
  String _decodedMorseText = '';
  String _currentError = '';

  bool _parseError = false;
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
            _analyseWaveFileAsync();
            _soundfileData = getSoundfileData(_bytes);
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
              imageData: GCWImageViewData(GCWFile(bytes: _soundfilePNGImage)),
              suppressOpenInTool: const {GCWImageViewOpenInTools.METADATA},
            )
          : GCWOutputText(
              text: _parseError ? i18n(context, _currentError) : i18n(context, 'waveform_output_image_error'),
            ),
    ]);
  }

  Widget _buildOutputWaveFormMorse() {
    return Column(children: [
      (_soundfilePNGImage.isNotEmpty)
          ? GCWExpandableTextDivider(
              text: i18n(context, 'waveform_output_morsecode'),
              expanded: false,
              suppressTopSpace: false,
              child: Column(
                children: <Widget>[
                  GCWOutputText(text: _decodedMorseCode),
                  GCWOutputText(text: _decodedMorseText),
                ],
              ),
            )
          : GCWOutputText(
        text: _parseError ? i18n(context, _currentError) : i18n(context, 'waveform_output_image_error'),
            ),
    ]);
  }

  Widget _buildOutputWaveFormStructure() {
    List<Widget> output = _buildOutputSoundfileStructure(_bytes);
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

  List<Widget> _buildOutputSoundfileStructure(Uint8List bytes) {
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

  void _analyseWaveFileAsync() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: GCW_ASYNC_EXECUTER_INDICATOR_HEIGHT,
            width: GCW_ASYNC_EXECUTER_INDICATOR_WIDTH,
            child: GCWAsyncExecuter<WaveformAndMorseResult>(
              isolatedFunction: getWaveFileAsync,
              parameter: _buildWaveFileJobData,
              onReady: (data) => _showWaveFileOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildWaveFileJobData() async {
    return GCWAsyncExecuterParameters(WaveFileJobData(
        jobDataBytes: _bytes,
        jobDataHeight: 400,
    ));
  }

  void _showWaveFileOutput(WaveformAndMorseResult output) {
    String toastMessage = '';
    int toastDuration = 3;

    if (output.status == PARSE_STATUS.ERROR) {
      toastMessage = i18n(context, output.error);
      toastDuration = 5;
      _spectrumCreated = false;
      _parseError = true;
    } else {
      toastMessage = i18n(context, 'waveform_output_success');
      toastDuration = 5;
      _soundfilePNGImage = output.pngBytes;
      _decodedMorseCode = output.morse;
      _decodedMorseText = output.text;
      _spectrumCreated = true;
      _parseError = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      showSnackBar(toastMessage, duration: toastDuration, context);
    });
  }

}


