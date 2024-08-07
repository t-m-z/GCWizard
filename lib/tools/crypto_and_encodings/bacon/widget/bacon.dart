import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/logic/bacon.dart';

class Bacon extends StatefulWidget {
  const Bacon({Key? key}) : super(key: key);

  @override
  _BaconState createState() => _BaconState();
}

class _BaconState extends State<Bacon> {
  late TextEditingController _controller;

  var _currentInput = '';
  GCWSwitchPosition _currentIJUVVersion = GCWSwitchPosition.left;
  GCWSwitchPosition _currentEncryptDecryptMode = GCWSwitchPosition.right;
  GCWSwitchPosition _binaryMode = GCWSwitchPosition.left;
  bool _inversMode = false;
  bool _analyzeText = false;

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
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentEncryptDecryptMode,
          onChanged: (value) {
            setState(() {
              _currentEncryptDecryptMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentIJUVVersion,
          leftValue: 'I=J, U=V',
          rightValue: 'I, J, U, V',
          onChanged: (value) {
            setState(() {
              _currentIJUVVersion = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'bacon_coding'),
          leftValue: 'AB',
          rightValue: '01',
          value: _binaryMode,
          onChanged: (value) {
            setState(() {
              _binaryMode = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: _binaryMode == GCWSwitchPosition.left
              ? 'AAAAB → BBBBA'
              : '00001 → 11110',
          value: _inversMode,
          onChanged: (value) {
            setState(() {
              _inversMode = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    var type = _currentIJUVVersion == GCWSwitchPosition.left
        ? BaconType.ORIGINAL
        : BaconType.FULL;
    Widget outputWidget;

    if (_currentEncryptDecryptMode == GCWSwitchPosition.left) {
      _output = encodeBacon(_currentInput,
          inverse: _inversMode,
          binary: _binaryMode == GCWSwitchPosition.right,
          type: type);
      outputWidget = GCWDefaultOutput(child: _output);
    } else {
      _analyzeText = _testText(_currentInput);

      String _inputWordwiseUpperLower = analyzeBaconCodeWordwiseUpperLowerCase(_currentInput);
      String _inputWordwiseAlphabet = analyzeBaconCodeWordwiseAlphabet(_currentInput);
      String _inputLetterwiseUpperLower = analyzeBaconCodeLetterwiseUpperLowerCase(_currentInput);
      String _inputLetterwiseAlphabet = analyzeBaconCodeLetterwiseAlphabet(_currentInput);

      if (_analyzeText) {
        outputWidget = Column(
          children: [
            GCWTextDivider(
              text: i18n(context, 'bacon_analyze_wordwise'),
              suppressBottomSpace: true,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                      child: Column(children: [
                        GCWTextDivider(
                          text: i18n(context, 'bacon_analyze_casesensitive'),
                        ),
                        GCWOutput(child: _inputWordwiseUpperLower),
                        GCWOutput(
                          child: decodeBacon(_inputWordwiseUpperLower,
                              inverse: _inversMode, binary: false, type: type),
                        ),
                      ]),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                    child: Column(
                      children: [
                        GCWTextDivider(
                          text: i18n(context, 'bacon_analyze_alphabet'),
                        ),
                        GCWOutput(child: _inputWordwiseAlphabet),
                        GCWOutput(
                          child: decodeBacon(_inputWordwiseAlphabet,
                              inverse: _inversMode, binary: false, type: type),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GCWTextDivider(
              text: i18n(context, 'bacon_analyze_letterwise'),
              suppressBottomSpace: true,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                      child: Column(children: [
                        GCWTextDivider(
                          text: i18n(context, 'bacon_analyze_casesensitive'),
                        ),
                        GCWOutput(child: _inputLetterwiseUpperLower),
                        GCWOutput(
                          child: decodeBacon(_inputLetterwiseUpperLower,
                              inverse: _inversMode, binary: false, type: type),
                        ),
                      ]),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                    child: Column(
                      children: [
                        GCWTextDivider(
                          text: i18n(context, 'bacon_analyze_alphabet'),
                        ),
                        GCWOutput(child: _inputLetterwiseAlphabet),
                        GCWOutput(
                          child: decodeBacon(_inputLetterwiseAlphabet,
                              inverse: _inversMode, binary: false, type: type),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        _output = decodeBacon(_currentInput,
            inverse: _inversMode,
            binary: _binaryMode == GCWSwitchPosition.right,
            type: type);
        outputWidget = GCWDefaultOutput(child: _output);
      }
    }

    return outputWidget;
  }

  bool _testText(String code) {
    if ((code.toUpperCase().replaceAll('A', '').replaceAll('B', '') == '') ||
        (code.toUpperCase().replaceAll('0', '').replaceAll('1', '') == '')) {
      return false;
    } else {
      return true;
    }
  }
}
