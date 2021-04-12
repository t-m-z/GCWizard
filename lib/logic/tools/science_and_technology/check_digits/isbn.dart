import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';


CheckDigitOutput checkDigitsISBNCheckNumber(String number){

  return CheckDigitOutput(false, '', ['']);
}

String checkDigitsISBNCalculateNumber(String number){

  return '';
}

List<String> checkDigitsISBNCalculateDigits(String number){

  return [''];
}


bool _checkISBN(String number, int length) {
  if (number.length == length) {
    int sum = 0;
    for (int i = 0; i < length - 1; i++) {
      if (i % 2 == 0)
        sum = sum + 1 * int.parse(number[i]);
      else
        sum = sum + 3 * int.parse(number[i]);
    }
    if (sum >= 100)
      sum = sum % 100;
    sum = sum % 10;
    sum = 10 - sum;

    return (sum.toString() == number[length - 1]);
  } else
    return false;
}

String  _calculateISBNCheckDigit(String number) {
  int sum = 0;
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0)
      sum = sum + 1 * int.parse(number[i]);
    else
      sum = sum + 3 * int.parse(number[i]);
  }
  if (sum >= 100)
    sum = sum % 100;
  sum = sum % 10;
  sum = 10 - sum;
  return sum.toString();
}