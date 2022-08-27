import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/qr_code.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/gcw_file.dart';
import 'package:intl/intl.dart';

class QrCode extends StatefulWidget {
  final GCWFile platformFile;

  const QrCode({Key key, this.platformFile}) : super(key: key);

  @override
  QrCodeState createState() => QrCodeState();
}

class QrCodeState extends State<QrCode> {
  var _currentInput = '';
  var _currentModulSize = 5;
  Uint8List _outData;
  Uint8List _outDataEncrypt;
  String _outDataDecrypt;
  TextEditingController _inputController;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  static int maxLength = 2952;
  var lastCurrentInputLength = 0;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    if (widget.platformFile != null) {
      _currentMode = GCWSwitchPosition.right;
      _outData = widget.platformFile.bytes;
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
                    showToast(i18n(context, 'common_loadfile_exception_notloaded'));
                    return;
                  }

                  if (_file != null) {
                    setState(() {
                      _outData = _file.bytes;
                      _updateOutput();
                    });
                  }
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
                child: Image.memory(_outData),
                padding: EdgeInsets.symmetric(vertical: 20),
              )
            : Container(),
        _currentMode == GCWSwitchPosition.right
            ? Container()
            : GCWIntegerSpinner(
                title: i18n(context, 'qr_code_modulsize'),
                value: _currentModulSize,
                min: 1,
                max: 100,
                onChanged: (value) {
                  _currentModulSize = value;
                  _updateOutput();
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
        GCWDefaultOutput(
            child: _buildOutput(),
            trailing: (_currentMode == GCWSwitchPosition.right)
                ? null
                : GCWIconButton(
                    icon: Icons.save,
                    size: IconButtonSize.SMALL,
                    iconColor: _outDataEncrypt == null ? themeColors().inActive() : null,
                    onPressed: () {
                      _outDataEncrypt == null ? null : _exportFile(context, _outDataEncrypt);
                    },
                  ))
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_outDataEncrypt == null) return null;
      return Image.memory(_outDataEncrypt);
    } else
      return _outDataDecrypt;
  }

  _updateOutput() {
    try {
      if (_currentMode == GCWSwitchPosition.left) {
        var currentInput = _currentInput;
        if ((currentInput != null) && (currentInput.length > maxLength) && (lastCurrentInputLength <= maxLength)) {
          currentInput = currentInput.substring(0, maxLength);
          showToast(i18n(context, 'qr_code_length_limited', parameters: [maxLength.toString()]));
        }
        lastCurrentInputLength = _currentInput == null ? 0 : _currentInput.length;

        generateBarCode(currentInput, moduleSize: _currentModulSize, border: 2 * _currentModulSize).then((qr_code) {
          setState(() {
            _outDataEncrypt = qr_code;
          });
        });
      } else {
        if (_outData == null) return;

        scanBytes(_outData).then((text) {
          setState(() {
            if (text == null || text.isEmpty) text = i18n(context, 'qr_code_nothingfound');

            _outDataDecrypt = text;
          });
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    var value = await saveByteDataToFile(
        context, data, "img_" + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

    if (value != null) showExportedFileDialog(context, fileType: fileType);
  }
}
