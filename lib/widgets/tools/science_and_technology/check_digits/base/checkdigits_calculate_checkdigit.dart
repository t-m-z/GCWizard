import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

class CheckDigitsCalculateCheckDigit extends StatefulWidget {
  final CheckDigitsMode mode;
  final int maxIndex;
  const CheckDigitsCalculateCheckDigit({Key key, this.mode, this.maxIndex}) : super(key: key);

  @override
  CheckDigitsCalculateCheckDigitState createState() => CheckDigitsCalculateCheckDigitState();
}

class CheckDigitsCalculateCheckDigitState extends State<CheckDigitsCalculateCheckDigit> {
  String _currentInputNString = '';
  int _currentInputNInt= 0;
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
                max: maxInt[widget.mode] ~/ 10,
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
      return GCWDefaultOutput(
        child: checkDigitsCalculateNumber(widget.mode, _currentInputNString),
      );
    }

}