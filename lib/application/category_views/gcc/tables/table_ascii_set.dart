import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

class GCCTableASCIISet extends StatefulWidget {
  const GCCTableASCIISet({Key? key}) : super(key: key);

  @override
  _GCCTableASCIISetState createState() => _GCCTableASCIISetState();
}

class _GCCTableASCIISetState extends State<GCCTableASCIISet> {
  @override
  Widget build(BuildContext context) {
    List<List<String>> data = [[i18n(context, 'common_numeralbase_denary'), i18n(context, 'common_numeralbase_hexadecimal'), i18n(context, 'common_numeralbase_binary'), i18n(context, 'gcc_tables_ascii_char'), ]];
    data.add(['0', '0', '00000000', 'NUL']);
    data.add(['1', '1', '00000001', 'SOH']);
    data.add(['2', '2', '00000010', 'STX']);
    data.add(['3', '3', '00000011', 'ETX']);
    data.add(['4', '4', '00000100', 'EOT']);
    data.add(['5', '5', '00000101', 'ENQ']);
    data.add(['6', '6', '00000110', 'ACK']);
    data.add(['7', '7', '00000111', 'BEL']);
    data.add(['8', '8', '00001000', 'BS']);
    data.add(['9', '9', '00001001', 'HT']);
    data.add(['10', 'A', '00001010', 'LF']);
    data.add(['11', 'B', '00001011', 'VT']);
    data.add(['12', 'C', '00001100', 'FF']);
    data.add(['13', 'D', '00001101', 'CR']);
    data.add(['14', 'E', '00001110', 'SO']);
    data.add(['15', 'F', '00001111', 'SI']);
    data.add(['16', '10', '00010000', 'DLE']);
    data.add(['17', '11', '00010001', 'DC1']);
    data.add(['18', '12', '00010010', 'DC2']);
    data.add(['19', '13', '00010011', 'DC3']);
    data.add(['20', '14', '00010100', 'DC4']);
    data.add(['21', '15', '00010101', 'NAK']);
    data.add(['22', '16', '00010110', 'SYN']);
    data.add(['23', '17', '00010111', 'ETB']);
    data.add(['24', '18', '00011000', 'CAN']);
    data.add(['25', '19', '00011001', 'EM']);
    data.add(['26', '1A', '00011010', 'SUB']);
    data.add(['27', '1B', '00011011', 'ESC']);
    data.add(['28', '1C', '00011100', 'FS']);
    data.add(['29', '1D', '00011101', 'GS']);
    data.add(['30', '1E', '00011110', 'RS']);
    data.add(['31', '1F', '00011111', 'US']);
    for (int i = 32; i < 256; i++) {
      data.add([i.toString(), convertBase(i.toString(), 10, 16), convertBase(i.toString(), 10, 2).padLeft(8, '0'), String.fromCharCode(i)]);
    }
    return GCWColumnedMultilineOutput(
        hasHeader: true,
        flexValues: const [2, 2, 2, 2],
        data: data);
  }
}