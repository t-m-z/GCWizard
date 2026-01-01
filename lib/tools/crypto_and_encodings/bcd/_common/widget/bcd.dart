import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/wrapper_for_masktextinputformatter.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/_common/logic/bcd.dart';

abstract class AbstractBCD extends StatefulWidget {
  final BCDType type;

  const AbstractBCD({super.key, required this.type});

  @override
  _AbstractBCDState createState() => _AbstractBCDState();
}

class _AbstractBCDState extends State<AbstractBCD> {
  late TextEditingController _inputEncryptController;
  late TextEditingController _inputDecryptController;

  final _encodeMaskFormatter = GCWMaskTextInputFormatter(
      mask: '#' * 10000, // allow 10000 characters input
      filter: {"#": RegExp(r'\d')});

  final _decode4DigitsMaskFormatter = GCWMaskTextInputFormatter(
      mask: '#### ' * 5000, // allow 5000 4-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')});

  final _decode5DigitsMaskFormatter = GCWMaskTextInputFormatter(
      mask: '##### ' * 5000, // allow 5000 5-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')});

  final _decode7DigitsMaskFormatter = GCWMaskTextInputFormatter(
      mask: '####### ' * 5000, // allow 5000 5-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')});

  final _decode10DigitsMaskFormatter = GCWMaskTextInputFormatter(
      mask: '########## ' * 5000, // allow 5000 5-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')});

  var _currentEncryptInput = '';
  var _currentDecryptInput = '';

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
                inputFormatters: [_encodeMaskFormatter],
                onChanged: (text) {
                  setState(() {
                    _currentEncryptInput = text;
                  });
                },
              )
            : _buildDecode(context),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildDecode(BuildContext context) {
    switch (widget.type) {
      case BCDType.ONEOFTEN:
        return GCWTextField(
            controller: _inputDecryptController,
            inputFormatters: [_decode10DigitsMaskFormatter],
            onChanged: (text) {
              setState(() {
                _currentDecryptInput = text;
              });
            });
      case BCDType.HAMMING:
      case BCDType.BIQUINARY:
        return GCWTextField(
            controller: _inputDecryptController,
            inputFormatters: [_decode7DigitsMaskFormatter],
            onChanged: (text) {
              setState(() {
                _currentDecryptInput = text;
              });
            });
      case BCDType.LIBAWCRAIG:
      case BCDType.TWOOFFIVE:
      case BCDType.PLANET:
      case BCDType.POSTNET:
        return GCWTextField(
            controller: _inputDecryptController,
            inputFormatters: [_decode5DigitsMaskFormatter],
            onChanged: (text) {
              setState(() {
                _currentDecryptInput = text;
              });
            });
      default:
        return GCWTextField(
            controller: _inputDecryptController,
            inputFormatters: [_decode4DigitsMaskFormatter],
            onChanged: (text) {
              setState(() {
                _currentDecryptInput = text;
              });
            });
    }
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeBCD(_currentEncryptInput, widget.type);
    } else {
      output = decodeBCD(_currentDecryptInput, widget.type);
    }

    return GCWDefaultOutput(child: output);
  }
}
