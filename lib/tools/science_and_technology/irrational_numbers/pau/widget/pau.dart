import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_decimalrange/widget/irrationalnumbers_decimalrange.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_nthdecimal/widget/irrationalnumbers_nthdecimal.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_search/widget/irrationalnumbers_search.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/pau/logic/pau.dart';

class PauNthDecimal extends IrrationalNumbersNthDecimal {
  const PauNthDecimal({super.key}) : super(irrationalNumber: PAU);
}

class PauDecimalRange extends IrrationalNumbersDecimalRange {
  const PauDecimalRange({super.key}) : super(irrationalNumber: PAU);
}

class PauSearch extends IrrationalNumbersSearch {
  const PauSearch({super.key}) : super(irrationalNumber: PAU);
}
