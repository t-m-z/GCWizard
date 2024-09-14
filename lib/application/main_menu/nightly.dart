import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/main_menu/mainmenuentry_stub.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';


class Nightly extends StatefulWidget {
  const Nightly({Key? key}) : super(key: key);

  @override
  _NightlyState createState() => _NightlyState();
}

class _NightlyState extends State<Nightly> {
  @override
  Widget build(BuildContext context) {

    var content = Column(
      children: [
        GCWTextDivider(text: 'nightly Tools'),
        GCWColumnedMultilineOutput(
          data: [
            [i18n(context, 'imagesandfiles_selection_title'), 'Adventure Lab\nAnalyse von Lab Caches'],
            [i18n(context, 'miscellaneous_selection_title'), 'Open AI\nClient für ChatGPT, DALL-E, Whisper'],
            [i18n(context, 'coords_selection_title'), 'Weird Rotation\nrotiere Buchstaben einzeln'],
            [i18n(context, 'coords_selection_title'), 'What 3 Words\nUmwandeln in W33/Suche nach W3W'],
            [i18n(context, 'coords_selection_title'), 'GCX8K7RC\nDas dort genutzte Koordinatenformat'],
            [i18n(context, 'coords_selection_title'), 'GPS Mock Location'],
          ],
          flexValues: const [3, 7],),
        GCWTextDivider(text: 'Near Term Previews'),
        GCWColumnedMultilineOutput(
          data: [
            ['n/a', '']
          ],
          flexValues: const [3, 7],),
        GCWTextDivider(text: 'Long Term Previews'),
        GCWColumnedMultilineOutput(
          data: [
            [i18n(context, 'scienceandtechnology_selection_title'), 'Ballistics\nSchiefer Wurf'],
            [i18n(context, 'scienceandtechnology_selection_title'), 'Triangle\nBerechnungen von Dreiecken'],
            [i18n(context, 'scienceandtechnology_selection_title'), 'UTIC\nApparent temperature'],
            [i18n(context, 'scienceandtechnology_selection_title'), 'WBGT\nApparent temperature'],
            [i18n(context, 'imagesandfiles_selection_title'), 'Waveform\nAnalyse von WAV-Dateien'],
            [i18n(context, 'cryptography_selection_title'), 'Leet Speak'],
            [i18n(context, 'cryptography_selection_title'), 'Upside-Down Text'],
            [i18n(context, 'symboltables_selection_title'), 'Stratego Spielsteine'],
            ['Enhancement', 'Morse\noutput tones'],
            ['Enhancement', 'Bundeswehr Talking board\nLoad/Save'],
          ],
          flexValues: const [3, 7],),
      ],
    );

    return MainMenuEntryStub(content: content);
  }
}