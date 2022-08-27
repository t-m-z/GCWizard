import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/shadoks_numbers.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/shadoks_numbers_segment_display.dart';

class ShadoksNumbers extends StatefulWidget {
  @override
  ShadoksNumbersState createState() => ShadoksNumbersState();
}

class ShadoksNumbersState extends State<ShadoksNumbers> {
  final Map<String, String> _segmentToWord = {
    'a': 'GA',
    'b': 'BU',
    'bc': 'ZO',
    'bcd': 'MEU',
  };

  var _currentEncodeInput = 0;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

  Map<String, bool> _currentDisplay = {};

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.left // encrypt: input number => output segment
          ? GCWIntegerSpinner(
              min: 0,
              value: _currentEncodeInput,
              onChanged: (value) {
                setState(() {
                  _currentEncodeInput = value;
                });
              },
            )
          : Column(
              // decrpyt: input segment => output number
              children: <Widget>[_buildVisualDecryption()],
            ),
      _buildOutput()
    ]);
  }

  _buildVisualDecryption() {
    var onChanged = (Map<String, bool> d) {
      setState(() {
        _currentDisplay = d;

        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;
          newSegments.add(key);
        });

        newSegments.sort();
        if (newSegments.length > 1) newSegments.remove('a');

        if (_currentDisplays.length == 0) _currentDisplays.add([]);

        _currentDisplays[_currentDisplays.length - 1] = newSegments;
      });
    };

    return Column(
      children: <Widget>[
        Container(
          width: 180,
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ShadoksNumbersSegmentDisplay(
                  segments: _currentDisplay,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        ),
        GCWToolBar(children: [
          GCWIconButton(
            icon: Icons.space_bar,
            onPressed: () {
              setState(() {
                _currentDisplays.add(['a']);
                _currentDisplay = {'a': true};
              });
            },
          ),
          GCWIconButton(
            icon: Icons.backspace,
            onPressed: () {
              setState(() {
                if (_currentDisplays.length > 0) {
                  _currentDisplays.removeLast();
                }

                if (_currentDisplays.length > 0) {
                  _currentDisplay = {};
                  _currentDisplays.last.forEach((element) => _currentDisplay.putIfAbsent(element, () => true));
                  _currentDisplay.putIfAbsent('a', () => false);
                } else {
                  _currentDisplays = [
                    ['a']
                  ];
                  _currentDisplay = {'a': true};
                }
              });
            },
          ),
          GCWIconButton(
            icon: Icons.clear,
            onPressed: () {
              setState(() {
                _currentDisplays = [
                  ['a']
                ];
                _currentDisplay = {'a': true};
              });
            },
          )
        ])
      ],
    );
  }

  String _segmentsToShadoks(List<List<String>> segments) {
    String result = '';
    segments.forEach((element) {
      result = result + _segmentToWord[element.join('')];
    });
    return result;
  }

  Widget _ShadoksNumbersSegmentDisplay({Map<String, bool> segments, bool readOnly, bool tapeStyle}) {
    segments.putIfAbsent('a', () => false);
    return ShadoksNumbersSegmentDisplay(segments: segments, readOnly: true);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      var segments = encodeShadoksNumbers(_currentEncodeInput);

      return Column(
        children: <Widget>[
          GCWSegmentDisplayOutput(
              segmentFunction: (displayedSegments, readOnly) {
                return _ShadoksNumbersSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
              },
              segments: segments,
              readOnly: true),
          GCWOutput(
              title: i18n(context, 'shadoksnumbers_single_numbers'),
              child: _segmentsToShadoks(segments)
                  .replaceAll('GA', '0')
                  .replaceAll('BU', '1')
                  .replaceAll('ZO', '2')
                  .replaceAll('MEU', '3')),
          GCWOutput(title: i18n(context, 'shadoksnumbers_shadoks'), child: _segmentsToShadoks(segments))
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();

      var segments = decodeShadoksNumbers(output);

      return Column(
        children: <Widget>[
          GCWSegmentDisplayOutput(
              segmentFunction: (displayedSegments, readOnly) {
                return _ShadoksNumbersSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
              },
              segments: segments['displays'],
              readOnly: true),
          GCWOutput(title: i18n(context, 'shadoksnumbers_single_numbers'), child: segments['numbers'].join(' ')),
          GCWOutput(title: i18n(context, 'shadoksnumbers_quaternary'), child: segments['quaternary']),
          GCWOutput(title: i18n(context, 'shadoksnumbers_shadoks'), child: segments['shadoks'])
        ],
      );
    }
  }
}
