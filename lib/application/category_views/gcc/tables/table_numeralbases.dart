import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';

class GCCTableNumeralBasesNames extends StatefulWidget {
  const GCCTableNumeralBasesNames({Key? key}) : super(key: key);

  @override
  _GCCTableNumeralBasesNamesState createState() => _GCCTableNumeralBasesNamesState();
}

class _GCCTableNumeralBasesNamesState extends State<GCCTableNumeralBasesNames> {
  @override
  Widget build(BuildContext context) {
    return GCWColumnedMultilineOutput(
      hasHeader: true,
        flexValues: [2, 8],
        data: [
          [i18n(context, 'gcc_tables_numeralbases_base'), i18n(context, 'gcc_tables_numeralbases_name')],
          ['2', i18n(context, 'common_numeralbase_binary')],
          ['3', i18n(context, 'common_numeralbase_ternary')],
          ['4', i18n(context, 'common_numeralbase_quaternary')],
          ['5', i18n(context, 'common_numeralbase_quinary')],
          ['6', i18n(context, 'common_numeralbase_senary')],
          ['7', i18n(context, 'common_numeralbase_septenary')],
          ['8', i18n(context, 'common_numeralbase_octenary')],
          ['9', i18n(context, 'common_numeralbase_nonary')],
          ['10', i18n(context, 'common_numeralbase_denary')],
          ['11', i18n(context, 'common_numeralbase_undenary')],
          ['12', i18n(context, 'common_numeralbase_duodenary')],
          ['14', i18n(context, 'common_numeralbase_tetradecimal')],
          ['15', i18n(context, 'common_numeralbase_pentadecimal')],
          ['16', i18n(context, 'common_numeralbase_hexadecimal')],
          ['20', i18n(context, 'common_numeralbase_vigesimal')],
          ['26', i18n(context, 'common_numeralbase_hexavigesimal')],
          ['27', i18n(context, 'common_numeralbase_septemvigesimal')],
          ['60', i18n(context, 'common_numeralbase_sexagesimal')],
        ]);
  }
}