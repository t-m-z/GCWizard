import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/guitar_strings.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:tuple/tuple.dart';

class GuitarStrings extends StatefulWidget {
  @override
  GuitarStringsState createState() => GuitarStringsState();
}

class GuitarStringsState extends State<GuitarStrings> {
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  var _currentEncryptionText = '';
  var _encryptionController;

  int _currentString = 0;
  int _currentFret = 0;

  var _currentTones = <Tuple2<GuitarStringName, int>>[];

  @override
  void initState() {
    super.initState();
    _encryptionController = TextEditingController(text: _currentEncryptionText);
  }

  @override
  void dispose() {
    _encryptionController.dispose();
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
        _currentMode == GCWSwitchPosition.left ? _buildEncryption() : _buildDecryption()
      ],
    );
  }

  _buildEncryption() {
    return Column(children: [
      GCWTextField(
        controller: _encryptionController,
        onChanged: (value) {
          setState(() {
            _currentEncryptionText = value;
          });
        },
      ),
      _buildEncryptionOutput()
    ]);
  }

  _buildEncryptionOutput() {
    var _tabs = textToGuitarTabs(_currentEncryptionText);
    if (_tabs == null || _tabs.isEmpty) return Container();

    return _buildASCIITabs(_tabs, i18n(context, 'common_output'));
  }

  String _bOrH() {
    return i18n(context, 'symboltables_notes_names_trebleclef_14');
  }

  _buildDecryption() {
    var tabs = List<Tuple2<GuitarStringName, int>>.from(_currentTones);
    tabs.add(Tuple2(_stringNameFromIndex(_currentString), _currentFret));

    return Column(
      children: [
        GCWDropDownSpinner(
          title: i18n(context, 'guitarstrings_string'),
          index: _currentString,
          items: [0, 1, 2, 3, 4, 5].map((stringName) {
            switch (stringName) {
              case 0:
                return '1: e\' (E4)';
              case 1:
                return '2: ${_bOrH().toLowerCase()} (${_bOrH().toUpperCase()}3)';
              case 2:
                return '3: g (G3)';
              case 3:
                return '4: d (D3)';
              case 4:
                return '5: A (A2)';
              case 5:
                return '6: E (E2)';
            }
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentString = value;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'guitarstrings_fret'),
          value: _currentFret,
          min: 0,
          max: 12,
          onChanged: (value) {
            setState(() {
              _currentFret = value;
            });
          },
        ),
        GCWToolBar(children: [
          GCWIconButton(
            icon: Icons.space_bar,
            onPressed: () {
              setState(() {
                var stringName = _stringNameFromIndex(_currentString);
                _currentTones.add(Tuple2(stringName, _currentFret));
              });
            },
          ),
          GCWIconButton(
            icon: Icons.backspace,
            onPressed: () {
              setState(() {
                if (_currentTones.length > 0) _currentTones.removeLast();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.clear,
            onPressed: () {
              setState(() {
                _currentTones = [];
              });
            },
          )
        ]),
        _buildASCIITabs(
          tabs,
          i18n(context, 'guitarstrings_tabs'),
        ),
        GCWDefaultOutput(
          child: _buildDecryptionOutput(),
        )
      ],
    );
  }

  _stringNameFromIndex(int index) {
    return GuitarStringName.values[_currentString];
  }

  _buildDecryptionOutput() {
    var outputTones = List<Tuple2<GuitarStringName, int>>.from(_currentTones);
    outputTones.add(Tuple2(_stringNameFromIndex(_currentString), _currentFret));

    return outputTones.map((tone) {
      return i18n(context, GUITAR_STRING_NOTES[tone]);
    }).join(' ');
  }

  _buildASCIITabs(List<Tuple2<GuitarStringName, int>> tabs, String title) {
    var out = {
      GuitarStringName.E4: 'E |-',
      GuitarStringName.H3: '${_bOrH().toUpperCase()} |-',
      GuitarStringName.G3: 'G |-',
      GuitarStringName.D3: 'D |-',
      GuitarStringName.A2: 'A |-',
      GuitarStringName.E2: 'E |-',
    };

    tabs.forEach((tone) {
      for (var outItem in out.keys) {
        if (outItem == tone.item1) {
          out[outItem] += tone.item2.toString().padRight(2, '-') + '-';
        } else {
          out[outItem] += '---';
        }
      }
    });

    var outputText = out.values.join('\n');

    return GCWOutput(
        title: title,
        child: Row(
          children: [
            Expanded(
                child: AutoSizeText(
              outputText,
              minFontSize: 5,
              style: gcwMonotypeTextStyle(),
              maxLines: 6,
            )),
            outputText != null && outputText.length > 0
                ? GCWIconButton(
                    size: IconButtonSize.SMALL,
                    icon: Icons.content_copy,
                    onPressed: () {
                      insertIntoGCWClipboard(context, outputText);
                    },
                  )
                : Container()
          ],
        ));
  }
}
