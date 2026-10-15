import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/games/scrabble/widget/scrabble.dart';
import 'package:gc_wizard/tools/games/scrabble/widget/scrabble_overview.dart';

class ScrabbleSelection extends GCWSelection {
  const ScrabbleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {Scrabble, ScrabbleOverview});

    return GCWToolList(toolList: _toolList);
  }
}
