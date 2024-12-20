import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_multi_radiobuttons.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_single_radiobuttons.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_two_radiobuttons.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

class A_TestWidgets extends StatefulWidget {
  const A_TestWidgets({Key? key}) : super(key: key);

  @override
  A_TestWidgetsState createState() => A_TestWidgetsState();
}

class A_TestWidgetsState extends State<A_TestWidgets> {
  late TextEditingController _decodeController;
  late TextEditingController _encodeController;

  String _currentEncodeInput = '';
  String _currentDecodeInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  int _currentButton = 1;
  int _currentButtons = 0;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentEncodeInput);
    _encodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _encodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                    _calculateOutput();
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                    _calculateOutput();
                  });
                },
              ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _calculateOutput();
            });
          },
        ),
        GCWTwoRadioButtons(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _calculateOutput();
            });
          },
        ),
        /*GCWRadioButtons(
            labels: ['h', 'v', 'f/r'],
            position: _currentButton,
            onChanged: (value) {
              setState(() {
                _currentButton = value;
                _calculateOutput();
              });
            })            ,
         */
        GCWSingleRadioButtons(
            labels: ['0', '10','200', '3000'],
            position: _currentButton,
            onChanged: (value) {
              setState(() {
                _currentButton = value;
                _calculateOutput();
              });
            }),
        GCWMultiRadioButtons(
            labels: ['1', '2','4', '8', '16', '32',],
            position: _currentButtons,
            onChanged: (value) {
              setState(() {
                _currentButtons = value;
                _calculateOutput();
              });
            }),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  String _calculateOutput() {
    return _currentButton.toString() + '\n' + _currentButtons.toString();
  }
}
