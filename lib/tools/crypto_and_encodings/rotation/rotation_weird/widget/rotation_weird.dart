import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotation_weird/logic/rotation_weird.dart';

class RotationWeird extends StatefulWidget {
  const RotationWeird({super.key});

  @override
  _RotationWeirdState createState() => _RotationWeirdState();
}

class _RotationWeirdState extends State<RotationWeird> {
  late TextEditingController _controller;
  late TextEditingController _rotateController;

  String _currentInput = '';
  String _currentRotate = '';

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: _currentInput);
    _rotateController = TextEditingController(text: _currentRotate);
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
          hintText: i18n(context, 'rotation_weird_text'),
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          controller: _rotateController,
          hintText: i18n(context, 'rotation_weird_rotation'),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),],
          onChanged: (text) {
            setState(() {
              _currentRotate = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentInput.isEmpty) return const GCWDefaultOutput();
    if (_currentRotate.isEmpty) return const GCWDefaultOutput();

    Map<String, String> result = rotationWeird(_currentInput, _currentRotate);

    return Column(
      children: [
        GCWDefaultOutput(
          child: result['ADD'],
        ),
        GCWDefaultOutput(
          child: result['SUB'],
        ),
      ],
    );
  }
}
