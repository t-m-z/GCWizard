import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

import 'base/checkdigits_calculate_checkdigit.dart';
import 'base/checkdigits_calculate_missingdigit.dart';
import 'base/checkdigits_check_number.dart';


class CheckDigitsDEPersIDCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsDEPersIDCheckNumber() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsDEPersIDCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsDEPersIDCalculateCheckDigit() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsDEPersIDCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsDEPersIDCalculateMissingDigit() : super(mode: CheckDigitsMode.DEPERSID);
}
