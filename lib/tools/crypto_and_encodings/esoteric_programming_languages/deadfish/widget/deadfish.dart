import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/deadfish/logic/deadfish.dart';

class Deadfish extends StatefulWidget {
  const Deadfish({Key? key}) : super(key: key);

  @override
  _DeadfishState createState() => _DeadfishState();
}

class _DeadfishState extends State<Deadfish> {
  late TextEditingController _inputInterpretController;
  late TextEditingController _inputGenerateController;

  var _currentInterpretInput = '';
  var _currentGenerateInput = '';

  var _currentMode = GCWSwitchPosition.left;
  var _currentDeadfishMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    _inputInterpretController = TextEditingController(text: _currentInterpretInput);
    _inputGenerateController = TextEditingController(text: _currentGenerateInput);
  }

  @override
  void dispose() {
    _inputInterpretController.dispose();
    _inputGenerateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          notitle: true,
          style: GCWSwitchstyle.button,
          value: _currentMode,
          leftValue: i18n(context, 'common_programming_mode_interpret'),
          rightValue: i18n(context, 'common_programming_mode_generate'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
          controller: _inputInterpretController,
          onChanged: (text) {
            setState(() {
              _currentInterpretInput = text;
            });
          },
        )
            : GCWTextField(
          controller: _inputGenerateController,
          onChanged: (text) {
            setState(() {
              _currentGenerateInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'deadfish_mode_left'),
          rightValue: i18n(context, 'deadfish_mode_right'),
          value: _currentDeadfishMode,
          onChanged: (value) {
            setState(() {
              _currentDeadfishMode = value;
            });
          },
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  String _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      var encoded = encodeDeadfish(_currentGenerateInput);
      if (_currentDeadfishMode == GCWSwitchPosition.right) {
        encoded = encoded.replaceAll('i', 'x').replaceAll('s', 'k').replaceAll('o', 'c');
      }

      return encoded;
    } else {
      var decodeable = _currentInterpretInput;
      if (_currentDeadfishMode == GCWSwitchPosition.right) {
        decodeable = decodeable
            .toLowerCase()
            .replaceAll(RegExp(r'[iso]'), '')
            .replaceAll('x', 'i')
            .replaceAll('k', 's')
            .replaceAll('c', 'o');
      }

      return decodeDeadfish(decodeable);
    }
  }
}
