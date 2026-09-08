import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';

class ProtocolBuffer extends StatefulWidget {
  const ProtocolBuffer({super.key});

  @override
  _ProtocolBufferState createState() => _ProtocolBufferState();
}

class _ProtocolBufferState extends State<ProtocolBuffer> {
  late TextEditingController _controllerDecrypt;
  late TextEditingController _controllerEncrypt;

  var _currentMode = GCWSwitchPosition.right;

  var _currentCountFields = 1;
  final _currentFields = [''];

  String _currentInputEncrypt = '';
  String _currentInputDecrypt = '';
  Map<String, String> _output = {'json' : '', 'detail': ''};

  @override
  void initState() {
    super.initState();

    _controllerDecrypt = TextEditingController(text: _currentInputDecrypt);
    _controllerEncrypt = TextEditingController(text: _currentInputEncrypt);
  }

  @override
  void dispose() {
    _controllerDecrypt.dispose();
    _controllerEncrypt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
        ? _buildDecryptWidget()
        : _buildEncryptWidget(),
        GCWSubmitButton(onPressed: () {
            setState(() {
              if (_currentMode == GCWSwitchPosition.right) {
                _output = decryptProtocolBuffer(_currentInputDecrypt);
              } else {
                _output = encryptProtolBuffer(_currentFields);
              }
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildDecryptWidget(){
    return GCWTextField(
      controller: _controllerDecrypt,
      onChanged: (text) {
        setState(() {
          _currentInputDecrypt = text;
        });
      },
    );
  }

  Widget _buildEncryptWidget(){
    var fieldWidgets = List.generate(
        _currentCountFields,
            (index) => GCWTextField(
          title: i18n(context, 'protocolbuffer_datafield') + ' ' + (index + 1).toString(),
          onChanged: (ret) {
            setState(() {
              _currentFields[index] = ret;
            });
          },
        ));
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'protocolbuffer_number_datafield'),
        ),
        GCWIntegerSpinner(
          value: _currentCountFields,
          min: 1,
          overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
          onChanged: (value) {
            setState(() {
              while (value < _currentCountFields) {
                _currentFields.removeLast();
                _currentCountFields--;
              }

              while (value > _currentCountFields) {
                _currentFields.add('');
                _currentCountFields++;
              }
            });
          },
        ),
        Column(
          children: fieldWidgets,
        ),
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      return Column(
        children: [
          GCWDefaultOutput(child: _output['json']),
          GCWExpandableTextDivider(
            text: i18n(context, 'common_details'),
            expanded: false,
            suppressTopSpace: false,
            child: GCWOutputText(
              text: _output['detail'],
            ),
          )
        ],
      );
    } else {
      return Column(
        children: [
          GCWDefaultOutput(child: _output['hex']),
          GCWExpandableTextDivider(
            text: i18n(context, 'common_details'),
            expanded: false,
            suppressTopSpace: false,
            child: GCWOutputText(
              text: _output['detail'],
            ),
          )
        ],
      );
    }

  }
}
