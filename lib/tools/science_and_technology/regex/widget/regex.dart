import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_code_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/regex/logic/regex.dart';

class RegEx extends StatefulWidget {
  const RegEx({super.key});

  @override
  _RegExState createState() => _RegExState();
}

class _RegExState extends State<RegEx> {
  late TextEditingController _inputController;
  late TextEditingController _patternController;
  late TextEditingController _codeControllerHighlighted;

  String _currentInput = '';
  String _currentPattern = '';
  List<List<String>> _calculatedPattern = [];

  bool _currentMultiLine = true;
  bool _currentCaseSensitive = true;
  bool _currentUnicode = false;
  bool _currentDotAll = false;

  // If your code enables multiLine, then ^ and $ will match the beginning and end of a line, as well as matching beginning and end of the input, respectively.
  // If your code disables caseSensitive, then Dart ignores the case of letters when matching. For example, with caseSensitive disable, the regexp pattern a matches both a and A.
  // If your code enables unicode, then Dart treats the pattern as a Unicode pattern per the ECMAScript standard.
  // If your code enables dotAll, then the . pattern will match all characters, including line terminators.

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _patternController = TextEditingController(text: _currentPattern);
    _codeControllerHighlighted = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _inputController.dispose();
    _patternController.dispose();
    _codeControllerHighlighted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _codeControllerHighlighted.text = _currentInput;

    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'regex_pattern'),
          controller: _patternController,
          onChanged: (text) {
            setState(() {
              _currentPattern = text;
            });
          },
        ),
        GCWExpandableTextDivider(
          text: i18n(context, 'common_options'),
          expanded: false,
          suppressTopSpace: false,
          child: Column(
            children: [
              GCWOnOffSwitch(
                title: i18n(context, 'regex_option_multiline'),
                value: _currentMultiLine,
                onChanged: (value) {
                  setState(() {
                    _currentMultiLine = value;
                  });
                },
              ),
              GCWOnOffSwitch(
                title: i18n(context, 'regex_option_casesensitive'),
                value: _currentCaseSensitive,
                onChanged: (value) {
                  setState(() {
                    _currentCaseSensitive = value;
                  });
                },
              ),
              GCWOnOffSwitch(
                title: i18n(context, 'regex_option_unicode'),
                value: _currentUnicode,
                onChanged: (value) {
                  setState(() {
                    _currentUnicode = value;
                  });
                },
              ),
              GCWOnOffSwitch(
                title: i18n(context, 'regex_option_dotall'),
                value: _currentDotAll,
                onChanged: (value) {
                  setState(() {
                    _currentDotAll = value;
                  });
                },
              ),
            ],
          ),
        ),
        _buildOutput(),
      ],
    );
  }

  Widget _buildOutput() {
    try {
      _calculatedPattern = evaluateRegExPattern(
        _currentInput,
        _currentPattern,
        multiLine: _currentMultiLine,
        uniCode: _currentUnicode,
        dotAll: _currentDotAll,
        caseSensitive: _currentCaseSensitive
      );
      return Column(children: [
        GCWDefaultOutput(
            child: Column(
          children: [
            GCWCodeTextField(
              wrap: true,
              controller: _codeControllerHighlighted,
              patternMap: _higlightMap(),
              lineNumbers: false,
            ),
            GCWOutput(
              title: i18n(context, 'common_result'),
              child: _regexToString(_calculatedPattern),
            ),
            GCWExpandableTextDivider(
                suppressTopSpace: false,
                expanded: false,
                text: i18n(context, 'common_details'),
                child: GCWColumnedMultilineOutput(
                  data: _calculatedPattern,
                ))
          ],
        )),
      ]);
    } on FormatException catch (e) {
      return GCWDefaultOutput(
          child: GCWColumnedMultilineOutput(
        data: [
          [i18n(context, 'regex_error')],
          [e.message],
        ],
      ));
    } finally {}
  }

  String _regexToString(List<List<String>> input) {
    return input.expand((m) => m).join();
  }

  Map<String, TextStyle> _higlightMap() {
    Map<String, TextStyle> result = {};
    result[_currentPattern] = const TextStyle(color: Colors.red);
    return result;
  }
}
