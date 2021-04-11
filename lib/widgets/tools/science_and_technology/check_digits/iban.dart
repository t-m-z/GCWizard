import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsIBANCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsIBANCheckNumber() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsIBANCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsIBANCalculateCheckDigit() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsIBANCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsIBANCalculateMissingDigit() : super(mode: CheckDigitsMode.DEPERSID);
}
