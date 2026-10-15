import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids/widget/dna_aminoacids.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids_table/widget/dna_aminoacids_table.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_nucleicacidsequence/widget/dna_nucleicacidsequence.dart';

class DNASelection extends GCWSelection {
  const DNASelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        DNANucleicAcidSequence,
        DNAAminoAcids,
        DNAAminoAcidsTable,
      });

    return GCWToolList(toolList: _toolList);
  }
}