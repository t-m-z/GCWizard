import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wasd.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
import 'package:intl/intl.dart';

class WASD extends StatefulWidget {
  @override
  WASDState createState() => WASDState();
}

class WASDState extends State<WASD> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;
  TextEditingController _upController;
  TextEditingController _downController;
  TextEditingController _leftController;
  TextEditingController _rightController;

  TextEditingController _currentCustomKeyController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  var _currentUp = '↑';
  var _currentLeft = '←';
  var _currentDown = '↓';
  var _currentRight = '→';
  var _currentMode = GCWSwitchPosition.right; // decode
  var _currentOutputMode = GCWSwitchPosition.left; // only graphic
  var _currentKeyboardControls = WASD_TYPE.CURSORS;


  var _maskInputFormatter = WrapperForMaskTextInputFormatter(mask: '#', filter: {"#": RegExp(r'.')});

  Uint8List _outDecodeData;
  Uint8List _outEncodeData;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
    _upController = TextEditingController(text: _currentUp);
    _downController = TextEditingController(text: _currentDown);
    _leftController = TextEditingController(text: _currentLeft);
    _rightController = TextEditingController(text: _currentRight);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    _upController.dispose();
    _downController.dispose();
    _leftController.dispose();
    _rightController.dispose();

    super.dispose();
  }

  _buildCustomInput(WASD_DIRECTION key) {
    var title_key = 'wasd_custom_';

    switch (key) {
      case WASD_DIRECTION.UP:
        _currentCustomKeyController = _upController;
        title_key += 'up';
        break;
      case WASD_DIRECTION.LEFT:
        _currentCustomKeyController = _leftController;
        title_key += 'left';
        break;
      case WASD_DIRECTION.DOWN:
        _currentCustomKeyController = _downController;
        title_key += 'down';
        break;
      case WASD_DIRECTION.RIGHT:
        _currentCustomKeyController = _rightController;
        title_key += 'right';
        break;
      default:
        return;
    }

    var title = i18n(context, title_key);

    return Expanded(
      child: Column(children: <Widget>[
        GCWTextDivider(
          text: title,
        ),
        GCWTextField(
            inputFormatters: [_maskInputFormatter],
            hintText: title,
            controller: _currentCustomKeyController,
            onChanged: (text) {
              setState(() {
                switch (key) {
                  case WASD_DIRECTION.UP:
                    _currentUp = text;
                    break;
                  case WASD_DIRECTION.LEFT:
                    _currentLeft = text;
                    break;
                  case WASD_DIRECTION.DOWN:
                    _currentDown = text;
                    break;
                  case WASD_DIRECTION.RIGHT:
                    _currentRight = text;
                    break;
                  default:
                    return;
                }
                _updateDrawing();
              });
            }),
      ]),
    );
  }

  _buildButton(String text) {
    return Container(
      height: 55,
      width: 40,
      child: GCWButton(
        text: text,
        onPressed: () {
          _addInput(text);
        },
      ),
    );
  }

  _updateDrawing() {
    if (_currentMode == GCWSwitchPosition.left) {
      _createGraphicOutputEncodeData();
    } else {
      _createGraphicOutputDecodeData();
    }
  }

  _buildControlSet() {
    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'wasd_control_set'),
        ),
        GCWDropDownButton(
          value: _currentKeyboardControls,
          onChanged: (value) {
            setState(() {
              _currentKeyboardControls = value;
              if (value != WASD_TYPE.CUSTOM) {
                _currentUp = KEYBOARD_CONTROLS[value][0];
                _currentLeft = KEYBOARD_CONTROLS[value][1];
                _currentDown = KEYBOARD_CONTROLS[value][2];
                _currentRight = KEYBOARD_CONTROLS[value][3];

                _upController.text = _currentUp;
                _leftController.text = _currentLeft;
                _downController.text = _currentDown;
                _rightController.text = _currentRight;
              }

              _updateDrawing();
            });
          },
          items: KEYBOARD_CONTROLS.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: i18n(context, mode.value) ?? mode.value,
            );
          }).toList(),
        ),
        if (_currentKeyboardControls == WASD_TYPE.CUSTOM)
          Row(
            children: <Widget>[
              _buildCustomInput(WASD_DIRECTION.UP),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.LEFT),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.DOWN),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.RIGHT)
            ],
          ),
        if (_currentMode == GCWSwitchPosition.right)
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildButton(_currentUp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(_currentLeft),
                        Container(width: 20),
                        _buildButton(_currentDown),
                        Container(width: 20),
                        _buildButton(_currentRight),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GCWIconButton(
                    icon: Icons.space_bar,
                    onPressed: () {
                      setState(() {
                        _addInput(' ');
                      });
                    },
                  ),
                  GCWIconButton(
                    icon: Icons.backspace,
                    onPressed: () {
                      setState(() {
                        _currentDecodeInput = textControllerDoBackSpace(_currentDecodeInput, _decodeController);
                        _updateDrawing();
                      });
                    },
                  ),
                ],
              )
            ],
          )
      ],
    );
  }

  _addInput(String char) {
    setState(() {
      _currentDecodeInput = textControllerInsertText(char, _currentDecodeInput, _decodeController);
      _updateDrawing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_currentMode == GCWSwitchPosition.left) // encode
          GCWTextField(
              controller: _encodeController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
              hintText: '0123456789',
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                  _updateDrawing();
                });
              })
        else // decode
          GCWTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecodeInput = text;
                  _updateDrawing();
                });
              }),
        _buildControlSet(),
        GCWTwoOptionsSwitch(
          // switch between encrypt and decrypt
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        if (_currentMode == GCWSwitchPosition.right) //decode
          GCWTwoOptionsSwitch(
            leftValue: i18n(context, "wasd_output_mode_g"),
            rightValue: i18n(context, "wasd_output_mode_t"),
            value: _currentOutputMode,
            onChanged: (value) {
              setState(() {
                _currentOutputMode = value;
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.right) //decode
          GCWDefaultOutput(
              child: _buildGraphicDecodeOutput(),
              trailing: GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                iconColor: _outDecodeData == null ? themeColors().inActive() : null,
                onPressed: () {
                  _outDecodeData == null ? null : _exportFile(context, _outDecodeData);
                },
              ))
        else
          GCWDefaultOutput(
              child: _buildGraphicEncodeOutput(),
              trailing: GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                iconColor: _outEncodeData == null ? themeColors().inActive() : null,
                onPressed: () {
                  _outEncodeData == null ? null : _exportFile(context, _outEncodeData);
                },
              )),
        if (_currentMode == GCWSwitchPosition.left ||
            (_currentMode == GCWSwitchPosition.right && _currentOutputMode == GCWSwitchPosition.right)) //text & graphic
             GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _createGraphicOutputDecodeData() {
    var out = decodeWASDGraphic(_currentDecodeInput, [_currentUp, _currentLeft, _currentDown, _currentRight]);

    _outDecodeData = null;
    binary2image(out, false, false).then((value) {
      setState(() {
        _outDecodeData = value;
      });
    });
  }

  Widget _buildGraphicDecodeOutput() {
    if (_outDecodeData == null) return null;

    return Column(children: <Widget>[
      Image.memory(_outDecodeData),
    ]);
  }

  _createGraphicOutputEncodeData() {
    var out = decodeWASDGraphic(
        encodeWASD(_currentEncodeInput, [_currentUp, _currentLeft, _currentDown, _currentRight]),
        [_currentUp, _currentLeft, _currentDown, _currentRight]);

    _outEncodeData = null;
    binary2image(out, false, false).then((value) {
      setState(() {
        _outEncodeData = value;
      });
    });
  }

  Widget _buildGraphicEncodeOutput() {
    if (_outEncodeData == null) return null;

    return Column(children: <Widget>[
      Image.memory(_outEncodeData),
    ]);
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var value =
        await saveByteDataToFile(context, data, 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

    if (value != null) showExportedFileDialog(context, fileType: FileType.PNG, contentWidget: Image.memory(data));
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      return decodeWASD(_currentDecodeInput, [_currentUp, _currentLeft, _currentDown, _currentRight]);
    } else {
      return encodeWASD(_currentEncodeInput, [_currentUp, _currentLeft, _currentDown, _currentRight]);
    }
  }
}
