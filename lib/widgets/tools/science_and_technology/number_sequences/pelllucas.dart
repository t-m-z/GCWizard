import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_contain.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequencePellLucasCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePellLucasCheckNumber() : super(mode: NumberSequencesMode.PELL_LUCAS);
}

class NumberSequencePellLucasDigits extends NumberSequenceDigits {
  NumberSequencePellLucasDigits() : super(mode: NumberSequencesMode.PELL_LUCAS);
}

class NumberSequencePellLucasRange extends NumberSequenceRange {
  NumberSequencePellLucasRange() : super(mode: NumberSequencesMode.PELL_LUCAS);
}

class NumberSequencePellLucasNthNumber extends NumberSequenceNthNumber {
  NumberSequencePellLucasNthNumber() : super(mode: NumberSequencesMode.PELL_LUCAS);
}

class NumberSequencePellLucasContains extends NumberSequenceContains {
  NumberSequencePellLucasContains() : super(mode: NumberSequencesMode.PELL_LUCAS);
}
