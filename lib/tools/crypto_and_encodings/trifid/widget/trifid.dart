import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_alphabetdropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_multiple_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/logic/polybios.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/trifid/logic/trifid.dart';

class Trifid extends StatefulWidget {
  const Trifid({Key? key}) : super(key: key);

  @override
  _TrifidState createState() => _TrifidState();
}

class _TrifidState extends State<Trifid> {
  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;
  late TextEditingController _alphabetController;

  var _currentMode = GCWSwitchPosition.right;

  var _currentEncryptInput = '';
  var _currentDecryptInput = '';
  String _currentAlphabet = '';
  int _currentBlockSize = 4;

  PolybiosMode _currentTrifidMode = PolybiosMode.AZ09;

  @override
  void initState() {
    super.initState();
    _inputEncryptController = TextEditingController(text: _currentEncryptInput);
    _inputDecryptController = TextEditingController(text: _currentDecryptInput);
    _alphabetController = TextEditingController(text: _currentAlphabet);
  }

  @override
  void dispose() {
    _inputEncryptController.dispose();
    _inputDecryptController.dispose();
    _alphabetController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var TrifidModeItems = {
      PolybiosMode.AZ09: i18n(context, 'trifid_mode_az09'),
      PolybiosMode.ZA90: i18n(context, 'trifid_mode_za90'),
      PolybiosMode.CUSTOM: i18n(context, 'trifid_mode_custom'),
    };

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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[A-Za-z+]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentEncryptInput = text;
            });
          },
        )
            : GCWTextField(
          controller: _inputDecryptController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[A-Za-z+]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentDecryptInput = text;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'trifid_block_size'),
          value: _currentBlockSize,
          min: 2,
          onChanged: (value) {
            setState(() {
              _currentBlockSize = value;
            });
          },
        ),
        GCWAlphabetDropDown<PolybiosMode>(
          value: _currentTrifidMode,
          items: TrifidModeItems,
          customModeKey: PolybiosMode.CUSTOM,
          textFieldController: _alphabetController,
          onChanged: (value) {
            setState(() {
              _currentTrifidMode = value;
            });
          },
          onCustomAlphabetChanged: (text) {
            setState(() {
              _currentAlphabet = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    String output = '';
    if (_currentEncryptInput.isEmpty && _currentMode == GCWSwitchPosition.left) return const GCWDefaultOutput(child: '');
    if (_currentDecryptInput.isEmpty && _currentMode == GCWSwitchPosition.right) return const GCWDefaultOutput(child: '');

    var _currentOutput = TrifidOutput('', '');
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput =
          encryptTrifid(_currentEncryptInput, _currentBlockSize, mode: _currentTrifidMode, alphabet: _currentAlphabet);
    } else {
      _currentOutput =
          decryptTrifid(_currentDecryptInput, _currentBlockSize, mode: _currentTrifidMode, alphabet: _currentAlphabet);
    }

    if (_currentOutput.output.startsWith('trifid')) {
      output = i18n(context, _currentOutput.output);
    } else {
      output = _currentOutput.output;
    }
    return GCWMultipleOutput(
      children: [
        output,
        GCWOutput(
            title: i18n(context, 'trifid_usedgrid'),
            child: GCWOutputText(
              text: _currentOutput.grid,
              isMonotype: true,
            ))
      ],
    );
  }
}
