import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_alphabetdropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/chao/logic/chao.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/reverse/logic/reverse.dart';
import 'package:gc_wizard/utils/alphabets.dart';

class Chao extends StatefulWidget {
  const Chao({super.key});

  @override
  _ChaoState createState() => _ChaoState();
}

class _ChaoState extends State<Chao> {
  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;
  late TextEditingController _alphabetControllerPlain;
  late TextEditingController _alphabetControllerChiffre;

  var _currentMode = GCWSwitchPosition.right;

  var _currentEncryptInput = '';
  var _currentDecryptInput = '';
  String _currentOutput = '';
  String _currentAlphabetPlain = '';
  String _currentAlphabetChiffre = '';

  ChaoAlphabet _currentAlphabetTypePlain = ChaoAlphabet.AZ;
  ChaoAlphabet _currentAlphabetTypeChiffre = ChaoAlphabet.AZ;

  @override
  void initState() {
    super.initState();
    _inputEncryptController = TextEditingController(text: _currentEncryptInput);
    _inputDecryptController = TextEditingController(text: _currentDecryptInput);
    _alphabetControllerPlain = TextEditingController(text: _currentAlphabetPlain);
    _alphabetControllerChiffre = TextEditingController(text: _currentAlphabetChiffre);
  }

  @override
  void dispose() {
    _inputEncryptController.dispose();
    _inputDecryptController.dispose();
    _alphabetControllerPlain.dispose();
    _alphabetControllerChiffre.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ChaoPlainAlphabetItems = {
      ChaoAlphabet.AZ: i18n(context, 'chao_alphabet_az'),
      ChaoAlphabet.ZA: i18n(context, 'chao_alphabet_za'),
      ChaoAlphabet.CUSTOM: i18n(context, 'common_custom'),
    };
    var ChaoChiffreAlphabetItems = {
      ChaoAlphabet.AZ: i18n(context, 'chao_alphabet_az'),
      ChaoAlphabet.ZA: i18n(context, 'chao_alphabet_za'),
      ChaoAlphabet.CUSTOM: i18n(context, 'common_custom'),
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
        GCWTextDivider(text: i18n(context, 'chao_alphabet_cipher')),
        GCWAlphabetDropDown<ChaoAlphabet>(
          value: _currentAlphabetTypeChiffre,
          items: ChaoChiffreAlphabetItems,
          customModeKey: ChaoAlphabet.CUSTOM,
          textFieldController: _alphabetControllerChiffre,
          onChanged: (value) {
            setState(() {
              _currentAlphabetTypeChiffre = value;
            });
          },
          onCustomAlphabetChanged: (text) {
            setState(() {
              _currentAlphabetChiffre = text;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'chao_alphabet_plain')),
        GCWAlphabetDropDown<ChaoAlphabet>(
          value: _currentAlphabetTypePlain,
          items: ChaoPlainAlphabetItems,
          customModeKey: ChaoAlphabet.CUSTOM,
          textFieldController: _alphabetControllerPlain,
          textFieldHintText: i18n(context, 'chao_alphabet_plain'),
          onChanged: (value) {
            setState(() {
              _currentAlphabetTypePlain = value;
            });
          },
          onCustomAlphabetChanged: (text) {
            setState(() {
              _currentAlphabetPlain = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentEncryptInput.isEmpty && _currentMode == GCWSwitchPosition.left) return const GCWDefaultOutput();
    if (_currentDecryptInput.isEmpty && _currentMode == GCWSwitchPosition.right) return const GCWDefaultOutput();

    var alphabetChiffre = '';
    var alphabetPlain = '';

    var alphabetAZ = alphabet_AZ.keys.join();
    var alphabetZA = reverseAll(alphabetAZ);

    switch (_currentAlphabetTypePlain) {
      case ChaoAlphabet.AZ:
        alphabetPlain = alphabetAZ;
        break;
      case ChaoAlphabet.ZA:
        alphabetPlain = alphabetZA;
        break;
      case ChaoAlphabet.CUSTOM:
        alphabetPlain = _currentAlphabetPlain.toUpperCase();
        break;
    }

    switch (_currentAlphabetTypeChiffre) {
      case ChaoAlphabet.AZ:
        alphabetChiffre = alphabetAZ;
        break;
      case ChaoAlphabet.ZA:
        alphabetChiffre = alphabetZA;
        break;
      case ChaoAlphabet.CUSTOM:
        alphabetChiffre = _currentAlphabetChiffre.toUpperCase();
        break;
    }

    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptChao(_currentEncryptInput, alphabetPlain, alphabetChiffre);
    } else {
      _currentOutput = decryptChao(_currentDecryptInput, alphabetPlain, alphabetChiffre);
    }

    return GCWDefaultOutput(
      child: _currentOutput,
    );
  }
}
