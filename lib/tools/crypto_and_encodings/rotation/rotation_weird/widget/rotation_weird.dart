import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

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

  final defaultAlphabetAlpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final extendedAlphabetDigits = 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜß';

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

  String _rotate(String char, int key, String alphabet) {
    var alphabetLength = alphabet.length;
    var index = alphabet.indexOf(char);
    var newIndex = (index + key) % alphabetLength;
    return alphabet[newIndex];
  }

  Widget _buildOutput() {
    if (_currentInput.isEmpty) return const GCWDefaultOutput();
    if (_currentRotate.isEmpty) return const GCWDefaultOutput();

    List<int?> rotateData = [];
    try {
      rotateData = _currentRotate.split(' ').map((character) {
        if (int.tryParse(character) != null){
          return int.parse(character);
        }
      }).toList();
    } catch (e) {
      rotateData = [];
    }


    String alphabet = defaultAlphabetAlpha;

    _currentInput = _currentInput.toUpperCase();

    if (_currentInput.contains('Ä') || _currentInput.contains('Ö') || _currentInput.contains('Ü')) {
      alphabet = extendedAlphabetDigits;
    }

    String resultAdd = '';
    String resultSub = '';

    int key = rotateData.length;

    int i = 0;
    int j = 0;
    while (i < _currentInput.length) {

      if (alphabet.contains(_currentInput[i])) {
        resultAdd = resultAdd + _rotate(_currentInput[i], rotateData[j % key]!, alphabet);
        resultSub = resultSub + _rotate(_currentInput[i], -rotateData[j % key]!, alphabet);
        j++;
      } else {
        resultAdd = resultAdd + _currentInput[i];
        resultSub = resultSub + _currentInput[i];
      }
      i++;
    }

    return Column(
      children: [
        GCWDefaultOutput(
          child: resultAdd,
        ),
        GCWDefaultOutput(
          child: resultSub,
        ),
      ],
    );
  }
}
