import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/science_and_technology/lueneburg_calculation_table/logic/lueneburg_calculation_table.dart';
import 'package:gc_wizard/tools/science_and_technology/lueneburg_calculation_table/widget/lueneburg_calculation_table_display.dart';

import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';

class LuenebuergCalculationTable extends StatefulWidget {
  const LuenebuergCalculationTable({super.key});

  @override
  _LuenebuergCalculationTableState createState() =>
      _LuenebuergCalculationTableState();
}

class _LuenebuergCalculationTableState extends State<LuenebuergCalculationTable> {
  var _currentDisplays = Segments.Empty();

  var _currentMode = GCWSwitchPosition.left;

    @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[_buildVisualDecryption(), _buildOutput()]);
  }

  Widget _buildVisualDecryption() {
    var currentDisplay = buildSegmentMap(_currentDisplays);

    onChanged(Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;
          newSegments.add(key);
        });

        _currentDisplays.replaceLastSegment(newSegments);
      });
    }

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: '+',
          rightValue: '-',
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        Container(
          width: 600,
          height: 250,
          padding: const EdgeInsets.only(
              top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MICSegmentDisplay(
                  segments: currentDisplay,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOutput() {
    var output = _currentDisplays.buildOutput();
    List<int> calculated = calculateLueneburgTable(
      output, (_currentMode == GCWSwitchPosition.left)
    );
    int result = _roman(calculated);
    var outputDisplay = _buildVisualOutput(calculated);
    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: result.toString(),
        ),
        Container(
          width: 600,
          height: 250,
          padding: const EdgeInsets.only(
              top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MICSegmentDisplay(
                  segments: outputDisplay,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  int _roman(List<int> r){
    return r[0] * 1000 + r[1] * 500 + r[2] * 100 + r[3] * 50 + r[4] * 10 + r[5] * 5 + r[6];
  }

  Map<String, bool> _buildVisualOutput(List<int> input){
      return {};
  }

}