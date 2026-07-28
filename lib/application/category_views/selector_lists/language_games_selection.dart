import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/chicken_language/widget/chicken_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/duck_speak/widget/duck_speak.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/judoon/widget/judoon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/pig_latin/widget/pig_latin.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/robber_language/widget/robber_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/spoon_language/widget/spoon_language.dart';

class LanguageGamesSelection extends GCWSelection {
  const LanguageGamesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        ChickenLanguage,
        DuckSpeak,
        Judoon,
        PigLatin,
        RobberLanguage,
        SpoonLanguage
      });

    return GCWToolList(toolList: sortTools(_toolList));
  }
}