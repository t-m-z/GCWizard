import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceContainsDigits extends StatefulWidget {
  final NumberSequencesMode mode;
  final int maxIndex;
  const NumberSequenceContainsDigits({Key key, this.mode, this.maxIndex}) : super(key: key);

  @override
  NumberSequenceContainsDigitsState createState() => NumberSequenceContainsDigitsState();
}

class NumberSequenceContainsDigitsState extends State<NumberSequenceContainsDigits> {
  int currentInputN = 0;

  Widget _currentOutput;

  @override
  void initState() {
    super.initState();

    _currentOutput = GCWDefaultOutput();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          value: currentInputN,
          min: 0,
          onChanged: (value) {
            setState(() {
              currentInputN = value;
            });
          },
        ),
        GCWSubmitButton(onPressed: () {
          setState(() {
            _buildOutput();
          });
        }),
        _currentOutput
      ],
    );
  }

  _buildOutput() {
    List<List<String>> columnData = [];
    PositionOfSequenceOutput detailedOutput;

    var flexData;

    detailedOutput = getFirstPositionOfSequence(widget.mode, currentInputN.toString(), widget.maxIndex);

    columnData.add([
      i18n(context, 'numbersequence_output_col_1'),
      i18n(context, 'numbersequence_output_col_2'),
      i18n(context, 'numbersequence_output_col_3')
    ]);
    columnData.add(
        [detailedOutput.number, detailedOutput.positionSequence.toString(), detailedOutput.positionDigits.toString()]);

    flexData = [4, 2, 1];

    _currentOutput = GCWDefaultOutput(
        child: Column(
            children:
                columnedMultiLineOutput(context, columnData, flexValues: flexData, copyColumn: 0, hasHeader: true)));
  }
}
