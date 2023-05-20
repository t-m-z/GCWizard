import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/chicken_language/logic/chicken_language.dart';

class ChickenLanguage extends StatefulWidget {
  const ChickenLanguage({Key? key}) : super(key: key);

  @override
 _ChickenLanguageState createState() => _ChickenLanguageState();
}

class _ChickenLanguageState extends State<ChickenLanguage> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(onChanged: (text) {
          setState(() {
            _currentInput = text;
          });
        }),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  String _buildOutput() {
    var out = _currentMode == GCWSwitchPosition.left
        ? encryptChickenLanguage(_currentInput)
        : decryptChickenLanguage(_currentInput);

    return out;
  }
}
