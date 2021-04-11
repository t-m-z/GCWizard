import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';

class CheckDigitsCalculateCheckDigit extends StatefulWidget {
  final CheckDigitsMode mode;
  final int maxIndex;
  const CheckDigitsCalculateCheckDigit({Key key, this.mode, this.maxIndex}) : super(key: key);

  @override
  CheckDigitsCalculateCheckDigitState createState() => CheckDigitsCalculateCheckDigitState();
}

class CheckDigitsCalculateCheckDigitState extends State<CheckDigitsCalculateCheckDigit> {
  String _currentInputN = '';
  TextEditingController currentInputController;

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
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
      return GCWDefaultOutput(
        child: checkDigitsCalculateNumber(widget.mode, _currentInputN),
      );
    }

}