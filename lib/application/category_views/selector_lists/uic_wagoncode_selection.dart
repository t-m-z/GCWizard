import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_uic_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_countrycodes.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_freight_classifications.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_passenger_lettercodes.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_vkm.dart';

class UICWagonCodeSelection extends GCWSelection {
  const UICWagonCodeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        UICWagonCode,
        CheckDigitsUICSelection,
        UICWagonCodeCountryCodes,
        UICWagonCodeFreightClassifications,
        UICWagonCodePassengerLettercodes,
        UICWagonCodeVKM
      });

    return GCWToolList(toolList: _toolList);
  }
}
