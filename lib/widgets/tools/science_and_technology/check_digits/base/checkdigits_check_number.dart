import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
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
  String _currentInputNStringID = '';
  String _currentInputNStringDateBirth = '';
  String _currentInputNStringDateValid = '';
  String _currentInputNStringCheckDigit = '';
  int _currentInputNInt = 0;
  int _currentInputNIntCheckDigit = 0;
  int _currentInputNIntDateBirth = 0;
  int _currentInputNIntDateValid = 0;

  TextEditingController currentInputController;
  TextEditingController currentInputControllerID;
  TextEditingController currentInputControllerDateBirth;
  TextEditingController currentInputControllerDateValid;
  TextEditingController currentInputControllerCheckDigit;

  @override
  void initState() {
    super.initState();
    currentInputController = TextEditingController(text: _currentInputNString);
    currentInputControllerID =
        TextEditingController(text: _currentInputNStringID);
    currentInputControllerDateBirth =
        TextEditingController(text: _currentInputNStringDateBirth);
    currentInputControllerDateValid =
        TextEditingController(text: _currentInputNStringDateValid);
    currentInputControllerCheckDigit =
        TextEditingController(text: _currentInputNStringCheckDigit);
  }

  @override
  void dispose() {
    currentInputController.dispose();
    currentInputControllerID.dispose();
    currentInputControllerDateBirth.dispose();
    currentInputControllerDateValid.dispose();
    currentInputControllerCheckDigit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (widget.mode == CheckDigitsMode.DEPERSID)
            ? Column(children: <Widget>[
                GCWTextField(
                  hintText: i18n(context, 'checkdigits_de_persid_serial'),
                  inputFormatters: [MASKINPUTFORMATTER_DEPERSID_SERIAL],
                  controller: currentInputControllerID,
                  onChanged: (text) {
                    setState(() {
                      _currentInputNStringID = text;
                    });
                  },
                ),
                GCWIntegerSpinner(
                  title: i18n(context, 'checkdigits_de_persid_date_birth'),
                  min: 0,
                  max: 9999999,
                  value: _currentInputNIntDateBirth,
                  onChanged: (value) {
                    setState(() {
                      _currentInputNIntDateBirth = value;
                      _currentInputNStringDateBirth =
                          _currentInputNIntDateBirth.toString();
                    });
                  },
                ),
                GCWIntegerSpinner(
                  title: i18n(context, 'checkdigits_de_persid_date_valid'),
                  min: 0,
                  max: 9999999,
                  value: _currentInputNIntDateValid,
                  onChanged: (value) {
                    setState(() {
                      _currentInputNIntDateValid = value;
                      _currentInputNStringDateValid =
                          _currentInputNIntDateValid.toString();
                    });
                  },
                ),
                GCWIntegerSpinner(
                  title: i18n(context, 'checkdigits_de_persid_checkdigit'),
                  min: 0,
                  max: 9,
                  value: _currentInputNIntCheckDigit,
                  onChanged: (value) {
                    setState(() {
                      _currentInputNIntCheckDigit = value;
                      _currentInputNStringCheckDigit =
                          _currentInputNIntCheckDigit.toString();
                    });
                  },
                )
              ])
            : Container(),
        (widget.mode == CheckDigitsMode.EAN ||
                widget.mode == CheckDigitsMode.DETAXID ||
                widget.mode == CheckDigitsMode.IMEI)
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
            : Container(),
        (widget.mode == CheckDigitsMode.ISBN ||
                widget.mode == CheckDigitsMode.EURO)
            ? GCWTextField(
                // CheckDigitsMode.ISBN, CheckDigitsMode.IBAN, CheckDigitsMode.EURO, CheckDigitsMode.DEPERSID
                controller: currentInputController,
                inputFormatters: [INPUTFORMATTERS[widget.mode]],
                hintText: INPUTFORMATTERS_HINT[widget.mode],
                onChanged: (text) {
                  setState(() {
                    _currentInputNString = text;
                  });
                },
              )
            : Container(),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (widget.mode == CheckDigitsMode.DEPERSID)
      _currentInputNString = _currentInputNStringID + _currentInputNStringDateBirth  + _currentInputNStringDateValid + _currentInputNStringCheckDigit;

    CheckDigitOutput checked =
        checkDigitsCheckNumber(widget.mode, _currentInputNString);

    if (checked.correct) {
      return GCWDefaultOutput(
        child: i18n(context, 'checkdigits_checknumber_correct_yes'),
      );
    }

    if (checked.correctDigit.startsWith('check'))
      return GCWDefaultOutput(
        child: i18n(context, checked.correctDigit),
      );

    Map output = new Map();
    for (int i = 0; i < checked.correctNumbers.length; i++)
      output[(i + 1).toString() + '.'] = checked.correctNumbers[i];

    String title =
        i18n(context, 'checkdigits_checknumber_correct_assume_check');
    if (output.length == 0)
      title = title +
          '\n' +
          i18n(context, 'checkdigits_checknumber_correct_no_number');
    else
      title = title +
          '\n' +
          i18n(context, 'checkdigits_checknumber_correct_number');
    return Column(children: [
      GCWDefaultOutput(
        child: i18n(context, 'checkdigits_checknumber_correct_no'),
        suppressCopyButton: true,
      ),
      GCWOutput(
        title: i18n(context, 'checkdigits_checknumber_correct_assume_number') +
            '\n' +
            i18n(context, 'checkdigits_checknumber_correct_check'),
        child: checked.correctDigit,
      ),
      GCWOutput(
          title: title,
          child: Column(
            children: columnedMultiLineOutput(
                context,
                output.entries.map((entry) {
                  return [entry.key, entry.value];
                }).toList(),
                flexValues: [1, 5]),
          ))
    ]);
  }
}
