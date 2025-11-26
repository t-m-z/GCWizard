import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_threeoptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/logic/binary2image.dart';
import 'package:gc_wizard/tools/images_and_files/bitmap_generator/logic/bitmap_generator.dart';
import 'package:gc_wizard/tools/images_and_files/bitmap_generator/widget/bitmap_generator_board.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/image_utils/image_utils.dart';

import 'package:image/image.dart' as Image;

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

  bool _openFromInput = false;
  bool _openFromImage = false;

  late Image2BinaryData _board;

  GCWFile? _originalData;

  Image.Image? _currentImage;

  BigInt _currentNumber = BigInt.zero;

  late TextEditingController _inputController;

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
        _buildWidgetDimensions(),
        _widgetBuildImageToNumber(),
        _openFromImage ? _widgetBuildOpenFromImage() : Container(),
        _openFromInput ? _widgetBuildOpenFromNumber() : Container(),
        _buildOutput(),
      ],
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
              icon: Icons.input,
              onPressed: () {
                _openFromInput = !_openFromInput;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              iconColor: themeColors().dialogText(),
              backgroundColor: themeColors().dialog(),
              size: IconButtonSize.SMALL,
              icon: Icons.file_download_outlined,
              onPressed: () {
                _openFromImage = !_openFromImage;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              iconColor: themeColors().dialogText(),
              backgroundColor: themeColors().dialog(),
              size: IconButtonSize.SMALL,
              icon: Icons.swap_vert,
              onPressed: () {
                setState(() {
                  _createBoardFromNumber(_swapVertical(convertBase(_board.getNumber().toString(), 10, 2).padLeft(_currentHeight * _currentWidth, '0')));
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              iconColor: themeColors().dialogText(),
              backgroundColor: themeColors().dialog(),
              size: IconButtonSize.SMALL,
              icon: Icons.swap_horiz,
              onPressed: () {
                setState(() {
                  _createBoardFromNumber(_swapHorizontal(convertBase(_board.getNumber().toString(), 10, 2).padLeft(_currentHeight * _currentWidth, '0')));
                });
              },
            ),
          ),
          Expanded(
            child: GCWIconButton(
              iconColor: themeColors().dialogText(),
              backgroundColor: themeColors().dialog(),
              size: IconButtonSize.SMALL,
              icon: Icons.save,
              onPressed: () {
                setState(() {
                  var input = binary2Image(convertBase(_board.getNumber().toString(), 10, 2).padLeft(_currentHeight * _currentWidth, '0'), customLines: _currentHeight, bounds: 0, pointSize: 1.0);
                  if (input == null) return;
                  input2Image(input).then((value) {
                    setState(() {
                      _exportFile(value);
                    });
                  });
                });
              },
            ),
          ),
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

  Widget _widgetBuildOpenFromNumber() {
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
              _createBoardFromNumber(numberToImage(_currentInput, _currentNumberType[_currentOption]!));
            });
          },
        ),
      ],
    );
  }

  void _createBoardFromNumber(String binary) {
    List<List<bool>> board = List<List<bool>>.generate(_currentHeight,
        (index) => List<bool>.generate(_currentWidth, (index) => false));
    for (int row = 0; row < _currentHeight; row++) {
      for (int column = 0; column < _currentWidth; column++) {
        board[row][column] = (binary[row * _currentWidth + column] != '0');
      }
    }
    _board = Image2BinaryData(
        content: board, width: _currentWidth, height: _currentHeight);
  }

  bool _validateData(Uint8List bytes) {
    return isImage(bytes);
  }

  Widget _widgetBuildOpenFromImage() {
    return GCWOpenFile(
      supportedFileTypes: SUPPORTED_IMAGE_TYPES,
      suppressGallery: false,
      onLoaded: (GCWFile? value) {
        if (value == null || !_validateData(value.bytes)) {
          showSnackBar(
              i18n(context, 'common_loadfile_exception_notloaded'), context);
          return;
        }

        setState(() {
          _originalData = value;
          _currentImage = _originalData?.bytes == null
              ? null
              : Image.decodeImage(_originalData!.bytes);

          _currentWidth = _currentImage!.width;
          _currentHeight = _currentImage!.height;

          List<List<bool>> board = List.generate(
            _currentHeight,
            (y) => List.generate(
              _currentWidth,
              (x) {
                Image.Pixel pixel = _currentImage!.getPixel(x, y);

                int r = pixel.r as int;
                int g = pixel.g as int;
                int b = pixel.b as int;

                int gray = ((r + g + b) / 3).round();

                return gray < 128;
              },
            ),
          );
          _board = Image2BinaryData(
              content: board, width: _currentWidth, height: _currentHeight);
        });
      },
    );
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(
        flexValues: [1,4],
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
    //}
  }

  Future<void> _exportFile(Uint8List data) async {
    await saveByteDataToFile(
            context, data, buildFileNameWithDate('img_', FileType.PNG))
        .then((value) {
      if (value) {
        showExportedFileDialog(context,
            contentWidget: imageContent(context, data));
      }
    });
  }

  String _swapHorizontal(String input) {
    List<String> lines = [];
    for (int i = 0; i < _currentHeight; i++) {
      var s = input.substring(i * _currentWidth, i * _currentWidth + _currentWidth);
      lines.add(s);
    }
    return lines.reversed.join('').split('').reversed.join('');
  }


  String _swapVertical(String input) {
    List<String> lines = [];
    for (int i = 0; i < _currentHeight; i++) {
      var s = input.substring(i * _currentWidth, i * _currentWidth + _currentWidth);
      lines.add(s);
    }
    return lines.reversed.join('');
  }
}
