import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_creditcard_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_de_taxid_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_ean_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_euro_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_iban_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_imei_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_isbn_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_uic_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';

class CheckDigitsSelection extends GCWSelection {
  const CheckDigitsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        CheckDigitsCreditCardSelection,
        CheckDigitsEANSelection,
        CheckDigitsEUROSelection,
        CheckDigitsIBANSelection,
        CheckDigitsIMEISelection,
        CheckDigitsISBNSelection,
        CheckDigitsDETaxIDSelection,
        CheckDigitsUICSelection
      });

    return GCWToolList(toolList: _toolList);
  }
}
