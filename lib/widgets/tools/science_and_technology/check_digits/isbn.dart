import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsISBNCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsISBNCheckNumber() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsISBNCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsISBNCalculateCheckDigit() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsISBNCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsISBNCalculateMissingDigit() : super(mode: CheckDigitsMode.DEPERSID);
}
