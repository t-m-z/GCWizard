import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';

class JabCode extends StatefulWidget {
  final GCWFile? platformFile;

  const JabCode({super.key, this.platformFile});

  @override
  JabCodeState createState() => JabCodeState();
}

class JabCodeState extends State<JabCode> {
  var _currentInput = '';
  var _currentExpanded = false;
  var _currentModulSize = 12;
  var _currentColorCount = 8;
  var _currentEccLevel = 3;
  Uint8List? _outData;
  Uint8List? _outDataEncrypt;
  String? _outDataDecrypt;
  late TextEditingController _inputController;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  var lastCurrentInputLength = 0;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    if (widget.platformFile != null) {
      _currentMode = GCWSwitchPosition.right;
      _outData = widget.platformFile?.bytes;
      _updateOutput();
    }
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
        _currentMode == GCWSwitchPosition.right
            ? GCWOpenFile(
                supportedFileTypes: SUPPORTED_IMAGE_TYPES,
                onLoaded: (_file) {
                  if (_file == null) {
                    showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
                    return;
                  }

                  setState(() {
                    _outData = _file.bytes;
                    _updateOutput();
                  });
                },
              )
            : GCWTextField(
                controller: _inputController,
                onChanged: (value) {
                  setState(() {
                    _currentInput = value;
                    _updateOutput();
                  });
                },
              ),
        ((_currentMode == GCWSwitchPosition.right) && (_outData != null))
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.memory(_outData!),
              )
            : Container(),
        _currentMode == GCWSwitchPosition.right ? Container() : _buildAdvancedWidget(),
        _currentMode == GCWSwitchPosition.right
            ? Container()
            : Column(children: [
          GCWIntegerSpinner(
            title: i18n(context, 'qr_code_modulsize'),
            flexValues: const [1, 1],
            value: _currentModulSize,
            min: 1,
            max: 100,
            onChanged: (value) {
              _currentModulSize = value;
              _updateOutput();
            },
          ),
        ]),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(
            trailing: (_currentMode == GCWSwitchPosition.right)
                ? null
                : GCWIconButton(
                    icon: Icons.save,
                    size: IconButtonSize.SMALL,
                    iconColor: _outDataEncrypt == null ? themeColors().inactive() : null,
                    onPressed: () {
                      _outDataEncrypt == null ? null : _exportFile(context, _outDataEncrypt!);
                    },
                  ),
            child: _buildOutput())
      ],
    );
  }

  Widget _buildAdvancedWidget() {
    return Column(
        children: [
          GCWExpandableTextDivider(
            text: i18n(context, 'common_mode_advanced'),
            expanded: _currentExpanded,
            onChanged: (value) {
              setState(() {
                _currentExpanded = value;
                });
              },
            child: Column(children: [
              GCWDropDown<int>(
                title: i18n(context, 'colors_title'),
                flexValues: const [1, 1],
                value: _currentColorCount,
                onChanged: (value) {
                  setState(() {
                    _currentColorCount = value;
                    _updateOutput();
                  });
                },
                items: {4, 8}.map((colorCount) {
                  return GCWDropDownMenuItem(
                    value: colorCount,
                    child: colorCount,
                    );
                  }).toList()),
              GCWIntegerSpinner(
                title: i18n(context, 'qr_code_error_correct_level'),
                flexValues: const [1, 1],
                value: _currentEccLevel,
                min: 0,
                max: 10,
                onChanged: (value) {
                  _currentEccLevel = value;
                  _updateOutput();
                },
              ),
            ])
          )
      ]);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_outDataEncrypt == null) return Container();
      return Image.memory(_outDataEncrypt!);
    } else {
      return GCWText(text: _outDataDecrypt ?? '');
    }
  }

  void _updateOutput() {
    try {
      if (_currentMode == GCWSwitchPosition.left) {
        var currentInput = _currentInput;
        lastCurrentInputLength = _currentInput.length;

        generateJabCode(currentInput, moduleSize: _currentModulSize, colorCount: _currentColorCount,
            eccLevel: _currentEccLevel, border: 2 * _currentModulSize).then((jabcode) {
          setState(() {
            _outDataEncrypt = jabcode;
          });
        });
      } else {
        if (_outData == null) return;

        scanBytes(_outData!).then((data) {
          setState(() {
            String text = '';
            if (data?.Data == null || data!.Data!.isEmpty) {
              text = i18n(context, 'jab_code_nothingfound');
              if (data?.DecodeStatus != null) text +="\n" + data!.DecodeStatus!;
            } else {
              text = data.Data!;
            }
            _outDataDecrypt = text;
          });
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    await saveByteDataToFile(context, data, buildFileNameWithDate('img_', fileType)).then((value) {
      var content = fileClass(fileType) == FileClass.IMAGE ? imageContent(context, data) : null;
      if (value) showExportedFileDialog(context, contentWidget: content);
    });
  }
}
