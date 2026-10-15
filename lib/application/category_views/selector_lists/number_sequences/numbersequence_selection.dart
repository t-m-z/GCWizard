import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_bell_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_carmichaelnumber_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_happynumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_harshadnumber_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_jacobsthaloblong_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_lonelynumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_look_and_say_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_luckynumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_lychrel_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_memorableprimes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_memorableprimesindexes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersenneexponents_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersenneprimes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_palindromeprimes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_pell_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_perfectnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_permutableprimes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_primarypseudoperfectnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_primes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_recaman_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_sphenicnumber_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_sublimenumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_suitablenumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_superperfectnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_taxicab_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_weirdnumbers_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';

class NumberSequenceSelection extends GCWSelection {
  const NumberSequenceSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceFactorialSelection,
        NumberSequenceFibonacciSelection,
        NumberSequencePrimesSelection,
        NumberSequenceMersenneSelection,
        NumberSequenceMersennePrimesSelection,
        NumberSequenceMersenneExponentsSelection,
        NumberSequenceMersenneFermatSelection,
        NumberSequenceFermatSelection,
        NumberSequencePerfectNumbersSelection,
        NumberSequenceSuperPerfectNumbersSelection,
        NumberSequencePrimaryPseudoPerfectNumbersSelection,
        NumberSequenceWeirdNumbersSelection,
        NumberSequenceSublimeNumbersSelection,
        NumberSequencePermutablePrimesSelection,
        NumberSequenceMemorablePrimesSelection,
        NumberSequenceMemorablePrimesIndexesSelection,
        NumberSequenceLuckyNumbersSelection,
        NumberSequenceHappyNumbersSelection,
        NumberSequenceBellSelection,
        NumberSequenceCatalanSelection,
        NumberSequenceJacobsthalSelection,
        NumberSequenceJacobsthalLucasSelection,
        NumberSequenceJacobsthalOblongSelection,
        NumberSequenceLucasSelection,
        NumberSequencePellSelection,
        NumberSequencePellLucasSelection,
        NumberSequenceRecamanSelection,
        NumberSequenceLychrelSelection,
        NumberSequenceSphenicNumbersSelection,
        NumberSequenceCarmichaelNumbersSelection,
        NumberSequenceTaxicabNumbersSelection,
        NumberSequenceHarshadNumbersSelection,
        NumberSequenceLonelyNumbersSelection,
        NumberSequencePalindromePrimesSelection,
        NumberSequenceSuitableNumbersSelection,
        NumberSequenceLookAndSaySelection
      });

    return GCWToolList(toolList: _toolList);
  }
}
