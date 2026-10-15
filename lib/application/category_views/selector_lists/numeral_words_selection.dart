import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_converter/widget/numeral_words_converter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_identify_languages/widget/numeral_words_identify_languages.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_lists/widget/numeral_words_lists.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_text_search/widget/numeral_words_text_search.dart';

class NumeralWordsSelection extends GCWSelection {
  const NumeralWordsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumeralWordsTextSearch,
        NumeralWordsLists,
        NumeralWordsIdentifyLanguages,
        NumeralWordsConverter
      });

    return GCWToolList(toolList: _toolList);
  }
}
