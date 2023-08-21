import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/wrapper_for_masktextinputformatter.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wasd/logic/wasd.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/logic/binary2image.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/image_utils/image_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/text_widget_utils.dart';

class WASD extends StatefulWidget {
  const WASD({Key? key}) : super(key: key);

  @override
 _WASDState createState() => _WASDState();
}

class _WASDState extends State<WASD> {
  late TextEditingController _encodeController;
  late TextEditingController _decodeController;
  late TextEditingController _upController;
  late TextEditingController _upLeftController;
  late TextEditingController _upRightController;
  late TextEditingController _downController;
  late TextEditingController _downLeftController;
  late TextEditingController _downRightController;
  late TextEditingController _leftController;
  late TextEditingController _rightController;

  late TextEditingController _currentCustomKeyController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  var _currentUp = '↑';
  var _currentLeft = '←';
  var _currentDown = '↓';
  var _currentRight = '→';
  var _currentDownLeft = '↙';
  var _currentDownRight = '↘';
  var _currentUpLeft = '↖';
  var _currentUpRight = '↗';
  var _currentMode = GCWSwitchPosition.right; // decode
  var _currentOutputMode = GCWSwitchPosition.left; // only graphic
  var _currentKeyboardControls = WASD_TYPE.CURSORS;
  int _keyboardLayout = 8;

  final _maskInputFormatter = WrapperForMaskTextInputFormatter(mask: '#', filter: {"#": RegExp(r'\S')});

  //must be nullable unless finding a way to initialize growable Uint8Lists. All tested ways resulted in fixed-length lists
  Uint8List? _outDecodeData;
  Uint8List? _outEncodeData;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
    _upController = TextEditingController(text: _currentUp);
    _downController = TextEditingController(text: _currentDown);
    _leftController = TextEditingController(text: _currentLeft);
    _rightController = TextEditingController(text: _currentRight);
    _downLeftController = TextEditingController(text: _currentDownLeft);
    _downRightController = TextEditingController(text: _currentDownRight);
    _upLeftController = TextEditingController(text: _currentUpLeft);
    _upRightController = TextEditingController(text: _currentUpRight);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    _upController.dispose();
    _upLeftController.dispose();
    _upRightController.dispose();
    _downController.dispose();
    _downLeftController.dispose();
    _downRightController.dispose();
    _leftController.dispose();
    _rightController.dispose();

    super.dispose();
  }
  
  String _defaultCursorForWASDDirection(WASD_DIRECTION direction) {
    String cursors = KEYBOARD_CONTROLS[WASD_TYPE.CURSORS]!;
    
    switch (direction) {
      case WASD_DIRECTION.UP:
        return cursors[0];
      case WASD_DIRECTION.LEFT:
        return cursors[1];
      case WASD_DIRECTION.DOWN:
        return cursors[2];
      case WASD_DIRECTION.RIGHT:
        return cursors[3];
      case WASD_DIRECTION.UPLEFT:
        return cursors[4];
      case WASD_DIRECTION.UPRIGHT:
        return cursors[5];
      case WASD_DIRECTION.DOWNLEFT:
        return cursors[6];
      case WASD_DIRECTION.DOWNRIGHT:
        return cursors[7];
      default: return '';
    }
  }

  Widget _buildCustomInput(WASD_DIRECTION key) {
    switch (key) {
      case WASD_DIRECTION.UP:
        _currentCustomKeyController = _upController;
        break;
      case WASD_DIRECTION.LEFT:
        _currentCustomKeyController = _leftController;
        break;
      case WASD_DIRECTION.DOWN:
        _currentCustomKeyController = _downController;
        break;
      case WASD_DIRECTION.RIGHT:
        _currentCustomKeyController = _rightController;
        break;
      case WASD_DIRECTION.UPLEFT:
        _currentCustomKeyController = _upLeftController;
        break;
      case WASD_DIRECTION.UPRIGHT:
        _currentCustomKeyController = _upRightController;
        break;
      case WASD_DIRECTION.DOWNLEFT:
        _currentCustomKeyController = _downLeftController;
        break;
      case WASD_DIRECTION.DOWNRIGHT:
        _currentCustomKeyController = _downRightController;
        break;
      default:
        return Container();
    }

    return Expanded(
      child: Column(children: <Widget>[
        GCWTextField(
            inputFormatters: [_maskInputFormatter],
            hintText: _defaultCursorForWASDDirection(key),
            controller: _currentCustomKeyController,
            onChanged: (String text) {
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
                  case WASD_DIRECTION.UPLEFT:
                    _currentUpLeft = text;
                    break;
                  case WASD_DIRECTION.UPRIGHT:
                    _currentUpRight = text;
                    break;
                  case WASD_DIRECTION.DOWNLEFT:
                    _currentDownLeft = text;
                    break;
                  case WASD_DIRECTION.DOWNRIGHT:
                    _currentDownRight = text;
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

  Widget _buildButton(String text) {
    return SizedBox(
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

  List<String> _controlSet() {
    var controlSet = [
      _currentUp,
      _currentLeft,
      _currentDown,
      _currentRight
    ];

    if (_keyboardLayout == 8) {
      controlSet.addAll([
        _currentUpLeft,
        _currentUpRight,
        _currentDownLeft,
        _currentDownRight
      ]);
    }

    return controlSet;
  }

  void _updateDrawing() {
    if (_currentMode == GCWSwitchPosition.left) {
      _createGraphicOutputEncodeData();
    } else {
      _createGraphicOutputDecodeData();
    }
  }

  Widget _buildControlSet() {
    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'wasd_control_set'),
        ),
        GCWDropDown<WASD_TYPE>(
          value: _currentKeyboardControls,
          onChanged: (WASD_TYPE value) {
            setState(() {
              if (KEYBOARD_CONTROLS[value] == null) {
                value = WASD_TYPE.CURSORS;
              }

              _currentKeyboardControls = value;

              if (value != WASD_TYPE.CUSTOM) {
                var _keyboardControls = KEYBOARD_CONTROLS[value]!.replaceAll(RegExp(r'\s'), '');
                _keyboardLayout = _keyboardControls.length;

                while (_keyboardLayout!= 4 && _keyboardLayout != 8) {
                  _keyboardControls = KEYBOARD_CONTROLS[WASD_TYPE.CURSORS]!;
                  _keyboardLayout = 8;
                }

                _currentUp = _keyboardControls[0];
                _currentLeft = _keyboardControls[1];
                _currentDown = _keyboardControls[2];
                _currentRight = _keyboardControls[3];

                if (_keyboardLayout == 8) {
                  _currentUpLeft = _keyboardControls[4];
                  _currentUpRight = _keyboardControls[5];
                  _currentDownLeft = _keyboardControls[6];
                  _currentDownRight = _keyboardControls[7];
                } else {
                  _currentUpLeft = '';
                  _currentUpRight = '';
                  _currentDownLeft = '';
                  _currentDownRight = '';
                }
              } else {
                _keyboardLayout = 8;

                _currentUp = '';
                _currentLeft = '';
                _currentDown = '';
                _currentRight = '';
                _currentUpLeft = '';
                _currentUpRight = '';
                _currentDownLeft = '';
                _currentDownRight = '';
              }

              _upController.text = _currentUp;
              _leftController.text = _currentLeft;
              _downController.text = _currentDown;
              _rightController.text = _currentRight;
              _downLeftController.text = _currentDownLeft;
              _downRightController.text = _currentDownRight;
              _upLeftController.text = _currentUpLeft;
              _upRightController.text = _currentUpRight;

              _updateDrawing();
            });
          },
          items: KEYBOARD_CONTROLS.entries.map((mode) {
            String name;
            switch (mode.key) {
              case WASD_TYPE.CUSTOM: name = i18n(context, 'wasd_keyboard_custom'); break;
              case WASD_TYPE.NUMERIC: name = i18n(context, 'wasd_keyboard_numpad'); break;
              case WASD_TYPE.CURSORS: name = mode.value; break;
              default: name = mode.value.substring(0, 4);
            }

            return GCWDropDownMenuItem(
              value: mode.key,
              child: name,
            );
          }).toList(),
        ),
        if (_currentKeyboardControls == WASD_TYPE.CUSTOM)
          Row(
            children: <Widget>[
              _buildCustomInput(WASD_DIRECTION.UP),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.UPLEFT),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.UPRIGHT),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.LEFT),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.DOWN),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.DOWNLEFT),
              Container(width: DOUBLE_DEFAULT_MARGIN),
              _buildCustomInput(WASD_DIRECTION.DOWNRIGHT),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         _keyboardLayout == 8 ? _buildButton(_currentUpLeft) : Container(),
                        Container(width: 20),
                        _buildButton(_currentUp),
                        Container(width: 20),
                        _keyboardLayout == 8 ? _buildButton(_currentUpRight) : Container(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(_currentLeft),
                        Container(width: 20),
                        Container(width: 20),
                        _buildButton(_currentRight),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _keyboardLayout == 8 ? _buildButton(_currentDownLeft) : Container(),
                        Container(width: 20),
                        _buildButton(_currentDown),
                        Container(width: 20),
                        _keyboardLayout == 8 ? _buildButton(_currentDownRight) : Container(),
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

  void _addInput(String char) {
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d')),
              ],
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
            leftValue: i18n(context, 'wasd_output_mode_g'),
            rightValue: i18n(context, 'wasd_output_mode_t'),
            value: _currentOutputMode,
            onChanged: (value) {
              setState(() {
                _currentOutputMode = value;
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.right) //decode
          GCWDefaultOutput(
              trailing: GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                iconColor: _outDecodeData == null ? themeColors().inActive() : null,
                onPressed: () {
                  _outDecodeData == null ? null : _exportFile(context, _outDecodeData!);
                },
              ),
              child: _buildGraphicDecodeOutput())
        else
          GCWDefaultOutput(
              trailing: GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                iconColor: _outEncodeData == null ? themeColors().inActive() : null,
                onPressed: () {
                  _outEncodeData == null ? null : _exportFile(context, _outEncodeData!);
                },
              ),
              child: _buildGraphicEncodeOutput()),
        if (_currentMode == GCWSwitchPosition.left ||
            (_currentMode == GCWSwitchPosition.right && _currentOutputMode == GCWSwitchPosition.right)) //text & graphic
          GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  void _createGraphicOutputDecodeData() {
    var out = decodeWASDGraphic(_currentDecodeInput, _controlSet());

    _outDecodeData = null;
    var input = binary2image(out, false, false);
    if (input == null) return;
    input2Image(input).then((value) {
      setState(() {
        _outDecodeData = value;
      });
    });
  }

  Widget _buildGraphicDecodeOutput() {
    if (_outDecodeData == null) return Container();

    return Column(children: <Widget>[
      Image.memory(_outDecodeData!),
    ]);
  }

  void _createGraphicOutputEncodeData() {

    var controlSet = _controlSet();
    var encoded = encodeWASD(_currentEncodeInput, controlSet);

    var out = decodeWASDGraphic(
        encoded,
        controlSet
    );

    _outEncodeData = null;
    var input = binary2image(out, false, false);
    if (input == null) return;
    input2Image(input).then((value) {
      setState(() {
        _outEncodeData = value;
      });
    });
  }

  Widget _buildGraphicEncodeOutput() {
    if (_outEncodeData == null) return Container();

    return Column(children: <Widget>[
      Image.memory(_outEncodeData!),
    ]);
  }

  Future<void> _exportFile(BuildContext context, Uint8List data) async {
    await saveByteDataToFile(context, data, buildFileNameWithDate('img_', FileType.PNG)).then((value) {
      if (value) showExportedFileDialog(context, contentWidget: imageContent(context, data));
    });
  }

  String _buildOutput() {
    var controlSet = _controlSet();

    if (_currentMode == GCWSwitchPosition.right) {
      return decodeWASD(_currentDecodeInput, controlSet);
    } else {
      return encodeWASD(_currentEncodeInput, controlSet);
    }
  }
}
