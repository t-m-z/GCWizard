import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_calling_codes/widget/countries_calling_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_embassycodes_ger/widget/countries_embassycodes_ger.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_ioc_codes/widget/countries_ioc_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_iso_codes/widget/countries_iso_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_vehicle_codes/widget/countries_vehicle_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/country_flags/widget/country_flags.dart';

class CountriesSelection extends GCWSelection {
  const CountriesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        CountriesCallingCodes,
        CountriesIOCCodes,
        CountriesISOCodes,
        CountriesVehicleCodes,
        CountriesFlags,
        CountriesEmbassyCodesGER
      });

    return GCWToolList(toolList: sortTools(_toolList));
  }
}
