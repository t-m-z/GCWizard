import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/easter_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/astrotimes/widget/astrotimes.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/iau_constellation/widget/iau_all_constellations.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_position/widget/moon_position.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_rise_set/widget/moon_rise_set.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/right_ascension_to_degree/widget/right_ascension_to_degree.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/seasons/widget/seasons.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/shadow_length/widget/shadow_length.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/widget/sun_position.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_rise_set/widget/sun_rise_set.dart';

class AstronomySelection extends GCWSelection {
  const AstronomySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        IAUAllConstellations,
        SunRiseSet,
        SunPosition,
        MoonRiseSet,
        MoonPosition,
        EasterSelection,
        Seasons,
        ShadowLength,
        AstroTimes,
        RightAscensionToDegree
      });

    return GCWToolList(toolList: _toolList);
  }
}
