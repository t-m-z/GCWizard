import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/logic/randomizer.dart';

class RandomizerText extends StatefulWidget {
  const RandomizerText({super.key});

  @override
  _RandomizerTextState createState() => _RandomizerTextState();
}

class _RandomizerTextState extends State<RandomizerText> {
  late TextEditingController _controller;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool removeWhitespace = true;

  String _currentInput = '';

  Widget _currentOutput = const GCWDefaultOutput();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'randomizer_text_mode_allchars'),
          rightValue: i18n(context, 'randomizer_text_mode_lines'),
          title: i18n(context, 'randomizer_text_mode'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          }
        ),
        _currentMode == GCWSwitchPosition.left
          ? GCWOnOffSwitch(
              title: i18n(context, 'randomizer_text_removewhitespace'),
              value: removeWhitespace,
              onChanged: (value) {
                setState(() {
                  removeWhitespace = value;
                });
              }
            )
          : Container(),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        _currentOutput
      ],
    );
  }

  void _calculateOutput() {
    var _output = '';
    if (_currentMode == GCWSwitchPosition.left) {
      _output = shuffleString(_currentInput, removeWhitespace);
    } else {
      _output = shuffleLines(_currentInput);
    }

    _currentOutput = GCWDefaultOutput(
      child: _output,
    );
  }
}
