import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_cards.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_coin.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_color.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_coords.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_dice.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_double.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_integer.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_letter.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_lists/randomizer_lists.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_password.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_rockpaperscissors.dart';
import 'package:gc_wizard/tools/general_tools/randomizer/widget/randomizer_text.dart';

class RandomizerSelection extends GCWSelection {
  const RandomizerSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        RandomizerCoin,
        RandomizerDice,
        RandomizerCards,
        RandomizerRockPaperScissors,
        RandomizerPassword,
        RandomizerInteger,
        RandomizerDouble,
        RandomizerLetter,
        RandomizerText,
        RandomizerCoordinates,
        RandomizerColor,
        RandomizerLists
      });

    return GCWToolList(toolList: _toolList);
  }
}
