import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CheckDigitsCalculateMissingDigits extends StatefulWidget {
  final CheckDigitsMode mode;
  final int maxIndex;
  const CheckDigitsCalculateMissingDigits({Key key, this.mode, this.maxIndex}) : super(key: key);

  @override
  CheckDigitsCalculateMissingDigitsState createState() => CheckDigitsCalculateMissingDigitsState();
}

class CheckDigitsCalculateMissingDigitsState extends State<CheckDigitsCalculateMissingDigits> {
  String _currentInputN = '';
  TextEditingController currentInputController;
  List<String> _numbers = new List<String>();

  @override
  void initState() {
    super.initState();
    currentInputController = TextEditingController(text: _currentInputN);
  }

  @override
  void dispose() {
    currentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: currentInputController,
          onChanged: (text) {
            setState(() {
              _currentInputN = text;
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _numbers = checkDigitsCalculateDigits(widget.mode, _currentInputN);
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    if (_numbers[0].startsWith('checkdigits_invalid_length'))
      return  GCWDefaultOutput(
        child: i18n(context, _numbers[0]),
      );

    if (_numbers.length == 1)
      return GCWDefaultOutput(
        child:  _numbers.join(''),
      );

    Map output = new Map();
    for (int i = 0; i < _numbers.length; i++)
      output[(i + 1).toString()+'.'] = _numbers[i];

    if (widget.mode == CheckDigitsMode.IBAN && _numbers.length > 1)
      return Column(
        children: <Widget>[
          GCWDefaultOutput(
              child: Column(
                  children: columnedMultiLineOutput(
                      context,
                      output.entries.map((entry) {
                        return [entry.key, entry.value];
                      }).toList(),
                      flexValues: [1,4]
                  )
              )
          ),
          GCWOutput(
            title: i18n(context, 'checkdigits_hint'),
            suppressCopyButton: true,
            child: i18n(context, 'checkdigits_iban_hint'),
          )
        ],
      );
    else
      return GCWDefaultOutput(
        child: Column(
            children: columnedMultiLineOutput(
              context,
              output.entries.map((entry) {
                return [entry.key, entry.value];
              }).toList(),
              flexValues: [1,4]
            )
        )
    );
  }
}