import 'package:flutter/material.dart';
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

    var content = const Column(
      children: [
        GCWTextDivider(text: 'nightly Tools'),
        GCWColumnedMultilineOutput(
          data: [
            ['Tool', 'Adventure Lab\nAnalyse von Lab Caches'],
            ['Tool', 'Open AI\nClient für ChatGPT, DALL-E, Whisper'],
            ['Tool', 'Weird Rotation\nrotiere Buchstaben einzeln'],
            ['Koordinate', 'What 3 Words\nUmwandeln in W33/Suche nach W3W'],
            ['Koordinate', 'GCX8K7RC\nDas dort genutzte Koordinatenformat'],
          ],
          flexValues: const [3, 7],),
        GCWTextDivider(text: 'Previews'),
        GCWColumnedMultilineOutput(
          data: [
            ['Tool', 'Ballistics\nSchiefer Wurf'],
            ['Tool', 'Logical Solver\nLösen von Logikrätseln'],
            ['Tool', 'Triangle\nBerechnungen von Dreiecken'],
            ['Tool', 'UTIC\nApparent temperature'],
            ['Tool', 'Waveform\nAnalyse von WAV-Dateien'],
            ['Tool', 'WBGT\nApparent temperature'],
            ['Tool', 'Logical Supporter\nHochzeitsjubiläen'],
            ['Code', 'Judoon'],
            ['Code', 'Leet Speak'],
            ['Code', 'Porta'],
            ['Code', 'Ragbaby'],
            ['Code', 'Slash & Pipes'],
            ['Code', 'Upside-Down Text'],
            ['Symbol', 'Ice Lolly Font'],
            ['Symbol', 'Steinheil Telegrafenzeichen'],
            ['Symbol', 'Stratego Spielsteine'],
            ['Enhancement', 'Morse\noutput tones'],
            ['Enhancement', 'Bundeswehr Talking board\nLoad/Save'],
          ],
          flexValues: const [3, 7],),
      ],
    );

    return MainMenuEntryStub(content: content);
  }
}