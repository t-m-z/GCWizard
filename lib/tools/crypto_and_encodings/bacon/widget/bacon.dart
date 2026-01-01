import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/logic/bacon.dart';

class Bacon extends StatefulWidget {
  const Bacon({super.key});

  @override
  _BaconState createState() => _BaconState();
}

class _BaconState extends State<Bacon> {
  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;

  var _currentEncryptInput = '';
  var _currentDecryptInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  GCWSwitchPosition _binaryMode = GCWSwitchPosition.left;
  GCWSwitchPosition _typeMode = GCWSwitchPosition.left;
  bool _inversMode = false;

  String _output = '';

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
        GCWTwoOptionsSwitch(
          title: i18n(context, 'common_type'),
          leftValue: i18n(context, 'common_original'),
          rightValue: i18n(context, 'bacon_type_full'),
          value: _typeMode,
          onChanged: (value) {
            setState(() {
              _typeMode = value;
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
          title: _binaryMode == GCWSwitchPosition.left ? 'AAAAB → BBBBA' : '00001 → 11110',
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
    var type = _typeMode == GCWSwitchPosition.left ? BaconType.ORIGINAL : BaconType.FULL;

    if (_currentMode == GCWSwitchPosition.left) {
      _output =
          encodeBacon(_currentEncryptInput, inverse: _inversMode, binary: _binaryMode == GCWSwitchPosition.right, type: type);
    } else {
      _output =
          decodeBacon(_currentDecryptInput, inverse: _inversMode, binary: _binaryMode == GCWSwitchPosition.right, type: type);
    }

    return GCWDefaultOutput(child: _output);
  }
}