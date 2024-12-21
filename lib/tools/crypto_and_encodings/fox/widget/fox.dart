import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/fox/logic/fox.dart';

class Fox extends StatefulWidget {
  const Fox({Key? key}) : super(key: key);

  @override
  _FoxState createState() => _FoxState();
}

class _FoxState extends State<Fox> {

  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;

  String _currentEncryptInput = '';
  String _currentDecryptInput = '';

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
        GCWDefaultOutput(
          child: _buildOutput(),
        )
      ],
    );
  }

  String _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeFox(_currentEncryptInput);
    } else {
      return decodeFox(_currentDecryptInput);
    }
  }
}
