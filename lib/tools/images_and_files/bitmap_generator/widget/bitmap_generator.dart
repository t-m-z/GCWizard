import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_threeoptions_switch.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/logic/binary2image.dart';
import 'package:gc_wizard/tools/images_and_files/bitmap_generator/logic/bitmap_generator.dart';
import 'package:gc_wizard/tools/images_and_files/bitmap_generator/widget/bitmap_generator_board.dart';
import 'package:gc_wizard/tools/images_and_files/qr_code/logic/qr_code.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/image_utils/image_utils.dart';

class BitmapGenerator extends StatefulWidget {
  final GCWFile? file;

  const BitmapGenerator({super.key, this.file});

  @override
  _BitmapGeneratorState createState() => _BitmapGeneratorState();
}

class _BitmapGeneratorState extends State<BitmapGenerator> {
  String _currentInput = '';
  int _currentWidth = 16;
  int _currentHeight = 10;

  final Map<int, NUMBER_TYPE> _currentNumberType = {
    0: NUMBER_TYPE.DECIMAL,
    1: NUMBER_TYPE.BINARY,
    2: NUMBER_TYPE.HEXADECIMAL,
  };
  int _currentOption = 1;

  late Image2BinaryData _board;

  Uint8List? _outData;
  String? _codeData;

  BigInt _currentNumber = BigInt.zero;

  late TextEditingController _inputController;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);

    _board = Image2BinaryData(width: _currentWidth, height: _currentHeight);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildWidgetBuildMode(),
        _buildWidgetDimensions(),
        _currentMode == GCWSwitchPosition.left // encrypt
            ? _widgetBuildImageToNumber()
            : _widgetBuildNumberToImage(),
        _buildOutput(),
      ],
    );
  }

  Widget _buildWidgetBuildMode() {
    return GCWTwoOptionsSwitch(
      value: _currentMode,
      onChanged: (value) {
        setState(() {
          _currentMode = value;
        });
      },
    );
  }

  Widget _buildWidgetDimensions() {
    return Row(
      children: [
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
              child: GCWIntegerSpinner(
                  title: i18n(context, 'common_width'),
                  min: 1,
                  max: 640,
                  onChanged: (value) {
                    setState(() {
                      _currentWidth = value;
                      _board = Image2BinaryData(
                          width: _currentWidth, height: _currentHeight);
                    });
                  },
                  value: _currentWidth)),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWIntegerSpinner(
                  title: i18n(context, 'common_height'),
                  min: 1,
                  max: 480,
                  onChanged: (value) {
                    setState(() {
                      _currentHeight = value;
                      _board = Image2BinaryData(
                          width: _currentWidth, height: _currentHeight);
                    });
                  },
                  value: _currentHeight)),
        ),
      ],
    );
  }

  Widget _widgetBuildImageToNumber() {
    return Column(
      children: [
        GCWPainterContainer(
          child: Image2BinaryBoard(
            width: _currentWidth,
            height: _currentHeight,
            state: _board.currentBoard,
            onChanged: (newBoard) {
              setState(() {});
            },
          ),
        ),
        Row(children: [
          Expanded(
            child: GCWIconButton(
              iconColor: themeColors().dialogText(),
              backgroundColor: themeColors().dialog(),
              size: IconButtonSize.SMALL,
              icon: Icons.calculate_outlined,
              onPressed: () {
                setState(() {
                  _currentNumber = _board.getNumber();
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              iconColor: themeColors().dialogText(),
              backgroundColor: themeColors().dialog(),
              size: IconButtonSize.SMALL,
              icon: Icons.clear,
              onPressed: () {
                setState(() {
                  _board = Image2BinaryData(
                      width: _currentWidth, height: _currentHeight);
                });
              },
            ),
          )
        ]),
      ],
    );
  }

  Widget _widgetBuildNumberToImage() {
    return Column(
      children: [
        GCWThreeOptionsSwitch(
          title: i18n(context, 'common_numeralbase'),
          position: _currentOption,
          onChanged: (position) {
            setState(() {
              _currentOption = position;
            });
          },
          labels: ['10', '2', '16'],
        ),
        GCWTextField(
          controller: _inputController,
          onChanged: (value) {
            setState(() {
              _currentInput = value;
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _createImageOutput();
            });
          },
        ),
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      return GCWDefaultOutput(child: _buildImageOutput());
    } else {
      return GCWDefaultOutput(
        child: GCWColumnedMultilineOutput(
          data: [
            [
              i18n(context, 'common_numeralbase_denary'),
              _currentNumber.toString()
            ],
            [
              i18n(context, 'common_numeralbase_binary'),
              convertBase(_currentNumber.toString(), 10, 2)
            ],
            [
              i18n(context, 'common_numeralbase_hexadecimal'),
              convertBase(_currentNumber.toString(), 10, 16)
            ],
          ],
        ),
      );
    }
  }

  void _createImageOutput() {
    _outData = null;
    _codeData = null;

    var image = binary2Image(
        numberToImage(_currentInput, _currentNumberType[_currentOption]!),
        customLines: _currentHeight);
    if (image == null) return;
    input2Image(image).then((value) {
      setState(() {
        _outData = value;
        scanBytes(_outData).then((value) {
          setState(() {
            _codeData = value;
          });
        });
      });
    });
  }

  Widget _buildImageOutput() {
    if (_outData == null) return Container();

    return Column(children: <Widget>[
      GCWImageView(imageData: GCWImageViewData(GCWFile(bytes: _outData!))),
      _codeData != null
          ? GCWOutput(
              title: i18n(context, 'binary2image_code_data'), child: _codeData)
          : Container(),
    ]);
  }
}
