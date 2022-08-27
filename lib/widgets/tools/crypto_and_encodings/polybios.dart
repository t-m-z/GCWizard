import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_alphabetdropdown.dart';
import 'package:gc_wizard/widgets/common/gcw_alphabetmodification_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Polybios extends StatefulWidget {
  @override
  PolybiosState createState() => PolybiosState();
}

class PolybiosState extends State<Polybios> {
  var _inputController;
  var _keyController;
  var _alphabetController;

  String _currentInput = '';
  String _currentKey = '12345';

  PolybiosMode _currentPolybiosMode = PolybiosMode.AZ09;
  String _currentAlphabet = '';

  AlphabetModificationMode _currentModificationMode = AlphabetModificationMode.J_TO_I;

  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
    _alphabetController = TextEditingController(text: _currentAlphabet);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    _alphabetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var polybiosModeItems = {
      PolybiosMode.AZ09: i18n(context, 'polybios_mode_az09'),
      PolybiosMode.ZA90: i18n(context, 'polybios_mode_za90'),
      PolybiosMode.CUSTOM: i18n(context, 'common_custom'),
    };

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
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_key')),
        GCWTextField(
          hintText: i18n(context, 'common_key'),
          maxLength: 6,
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_alphabet')),
        GCWAlphabetDropDown(
          value: _currentPolybiosMode,
          items: polybiosModeItems,
          customModeKey: PolybiosMode.CUSTOM,
          textFieldController: _alphabetController,
          onChanged: (value) {
            setState(() {
              _currentPolybiosMode = value;
            });
          },
          onCustomAlphabetChanged: (text) {
            setState(() {
              _currentAlphabet = text;
            });
          },
        ),
        _currentKey != null && _currentKey.length < 6
            ? GCWAlphabetModificationDropDownButton(
                value: _currentModificationMode,
                onChanged: (value) {
                  setState(() {
                    _currentModificationMode = value;
                  });
                },
              )
            : Container(),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentInput == null ||
        _currentInput.length == 0 ||
        _currentKey == null ||
        ![5, 6].contains(_currentKey.length)) {
      return GCWDefaultOutput(); // TODO: Exception
    }

    var _currentOutput;
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptPolybios(_currentInput, _currentKey,
          mode: _currentPolybiosMode, modificationMode: _currentModificationMode, fillAlphabet: _currentAlphabet);
    } else {
      _currentOutput = decryptPolybios(_currentInput, _currentKey,
          mode: _currentPolybiosMode, modificationMode: _currentModificationMode, fillAlphabet: _currentAlphabet);
    }

    if (_currentOutput == null || _currentOutput.output.length == 0) {
      return GCWDefaultOutput(); // TODO: Exception
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
          title: i18n(context, 'polybios_usedgrid'),
          child: GCWOutputText(
            text: _currentOutput.grid,
            isMonotype: true,
          ),
        )
      ],
    );
  }
}
