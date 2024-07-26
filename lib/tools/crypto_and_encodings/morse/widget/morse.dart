import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/morse/logic/morse.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/text_widget_utils.dart';


const String _apiSpecification = '''
{
  "/morse" : {
    "get": {
      "summary": "Morse Tool",
      "responses": {
        "204": {
          "description": "Tool loaded. No response data."
        }
      },
      "parameters" : [
        {
          "in": "query",
          "name": "input",
          "required": true,
          "description": "Input data for encoding or decoding Morse",
          "schema": {
            "type": "string"
          }
        },
        {
          "in": "query",
          "name": "mode",
          "description": "Defines encoding or decoding mode",
          "schema": {
            "type": "string",
            "enum": [
              "encode",
              "decode"
            ],
            "default": "decode"
          }
        }
      ]
    }
  }
}
''';

class Morse extends GCWWebStatefulWidget {
  Morse({Key? key}) : super(key: key, apiSpecification: _apiSpecification);

  @override
  _MorseState createState() => _MorseState();
}

class _MorseState extends State<Morse> {
  late TextEditingController _encodeController;
  late TextEditingController _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  var player = AudioPlayer(playerId: const Uuid().v4(),);

  String _playlist = '';
  int _index = 0;

  void playSound(int index) {
    if (index < _playlist.length) {
      player.play(MORSE_TONE[_playlist[index]]!);
      if (index + 1 < _playlist.length) {
        StreamSubscription<void> subscription = player.onPlayerComplete.listen((event) => 0);
        subscription = player.onPlayerComplete.listen((event) {
          index++;
          playSound(index,);
          subscription.cancel();
        });
      }
    }
  }

  MorseType _currentCode = MorseType.MORSE_ITU;

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;
  static const IconData primitive_dot = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  void initState() {
    super.initState();

    if (widget.hasWebParameter()) {
      if (widget.getWebParameter('mode') == 'encode') {
        _currentMode = GCWSwitchPosition.left;
      }
      if (_currentMode == GCWSwitchPosition.left) {
        _currentEncodeInput = widget.getWebParameter('input') ?? _currentEncodeInput;
      } else {
        _currentDecodeInput = widget.getWebParameter('input') ?? _currentDecodeInput;
      }
      widget.webParameter = null;
    }

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDown<MorseType>(
          value: _currentCode,
          items: MORSE_CODES.entries.map((mode) {
            return GCWDropDownMenuItem(
                value: mode.key,
                child: i18n(context, mode.value + '_title'),
                subtitle: i18n(context, mode.value + '_description'));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentCode = value;
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
        _buildMorseButtons(context),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                  });
                },
              ),
        GCWTextDivider(text: i18n(context, 'common_output')),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildMorseButtons(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.left) return Container();

    Widget morseButtons = Container();

    switch (_currentCode) {
      case MorseType.MORSE_ITU:
        morseButtons = _buildMorseButtonsMorseStandard(context);
        break;
      case MorseType.MORSE1838:
        morseButtons = _buildMorseButtonsMorseAmerican1838(context);
        break;
      case MorseType.MORSE1844:
        morseButtons = _buildMorseButtonsMorseAmerican1844(context);
        break;
      case MorseType.GERKE:
        morseButtons = _buildMorseButtonsGerke(context);
        break;
      case MorseType.STEINHEIL:
        morseButtons = _buildMorseButtonsSteinheil(context);
        break;
      default:
        morseButtons = Container();
    }

    return GCWToolBar(flexValues: const [
      5,
      2,
      1,
    ], children: [
      morseButtons,
      Container(
        padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN, left: DOUBLE_DEFAULT_MARGIN),
        child: Row(
          children: [
            Expanded(
              child: GCWIconButton(
                icon: Icons.double_arrow,
                onPressed: () {
                  setState(() {
                    _addCharacter(' ');
                  });
                },
              ),
            ),
            Expanded(
              child: GCWIconButton(
                icon: Icons.space_bar,
                onPressed: () {
                  setState(() {
                    _addCharacter(' | ');
                  });
                },
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
        child: GCWIconButton(
          icon: Icons.backspace,
          onPressed: () {
            setState(() {
              _currentDecodeInput = textControllerDoBackSpace(_currentDecodeInput, _decodeController);
            });
          },
        ),
      )
    ]);
  }

  Widget _buildMorseButtonsMorseStandard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
      child: Row(
        children: [
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.circle, size: 15, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('.');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 35, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('-');
                });
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildMorseButtonsMorseAmerican1838(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
      child: Row(
        children: [
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.circle, size: 10, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('.');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 20, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('-');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 30, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('–');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.space_bar, size: 15, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('\u202F');
                });
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildMorseButtonsMorseAmerican1844(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
      child: Row(
        children: [
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.circle, size: 10, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('.');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 20, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('-');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 30, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('–');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 40, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('―');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.space_bar, size: 15, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('\u202F');
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMorseButtonsGerke(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
      child: Row(
        children: [
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.circle, size: 10, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('.');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 20, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('-');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.remove, size: 40, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('―');
                });
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildMorseButtonsSteinheil(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
      child: Row(
        children: [
          Expanded(
            child: GCWIconButton(
              customIcon: Icon(Icons.circle, size: 10, color: themeColors().mainFont()),
              onPressed: () {
                setState(() {
                  _addCharacter('.');
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              //customIcon: Icon(Icons.fiber_manual_record, size: 5, color: themeColors().mainFont()),
              icon: primitive_dot,
              onPressed: () {
                setState(() {
                  _addCharacter('·');
                });
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _addCharacter(String input) {
    _currentDecodeInput = textControllerInsertText(input, _currentDecodeInput, _decodeController);
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    var textStyle = gcwTextStyle();
    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeMorse(_currentEncodeInput, type: _currentCode, spaceCharacter: String.fromCharCode(8195));
      if (_currentCode == MorseType.STEINHEIL) {
        output = output.replaceAll('-', '·');
      }
      textStyle =
          TextStyle(fontSize: textStyle.fontSize! + 15, fontFamily: textStyle.fontFamily, fontWeight: FontWeight.bold);
    } else {
      output = decodeMorse(
          _currentCode == MorseType.STEINHEIL ? _currentDecodeInput.replaceAll('·', '-') : _currentDecodeInput,
          type: _currentCode);
    }

    return Column(
      children: <Widget>[
        GCWOutputText(text: output, style: textStyle),
        GCWIconButton(
          icon: Icons.play_arrow,
          onPressed: () {
            _index = 0;
            if (_currentMode == GCWSwitchPosition.left) {
              _playlist = _buildMorseCode(output);
            } else {
              _playlist = _buildMorseCode(_currentDecodeInput);
            }
            if (_playlist.isNotEmpty) {
              playSound(_index);
            }
          },
        )
      ],
    );
  }

  String _buildMorseCode(String code){
    List<String> result = [];
    for (int i = 0; i < code.length; i++){
      result.add(code[i]);
      if ((code[i] == '.' || code[i] == '-') && (i + 1 < code.length) && ((code[i + 1] == '.' || code[i + 1] == '-'))) {
        result.add(',');
      }
    }
    return result.join('');
  }
}
