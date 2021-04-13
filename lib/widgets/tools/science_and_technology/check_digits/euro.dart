import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsEUROCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsEUROCheckNumber() : super(mode: CheckDigitsMode.EURO);
}

class CheckDigitsEUROCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsEUROCalculateCheckDigit() : super(mode: CheckDigitsMode.EURO);
}

class CheckDigitsEUROCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsEUROCalculateMissingDigit() : super(mode: CheckDigitsMode.EURO);
}
