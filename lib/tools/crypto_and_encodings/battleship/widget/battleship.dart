import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_code_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/battleship/logic/battleship.dart';

class Battleship extends StatefulWidget {
  const Battleship({Key? key}) : super(key: key);

  @override
  BattleshipState createState() => BattleshipState();
}

class BattleshipState extends State<Battleship> {
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentEncryptMode = GCWSwitchPosition.left;

  late CodeController _encodeGraphicController;
  late TextEditingController _encodeTextController;
  late TextEditingController _decodeController;
  late TextEditingController _plainGenerateController;

  String _currentDecode = '';
  String _currentTextEncode = '';

  String _encodeOutput = '';
  String _decodeOutput = '';

  final bool _TEXTMODE = true;
  final bool _GRAPHICMODE = false;

  @override
  void initState() {
    super.initState();
    _encodeGraphicController = CodeController(
      text: _encodeOutput,
    );
    _encodeTextController = TextEditingController(text: _currentTextEncode);
    _decodeController = TextEditingController(text: _currentDecode);
    _plainGenerateController = TextEditingController(text: _decodeOutput);
  }

  @override
  void dispose() {
    _encodeGraphicController.dispose();
    _encodeTextController.dispose();
    _decodeController.dispose();
    _plainGenerateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.left // encrypt
          ? Column(children: <Widget>[
              GCWTwoOptionsSwitch(
                title: i18n(context, 'battleship_input_mode'),
                leftValue: i18n(context, 'battleship_input_text'),
                rightValue: i18n(context, 'battleship_input_graphic'),
                value: _currentEncryptMode,
                onChanged: (value) {
                  setState(() {
                    _currentEncryptMode = value;
                  });
                },
              ),
              _currentEncryptMode == GCWSwitchPosition.left // text
                  ? GCWTextField(
                      controller: _encodeTextController,
                      onChanged: (text) {
                        setState(() {
                          _currentTextEncode = text;
                        });
                      },
                    )
                  : CodeField(
                      controller: _encodeGraphicController,
                      textStyle: gcwMonotypeTextStyle(),
                      lineNumbers: false,
                      lineNumberStyle: const LineNumberStyle(
                        width: 0.0,
                        margin: 0.0,
                        textStyle: TextStyle(fontSize: 0.0),
                      ),
                    )
            ])
          : GCWTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecode = text;
                });
              },
            ),
      GCWButton(
        text: i18n(context, 'common_start'),
        onPressed: () {
          setState(() {
            _calcOutput();
          });
        },
      ),
      _buildOutput(),
    ]);
  }

  void _calcOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentEncryptMode == GCWSwitchPosition.left) {
        _encodeOutput = encodeBattleship(_currentTextEncode, _TEXTMODE);
      } else {
        _encodeOutput = encodeBattleship(_encodeGraphicController.text, _GRAPHICMODE);
      }
    } else {
      _decodeOutput = decodeBattleship(_currentDecode);
    }
    setState(() {});
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      if (_decodeOutput.startsWith('battleship')) {
        _decodeOutput = i18n(context, BATTLESHIP_ERROR_INVALID_PAIR) + '\n\n' + _decodeOutput.substring(29);
      }
      _plainGenerateController.text = _decodeOutput;
      return GCWDefaultOutput(
        trailing: Row(
          children: <Widget>[
            GCWIconButton(
              iconColor: themeColors().mainFont(),
              size: IconButtonSize.SMALL,
              icon: Icons.content_copy,
              onPressed: () {
                var copyText = _plainGenerateController.text;
                insertIntoGCWClipboard(context, copyText);
              },
            ),
          ],
        ),
        child: GCWCodeTextField(
          controller: _plainGenerateController,
          textStyle: gcwMonotypeTextStyle(),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          GCWDefaultOutput(
            child: _encodeOutput,
          ),
        ],
      );
    }
  }
}
