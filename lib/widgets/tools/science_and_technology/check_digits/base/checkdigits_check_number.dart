import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CheckDigitsCheckNumber extends StatefulWidget {
  final CheckDigitsMode mode;
  final int maxIndex;
  const CheckDigitsCheckNumber({Key key, this.mode, this.maxIndex})
      : super(key: key);

  @override
  CheckDigitsCheckNumberState createState() => CheckDigitsCheckNumberState();
}

class CheckDigitsCheckNumberState extends State<CheckDigitsCheckNumber> {
  String _currentInputNString = '';
  int _currentInputNInt = 0;
  TextEditingController currentInputController;

  @override
  void initState() {
    super.initState();
    currentInputController = TextEditingController(text: _currentInputNString);
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
        (widget.mode == CheckDigitsMode.EAN || widget.mode == CheckDigitsMode.DETAXID || widget.mode == CheckDigitsMode.IMEI || widget.mode == CheckDigitsMode.ISBN)
            ? GCWIntegerSpinner(
                min: 0,
                max: maxInt[widget.mode],
                value: _currentInputNInt,
                onChanged: (value) {
                  setState(() {
                    _currentInputNInt = value;
                    _currentInputNString = _currentInputNInt.toString();
                  });
                },
              )
            : GCWTextField(
                controller: currentInputController,
                onChanged: (text) {
                  setState(() {
                    _currentInputNString = text;
                  });
                },
              ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    switch (widget.mode) {
      case CheckDigitsMode.DETAXID:
      case CheckDigitsMode.IMEI:
      case CheckDigitsMode.ISBN:
      case CheckDigitsMode.EAN:
        CheckDigitOutput checked =
            checkDigitsCheckNumber(widget.mode, _currentInputNString);

        if (checked.correct) {
          return GCWDefaultOutput(
            child: i18n(context, 'checkdigits_checknumber_correct_yes'),
          );
        }

        Map output = new Map();
        for (int i = 0; i < checked.correctNumbers.length; i++)
          output[(i + 1).toString() + '.'] = checked.correctNumbers[i];

        return Column(children: [
          GCWDefaultOutput(
            child: i18n(context, 'checkdigits_checknumber_correct_no'),
            suppressCopyButton: true,
          ),
          GCWOutput(
            title:
                i18n(context, 'checkdigits_checknumber_correct_assume_number') +
                    '\n' +
                    i18n(context, 'checkdigits_checknumber_correct_number'),
            child: checked.correctDigit,
          ),
          GCWOutput(
              title: i18n(
                      context, 'checkdigits_checknumber_correct_assume_check') +
                  '\n' +
                  i18n(context, 'checkdigits_checknumber_correct_number'),
              child: Column(
                  children: columnedMultiLineOutput(
                context,
                output.entries.map((entry) {
                  return [entry.key, entry.value];
                }).toList(),
              )))
        ]);
        break;
      default:
        return Container();
    }
  }
}
