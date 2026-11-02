import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/math_utils.dart';

class GCD extends StatefulWidget {
  const GCD({super.key});

  @override
  _GCDState createState() => _GCDState();
}

class _GCDState extends State<GCD> {
  late TextEditingController _inputController;

  var _currentInput = defaultIntegerListText;


  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput.text);
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
        GCWIntegerListTextField(controller: _inputController,
            onChanged: (text) {
              setState(() {
                _currentInput = text;
              });
            }),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
      child: _currentInput.value.isEmpty ? '' : gcdList(_currentInput.value).toString(),
    );
  }
}
