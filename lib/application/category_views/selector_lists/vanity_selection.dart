import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_multitap/widget/vanity_multitap.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_singletap/widget/vanity_singletap.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_words_list/widget/vanity_words_list.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_words_search/widget/vanity_words_search.dart';

class VanitySelection extends GCWSelection {
  const VanitySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        VanitySingletap,
        VanityMultitap,
        VanityWordsList,
        VanityWordsTextSearch
      });

    return GCWToolList(toolList: _toolList);
  }
}
