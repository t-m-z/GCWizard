import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_letter_value_relation.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cipher_wheel/logic/cipher_wheel.dart';

class CipherWheel extends StatefulWidget {
  const CipherWheel({Key? key}) : super(key: key);

  @override
  _CipherWheelState createState() => _CipherWheelState();
}

class _CipherWheelState extends State<CipherWheel> {
  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;

  var _currentEncryptInput = '';
  var _currentDecryptInput = '';
  int _currentKey = 1;
  String _output = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputEncryptController = TextEditingController(text: _currentEncryptInput);
    _inputDecryptController = TextEditingController(text: _currentDecryptInput);
  }

  @override
  void dispose() {
    _inputEncryptController.dispose();
    _inputDecryptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          style: GCWSwitchstyle.button,
          notitle: true,
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
          controller: _inputEncryptController,
          onChanged: (text) {
            setState(() {
              _currentEncryptInput = text;
            });
          },
        )
            : GCWTextField(
          controller: _inputDecryptController,
          onChanged: (text) {
            setState(() {
              _currentDecryptInput = text;
            });
          },
        ),
        GCWLetterValueRelation(
          onChanged: (value) {
            setState(() {
              _currentKey = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(child: _output)
      ],
    );
  }

  void _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      var input = _currentDecryptInput
          .split(RegExp(r'\D+'))
          .where((number) => number.isNotEmpty)
          .map((number) => int.tryParse(number)!)
          .toList();
      _output = decryptCipherWheel(input, _currentKey);
    } else {
      _output = encryptCipherWheel(_currentEncryptInput, _currentKey).join(' ');
    }
  }
}
