import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/tools/science_and_technology/machine_identification_code/logic/machine_identification_code.dart';
import 'package:gc_wizard/tools/science_and_technology/machine_identification_code/widget/machine_identification_code_display.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';

class MachineIdentificationCode extends StatefulWidget {
  const MachineIdentificationCode({super.key});

  @override
  _MachineIdentificationCodeState createState() =>
      _MachineIdentificationCodeState();
}

class _MachineIdentificationCodeState extends State<MachineIdentificationCode> {

  var _currentDisplays = Segments.Empty();

  outputMIC _output = outputMIC(mic: [], parityColumn: [], parityRow: [], statusOK: true);

  List<String> _decodedMIC = [];

  bool _parityError = false;

  final List<String> _micColumn = [
    'machine_identification_code_column_01_rowparitybit',
    'common_minute',
    'common_unused',
    'common_unused',
    'common_hour',
    'common_day',
    'common_month',
    'common_year',
    'common_unused',
    'common_seperator',
    'common_serialnumber',
    'common_serialnumber',
    'common_serialnumber',
    'common_serialnumber',
    'common_unknown',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          _buildVisualDecryption(),
          _buildOutput()
        ]
    );
  }

  Widget _buildVisualDecryption() {
    var currentDisplay = buildSegmentMap(_currentDisplays);

    onChanged(Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;
          newSegments.add(key);
        });

        _currentDisplays.replaceLastSegment(newSegments);
      });
    }

    return Column(
      children: <Widget>[
        GCWPainterContainer(
          trailing: GCWIconButton(
            size: IconButtonSize.SMALL,
            icon: Icons.clear,
            onPressed: () {
              setState(() {
                _currentDisplays = Segments.Empty();
              });
            },
          ),
          child: MICSegmentDisplay(
            segments: currentDisplay,
            onChanged: onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GCWSubmitButton(
              onPressed: () {
                setState(() {
                  _output = decodeMIC(_currentDisplays.buildOutput());

                  if (_output.statusOK) {
                    _parityError = false;
                    _decodedMIC = _output.mic;
                  } else {
                    _decodedMIC = [];
                    _parityError = true;
                  }
                });
              },),
          ],
        ),
              ],
    );
  }

  Widget _buildOutput() {
    if (_parityError) {
      return GCWDefaultOutput(
        suppressCopyButton: true,
        child: i18n(context, 'machine_identification_code_error_parity') +
            ' ' +
            i18n(context, 'common_column') +
            ' ' +
            _output.parityColumn.toString() +
            ' ' +
            i18n(context, 'common_row') +
            ' ' +
            _output.parityRow.toString()
      );
    }
    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: _micDate(_decodedMIC),
        ),
        GCWExpandableTextDivider(
          suppressTopSpace: false,
          text: i18n(context, "common_details"),
          child: GCWColumnedMultilineOutput(
              flexValues: [1, 2, 2, 2], data: _micData(_decodedMIC)),
        )
      ],
    );
  }

  String _micDate(List<String> data) {
    if (data.isEmpty) {
      return '';
    }

    return '20' +
        data[7].padLeft(2, '0') +
        '-' +
        data[6].padLeft(2, '0') +
        '-' +
        data[5].padLeft(2, '0') +
        ' ' +
        data[4].padLeft(2, '0') +
        ':' +
        data[1].padLeft(2, '0') +
        ' ' +
        i18n(context, 'common_serialnumber') +
        ' ' +
        data[13].padLeft(2, '0') +
        data[12].padLeft(2, '0') +
        data[11].padLeft(2, '0') +
        data[10].padLeft(2, '0');
  }

  List<List<String>> _micData(List<String> data) {
    List<List<String>> result = [];
    int i = 1;
    for (var element in data) {
      result.add([
        i.toString(),
        convertBase(element, 10, 2).padLeft(8, '0'),
        i18n(context, _micColumn[i - 1]),
        element,
      ]);
      i++;
    }
    return result;
  }

}
