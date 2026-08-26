import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/heat_index/widget/heat_index.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/humidex/widget/humidex.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/summer_simmer/widget/summer_simmer.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/widget/wbgt.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_temperature/widget/wet_bulb_temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/windchill/widget/windchill.dart';

class ApparentTemperatureSelection extends GCWSelection {
  const ApparentTemperatureSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        HeatIndex,
        Humidex,
        SummerSimmerIndex,
        Windchill,
        WetBulbTemperature,
        WBGT,
       });

    return GCWToolList(toolList: _toolList);
  }
}
