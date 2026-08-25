import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_decimalrange/widget/irrationalnumbers_decimalrange.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_nthdecimal/widget/irrationalnumbers_nthdecimal.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_search/widget/irrationalnumbers_search.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/tau/logic/tau.dart';

class TauNthDecimal extends IrrationalNumbersNthDecimal {
  const TauNthDecimal({super.key}) : super(irrationalNumber: TAU);
}

class TauDecimalRange extends IrrationalNumbersDecimalRange {
  const TauDecimalRange({super.key}) : super(irrationalNumber: TAU);
}

class TauSearch extends IrrationalNumbersSearch {
  const TauSearch({super.key}) : super(irrationalNumber: TAU);
}
