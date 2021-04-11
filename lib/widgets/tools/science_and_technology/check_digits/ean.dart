import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsEANCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsEANCheckNumber() : super(mode: CheckDigitsMode.EAN);
}

class CheckDigitsEANCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsEANCalculateCheckDigit() : super(mode: CheckDigitsMode.EAN);
}

class CheckDigitsEANCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsEANCalculateMissingDigit() : super(mode: CheckDigitsMode.EAN);
}
