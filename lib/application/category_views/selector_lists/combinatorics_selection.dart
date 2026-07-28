import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination/widget/combination.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination_permutation/widget/combination_permutation.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/permutation/widget/permutation.dart';

class CombinatoricsSelection extends GCWSelection {
  const CombinatoricsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        Combination,
        Permutation,
        CombinationPermutation
      });

    return GCWToolList(toolList: _toolList);
  }
}
