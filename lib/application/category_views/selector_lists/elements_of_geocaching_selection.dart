import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/atomic_numbers_to_text/widget/atomic_numbers_to_text.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/periodic_table/widget/elements_of_geocaching.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/periodic_table_data_view/widget/elements_of_geocaching_data_view.dart';

class ElementsOfGeocachingSelection extends GCWSelection {
  const ElementsOfGeocachingSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        ElementsOfGeocaching,
        ElementsOfGeocachingDataView,
        AtomicNumbersToText
      });

    return GCWToolList(toolList: _toolList);
  }
}
