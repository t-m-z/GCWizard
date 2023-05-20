import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/z3/logic/z3.dart';

class Z3 extends StatefulWidget {
  const Z3({Key? key}) : super(key: key);

  @override
  Z3State createState() => Z3State();
}

class Z3State extends State<Z3> {
  late TextEditingController _programmController;
  late TextEditingController _inputController;

  var _currentProgram = '';
  var _currentInput = '';

  bool _currentShowDebug = false;

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
          // interpret Beatnik-programm
          children: <Widget>[
            GCWTextField(
              controller: _programmController,
              hintText: i18n(context, 'z3_hint_code'),
              onChanged: (text) {
                setState(() {
                  _currentProgram = text;
                });
              },
            ),
            GCWTextField(
              controller: _inputController,
              hintText: i18n(context, 'z3_hint_input'),
              onChanged: (text) {
                setState(() {
                  _currentInput = text;
                });
              },
            ),
          ],
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    Z3Output _output = Z3Output([''], [''], ['']);
    String _outputData = '';

    _output = interpretZ3(_currentProgram, _currentInput);

    _outputData = buildOutputText(_output.output);

    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: GCWOutputText(
            text: _outputData,
          ),
        ),
        Column(
          children: [
            GCWOnOffSwitch(
              title: i18n(context, 'z3_debug'),
              value: _currentShowDebug,
              onChanged: (value) {
                setState(() {
                  _currentShowDebug = value;
                });
              },
            ),
            _currentShowDebug == true
                ? Column(children: <Widget>[
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
                              child: Column(
                                children: <Widget>[
                                  GCWTextDivider(text: i18n(context, 'z3_hint_code_assembler')),
                                  GCWOutputText(
                                    text: _output.assembler.join('\n'),
                                    isMonotype: true,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
                              child: Column(
                                children: <Widget>[
                                  GCWTextDivider(text: i18n(context, 'z3_hint_code_mnemonic')),
                                  GCWOutputText(
                                    text: _output.mnemonic.join('\n'),
                                    isMonotype: true,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ]),
                  ])
                : Container(),
          ],
        )
      ],
    );
  }

  String buildOutputText(List<String> outputList) {
    String output = '';
    for (String element in outputList) {
      if (element.startsWith('z3_runtime')) {
        output = output + '\n' + i18n(context, element);
      } else {
        output = output + ' ' + element;
      }
    }
    return output;
  }
}
