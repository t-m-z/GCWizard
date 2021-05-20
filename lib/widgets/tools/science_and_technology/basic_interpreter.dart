import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_interpreter.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';

class BasicInterpreter extends StatefulWidget {
  @override
  BasicInterpreterState createState() => BasicInterpreterState();
}

class BasicInterpreterState extends State<BasicInterpreter> {
  var _programmController;
  var _inputController;

  var _currentProgram = '';
  var _currentInput = '';
  String _currentOutput = '';

  @override
  void initState() {
    super.initState();
    _programmController = TextEditingController(text: _currentProgram);
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _programmController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         Column(
          children: <Widget>[
            GCWTextField(
              controller: _programmController,
              hintText: i18n(context, 'basic_interpreter_hint_program'),
              onChanged: (text) {
                setState(() {
                  _currentProgram = text;
                });
              },
            ),
            GCWTextField(
              controller: _inputController,
              hintText: i18n(context, 'basic_interpreter_hint_input'),
              onChanged: (text) {
                setState(() {
                  _currentInput = text;
                });
              },
            ),
          ],
        ),
        GCWButton(
          text: i18n(context, 'basic_interpreter_interpret'),
          onPressed: () {
            setState(() {
              _currentOutput = buildOutputText(
                  interpretBasic(_currentProgram.toUpperCase().replaceAll('  ', ' '), _currentInput)).trim();
            });
          },
        ),
        GCWDefaultOutput(
          child: GCWOutputText(
            text: _currentOutput,
            isMonotype: true,
          ),
        ),
      ],
    );
  }



  String buildOutputText(BASICOutput output) {
    if (output.Error != '')
      return i18n(context, output.Error);
    else
      return output.STDOUT;
  }

}
