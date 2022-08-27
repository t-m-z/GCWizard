import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/scrabble/scrabble.dart';
import 'package:gc_wizard/logic/tools/games/scrabble/scrabble_sets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Scrabble extends StatefulWidget {
  @override
  ScrabbleState createState() => ScrabbleState();
}

class ScrabbleState extends State<Scrabble> {
  var _controller;

  var _currentInput = '';
  var _currentValues = [];
  var _currentScrabbleVersion = scrabbleID_EN;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool _currentCrosstotalMode = true;

  String _output = '';

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
              _calculateOutput();
            });
          },
        ),
        GCWDropDownButton(
          value: _currentScrabbleVersion,
          onChanged: (value) {
            setState(() {
              _currentScrabbleVersion = value;
              _calculateOutput();
            });
          },
          items: scrabbleSets.entries.map((set) {
            return GCWDropDownMenuItem(
              value: set.key,
              child: i18n(context, set.value.i18nNameId),
            );
          }).toList(),
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'scrabble_mode'),
          leftValue: i18n(context, 'scrabble_mode_values'),
          rightValue: i18n(context, 'scrabble_mode_frequency'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _calculateOutput();
            });
          },
        ),
        GCWCrosstotalSwitch(
          onChanged: (value) {
            setState(() {
              _currentCrosstotalMode = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(child: _output),
        _currentCrosstotalMode
            ? GCWCrosstotalOutput(text: _currentInput, values: List<int>.from(_currentValues))
            : Container()
      ],
    );
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      _currentValues = scrabbleTextToLetterValues(_currentInput, _currentScrabbleVersion);
    } else {
      _currentValues = scrabbleTextToLetterFrequencies(_currentInput, _currentScrabbleVersion);
    }

    _output = intListToString(_currentValues, delimiter: ' ');
  }
}
