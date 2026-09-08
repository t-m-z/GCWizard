import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';

class ProtocolBuffer extends StatefulWidget {
  const ProtocolBuffer({super.key});

  @override
  _ProtocolBufferState createState() => _ProtocolBufferState();
}

class _ProtocolBufferState extends State<ProtocolBuffer> {
  late TextEditingController _controller;

  String _currentInput = '';
  Map<String, String> _output = {'json' : '', 'detail': ''};

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWSubmitButton(onPressed: () {
            setState(() {
              _output = decryptProtocolBuffer(_currentInput);
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
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
  }
}
