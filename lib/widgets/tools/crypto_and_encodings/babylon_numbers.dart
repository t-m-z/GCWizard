import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/babylon_numbers.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/babylon_numbers_segment_display.dart';

class BabylonNumbers extends StatefulWidget {
  @override
  BabylonNumbersState createState() => BabylonNumbersState();
}

class BabylonNumbersState extends State<BabylonNumbers> {
  var _currentEncodeInput = 0;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

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
              overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
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
    Map<String, bool> currentDisplay;

    var displays = _currentDisplays;
    if (displays != null && displays.length > 0)
      currentDisplay = Map<String, bool>.fromIterable(displays.last ?? [], key: (e) => e, value: (e) => true);
    else
      currentDisplay = {};

    var onChanged = (Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;
          newSegments.add(key);
        });

        newSegments.sort();

        if (_currentDisplays.length == 0) _currentDisplays.add([]);

        _currentDisplays[_currentDisplays.length - 1] = newSegments;
      });
    };

    return Column(
      children: <Widget>[
        Container(
          width: 200,
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: BabylonNumbersSegmentDisplay(
                  segments: currentDisplay,
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
                _currentDisplays.add([]);
              });
            },
          ),
          GCWIconButton(
            icon: Icons.backspace,
            onPressed: () {
              setState(() {
                if (_currentDisplays.length > 0) _currentDisplays.removeLast();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.clear,
            onPressed: () {
              setState(() {
                _currentDisplays = [];
              });
            },
          )
        ])
      ],
    );
  }

  Widget _buildDigitalOutput(List<List<String>> segments) {
    return GCWSegmentDisplayOutput(
        segmentFunction: (displayedSegments, readOnly) {
          return BabylonNumbersSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
        },
        segments: segments,
        readOnly: true);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      var segments = encodeBabylonNumbers(_currentEncodeInput);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      var segments = decodeBabylonNumbers(output);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments['displays']),
          GCWOutput(title: i18n(context, 'babylonnumbers_single_numbers'), child: segments['numbers'].join(' ')),
          GCWOutput(title: i18n(context, 'babylonnumbers_sexagesimal'), child: segments['sexagesimal'])
        ],
      );
    }
  }
}
