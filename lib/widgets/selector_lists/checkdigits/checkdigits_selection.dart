import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_de_persid_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_de_taxid_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_ean_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_euro_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_iban_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_imei_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/checkdigits/checkdigits_isbn_selection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CheckDigitsSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(CheckDigitsISBNSelection()),
        className(CheckDigitsIBANSelection()),
        className(CheckDigitsIMEISelection()),
        className(CheckDigitsEANSelection()),
        className(CheckDigitsEUROSelection()),
        className(CheckDigitsDEPersIDSelection()),
        className(CheckDigitsDETaxIDSelection()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
