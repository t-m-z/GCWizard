import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsDETaxIDCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsDETaxIDCheckNumber() : super(mode: CheckDigitsMode.DETAXID);
}

class CheckDigitsDETaxIDCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsDETaxIDCalculateCheckDigit() : super(mode: CheckDigitsMode.DETAXID);
}

class CheckDigitsDETaxIDCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsDETaxIDCalculateMissingDigit() : super(mode: CheckDigitsMode.DETAXID);
}
