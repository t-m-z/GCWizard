import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsIMEICheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsIMEICheckNumber() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsIMEICalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsIMEICalculateCheckDigit() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsIMEICalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsIMEICalculateMissingDigit() : super(mode: CheckDigitsMode.DEPERSID);
}
