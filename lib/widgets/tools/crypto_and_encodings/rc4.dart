import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rc4.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class RC4 extends StatefulWidget {
  @override
  RC4State createState() => RC4State();
}

class RC4State extends State<RC4> {
  String _currentInput = '';
  String _currentKey = '';

  var _currentInputFormat = InputFormat.AUTO;
  var _currentKeyFormat = InputFormat.AUTO;
  var _currentOutputFormat = OutputFormat.TEXT;

  @override
  Widget build(BuildContext context) {
    var rc4InputFormatItems = {
      InputFormat.AUTO: i18n(context, 'rc4_format_auto'),
      InputFormat.TEXT: i18n(context, 'rc4_format_text'),
      InputFormat.HEX: i18n(context, 'common_numeralbase_hexadecimal'),
      InputFormat.BINARY: i18n(context, 'common_numeralbase_binary'),
      InputFormat.ASCIIVALUES: i18n(context, 'rc4_format_asciivalues'),
    };

    var rc4OutputFormatItems = {
      OutputFormat.TEXT: i18n(context, 'rc4_format_text'),
      OutputFormat.HEX: i18n(context, 'common_numeralbase_hexadecimal'),
      OutputFormat.BINARY: i18n(context, 'common_numeralbase_binary'),
      OutputFormat.ASCIIVALUES: i18n(context, 'rc4_format_asciivalues'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        Row(children: <Widget>[
          Expanded(child: GCWText(text: i18n(context, 'rc4_format') + ':'), flex: 1),
          Expanded(
              child: GCWDropDownButton(
                value: _currentInputFormat,
                onChanged: (value) {
                  setState(() {
                    _currentInputFormat = value;
                  });
                },
                items: rc4InputFormatItems.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: mode.value,
                  );
                }).toList(),
              ),
              flex: 2),
        ]),
        GCWTextDivider(text: i18n(context, 'common_key')),
        GCWTextField(
          hintText: i18n(context, 'common_key'),
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        Row(children: <Widget>[
          Expanded(child: GCWText(text: i18n(context, 'rc4_format') + ':'), flex: 1),
          Expanded(
              child: GCWDropDownButton(
                value: _currentKeyFormat,
                onChanged: (value) {
                  setState(() {
                    _currentKeyFormat = value;
                  });
                },
                items: rc4InputFormatItems.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: mode.value,
                  );
                }).toList(),
              ),
              flex: 2),
        ]),
        GCWTextDivider(text: i18n(context, 'common_output') + ' ' + i18n(context, 'rc4_format')),
        Row(children: <Widget>[
          Expanded(child: GCWText(text: i18n(context, 'rc4_format') + ':'), flex: 1),
          Expanded(
              child: GCWDropDownButton(
                value: _currentOutputFormat,
                onChanged: (value) {
                  setState(() {
                    _currentOutputFormat = value;
                  });
                },
                items: rc4OutputFormatItems.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: mode.value,
                  );
                }).toList(),
              ),
              flex: 2),
        ]),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentInput == null || _currentInput.length == 0) {
      return GCWDefaultOutput();
    }

    var _currentOutput =
        cryptRC4(_currentInput, _currentInputFormat, _currentKey, _currentKeyFormat, _currentOutputFormat);

    if (_currentOutput == null) {
      return GCWDefaultOutput();
    } else if (_currentOutput.errorCode != ErrorCode.OK) {
      switch (_currentOutput.errorCode) {
        case ErrorCode.MISSING_KEY:
          showToast(i18n(context, 'rc4_error_missing_key'));
          break;
        case ErrorCode.KEY_FORMAT:
          showToast(i18n(context, 'rc4_error_key_format'));
          break;
        case ErrorCode.INPUT_FORMAT:
          showToast(i18n(context, 'rc4_error_input_format'));
          break;
      }
      return GCWDefaultOutput();
    }
    ;

    return GCWDefaultOutput(
      child: _currentOutput.output,
    );
  }
}
