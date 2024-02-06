import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';

class GCCTableMorse extends StatefulWidget {
  const GCCTableMorse({Key? key}) : super(key: key);

  @override
  _GCCTableMorseState createState() => _GCCTableMorseState();
}

class _GCCTableMorseState extends State<GCCTableMorse> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'gcc_tables_morse_letters'),
        ),
        GCWColumnedMultilineOutput(flexValues: [
          4,
          2,
          2,
          4,
          2
        ], data: [
          ['A', '.-', '', 'N', '-.'],
          ['B', '-...', '', 'O', '---'],
          ['C', '-.-.', '', 'P', '.--.'],
          ['D', '-..', '', 'Q', '--.-'],
          ['E', '.', '', 'R', '.-.'],
          ['F', '..-.', '', 'S', '...'],
          ['G', '--.', '', 'T', '-'],
          ['H', '....', '', 'U', '..-'],
          ['I', '..', '', 'V', '...-'],
          ['J', '.---', '', 'W', '.--'],
          ['K', '-.-', '', 'X', '-..-'],
          ['L', '.-..', '', 'Y', '-.--'],
          ['M', '--', '', 'Z', '--..'],
          ['', '', '', '', ''],
          ['À, Å', '.--.-', '', 'Ä', '.-.-'],
          ['È', '.-..-', '', 'É', '..-..'],
          ['Ö', '---.', '', 'Ü', '..--'],
          ['ß', '...--.', '', 'CH', '----'],
          ['Ñ', '--.--', '', '', ''],

        ]),
        GCWTextDivider(
          text: i18n(context, 'gcc_tables_morse_numbers'),
        ),
        GCWColumnedMultilineOutput(flexValues: [
    4,
    2,
    2,
    4,
    2
    ], data: [
          ['0', '-----', '', '5', '.....'],
          ['1', '.----', '', '6', '-....'],
          ['2', '..---', '', '7', '--...'],
          ['3', '...--', '', '8', '---..'],
          ['4', '....-', '', '9', '----.'],
        ]),
        GCWTextDivider(
          text: i18n(context, 'gcc_tables_morse_signs'),
        ),
      GCWColumnedMultilineOutput(flexValues: [
        4,
        2,
        2,
        4,
        2
      ], data: [
        ['.', '.-.-.-', '', '(', '-.--.'],
        [',', '--..--', '', ')', '-.--.-'],
        [':', '---...', '', "'", '.---.'],
        [';', '-.-.-.', '', '=', '-...-'],
        ['?', '..--..', '', '+', '.-.-.'],
        ['-', '', '', '/', '-..-.'],
        ['_', '', '', '@', '.--.-.'],
      ]),
        GCWTextDivider(
          text: i18n(context, 'gcc_tables_morse_signals'),
        ),
        GCWColumnedMultilineOutput(flexValues: [
          4,
          2,
          2,
          4,
          2
        ], data: [
          [i18n(context, 'gcc_tables_morse_signals_start') +' (KA)', '-.-.-', '', i18n(context, 'gcc_tables_morse_signals_final') +' (SK)', '...-.-'],
          [i18n(context, 'gcc_tables_morse_signals_pause') +' (BT)', '-...-', '', i18n(context, 'gcc_tables_morse_signals_help') +' SOS', '...---...'],
          [i18n(context, 'gcc_tables_morse_signals_end') +' (AR)', '.-.-.', '', i18n(context, 'gcc_tables_morse_signals_error') +' (HH)', '.......'],
          [i18n(context, 'gcc_tables_morse_signals_confirm') +' (VE)', '...-.', '', '', ''],
        ]),
      ],
    );
  }
}
