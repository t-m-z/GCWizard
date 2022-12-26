import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/qr_code.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';

import 'gcw_exported_file_dialog.dart';

enum TextExportMode { TEXT, QR }

enum PossibleExportMode { TEXTONLY, QRONLY, BOTH }

class GCWTextExport extends StatefulWidget {
  final String text;
  final Function onModeChanged;
  final PossibleExportMode possibileExportMode;
  final TextExportMode initMode;

  const GCWTextExport(
      {Key key,
      this.text,
      this.onModeChanged,
      this.possibileExportMode = PossibleExportMode.BOTH,
      this.initMode = TextExportMode.QR})
      : super(key: key);

  @override
  GCWTextExportState createState() => GCWTextExportState();
}

class GCWTextExportState extends State<GCWTextExport> {
  var _currentMode = TextExportMode.QR;

  TextEditingController _textExportController;
  var _currentExportText;

  Uint8List _qrImageData;

  @override
  void initState() {
    super.initState();

    _currentExportText = widget.text ?? '';
    _currentMode = widget.initMode;
    _textExportController = TextEditingController(text: _currentExportText);
  }

  @override
  void dispose() {
    _textExportController.dispose();

    super.dispose();
  }

  _buildQRCode() {
    generateBarCode(_currentExportText).then((qr_code) {
      setState(() {
        _qrImageData = qr_code;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentMode == TextExportMode.QR && _qrImageData == null) _buildQRCode();

    return Container(
        width: 300,
        height: 360,
        child: Column(
          children: <Widget>[
            widget.possibileExportMode == PossibleExportMode.BOTH
                ? GCWTwoOptionsSwitch(
                    leftValue: 'QR',
                    rightValue: i18n(context, 'common_text'),
                    alternativeColor: true,
                    value: _currentMode == TextExportMode.QR ? GCWSwitchPosition.left : GCWSwitchPosition.right,
                    onChanged: (value) {
                      setState(() {
                        _currentMode = value == GCWSwitchPosition.left ? TextExportMode.QR : TextExportMode.TEXT;
                        if (widget.onModeChanged != null) widget.onModeChanged(_currentMode);

                        if (_currentMode == TextExportMode.QR) _buildQRCode();
                      });
                    },
                  )
                : Container(),
            _currentMode == TextExportMode.QR
                ? (_qrImageData == null ? Container() : Image.memory(_qrImageData))
                : Column(
                    children: <Widget>[
                      GCWTextField(
                        controller: _textExportController,
                        filled: true,
                        maxLines: 10,
                        fontSize: 10.0,
                        onChanged: (value) {
                          setState(() {
                            _currentExportText = value;
                          });
                        },
                      ),
                      GCWButton(
                        text: i18n(context, 'common_copy'),
                        onPressed: () {
                          insertIntoGCWClipboard(context, _currentExportText);
                        },
                      )
                    ],
                  ),
          ],
        ));
  }
}

exportFile(String text, TextExportMode mode, BuildContext context) {
  _exportEncryption(context, text, mode).then((value) {
    if (value == null) {
      return;
    }

    showExportedFileDialog(
      context,
      contentWidget: mode == TextExportMode.QR
          ? Container(
              child: value == null ? null : Image.memory(value),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(border: Border.all(color: themeColors().dialogText())),
            )
          : null,
    );
  });
}

Future<dynamic> _exportEncryption(BuildContext context, String text, TextExportMode mode) async {
  if (mode == TextExportMode.TEXT) {
    return saveStringToFile(context, text, 'txt_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.txt');
  } else {
    final data = await generateBarCode(text);

    return await saveByteDataToFile(
        context, data, 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');
  }
}
