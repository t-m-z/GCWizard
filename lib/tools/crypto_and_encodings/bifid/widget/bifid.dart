import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_alphabetdropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_alphabetmodification_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_multiple_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/_common/logic/crypt_alphabet_modification.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bifid/logic/bifid.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/logic/polybios.dart';

class Bifid extends StatefulWidget {
  const Bifid({Key? key}) : super(key: key);

  @override
  _BifidState createState() => _BifidState();
}

class _BifidState extends State<Bifid> {
  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;
  late TextEditingController _alphabetController;

  var _currentMode = GCWSwitchPosition.right;

  var _currentEncryptInput = '';
  var _currentDecryptInput = '';
  String _currentAlphabet = '';

  PolybiosMode _currentBifidMode = PolybiosMode.AZ09;
  AlphabetModificationMode _currentModificationMode = AlphabetModificationMode.J_TO_I;

  GCWSwitchPosition _currentMatrixMode = GCWSwitchPosition.left;

  /// switches between 5x5 or 6x6 square

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
    var BifidModeItems = {
      PolybiosMode.AZ09: i18n(context, 'bifid_mode_az09'),
      PolybiosMode.ZA90: i18n(context, 'bifid_mode_za90'),
      PolybiosMode.CUSTOM: i18n(context, 'bifid_mode_custom'),
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

        GCWAlphabetDropDown<PolybiosMode>(
          value: _currentBifidMode,
          items: BifidModeItems,
          customModeKey: PolybiosMode.CUSTOM,
          textFieldController: _alphabetController,
          onChanged: (value) {
            setState(() {
              _currentBifidMode = value;
            });
          },
          onCustomAlphabetChanged: (text) {
            setState(() {
              _currentAlphabet = text;
            });
          },
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'bifid_matrix'),
          leftValue: i18n(context, 'bifid_mode_5x5'),
          rightValue: i18n(context, 'bifid_mode_6x6'),
          value: _currentMatrixMode,
          onChanged: (value) {
            setState(() {
              _currentMatrixMode = value;
            });
          },
        ),

        _currentMatrixMode == GCWSwitchPosition.left
            ? GCWAlphabetModificationDropDown(
                value: _currentModificationMode,
                onChanged: (value) {
                  setState(() {
                    _currentModificationMode = value;
                  });
                },
              )
            : Container(), //empty widget

        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    String key;
    if (_currentMatrixMode == GCWSwitchPosition.left) {
      key = "12345";
    } else {
      key = "123456";
    }

    if (_currentEncryptInput.isEmpty && _currentMode == GCWSwitchPosition.left) return const GCWDefaultOutput(child: '');
    if (_currentDecryptInput.isEmpty && _currentMode == GCWSwitchPosition.right) return const GCWDefaultOutput(child: '');

    var _currentOutput = BifidOutput('', '', '');
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptBifid(_currentEncryptInput, key,
          mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentModificationMode);
    } else {
      _currentOutput = decryptBifid(_currentDecryptInput, key,
          mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentModificationMode);
    }

    if (_currentOutput.state == 'ERROR') {
      showSnackBar(i18n(context, _currentOutput.output), context);
      return const GCWDefaultOutput(child: '');
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
            title: i18n(context, 'bifid_usedgrid'),
            child: GCWOutputText(
              text: _currentOutput.grid,
              isMonotype: true,
            ))
      ],
    );
  }
}
