import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'ean.dart';


CheckDigitOutput CheckISBNNumber(String number){
  number = number.replaceAll('#', '');
  number = number.toUpperCase();
  if (number.length == 10 || (number.length == 13 && number[9] != 'X')) {
    if (checkNumber(number, checkISBN))
      return CheckDigitOutput(true, '', ['']);
    else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateISBNNumber), CalculateGlitch(number, checkISBN));
    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String CalculateISBNNumber(String number){
  if (number.length == 9)
    return number + calculateCheckDigit(number, calculateISBNCheckDigit);
  else
    return number + calculateCheckDigit(number, calculateEANCheckDigit);
}

List<String> CalculateISBNDigits(String number){
  if (number.length == 10 || number.length == 13 && (int.tryParse(number[number.length - 1]) != null || number[number.length - 1] == 'X')) {
    return CalculateDigits(number, checkISBN);
  } else
    return [''];
}


bool checkISBN(String number) {
  return (number[number.length - 1] == calculateCheckDigit(number.substring(0, number.length - 1), calculateISBNCheckDigit));
}

String  calculateISBNCheckDigit(String number) {
  if(number.length == 9) {
    int sum = 0;
    for (int i = 1; i < 10; i++) {
      sum = sum + i * int.parse(number[i]);
      sum = sum % 11;
      if (sum == 10)
        return 'X';
      else
        return sum.toString();
    }
    if (sum >= 100)
      sum = sum % 100;
    sum = sum % 10;
    sum = 10 - sum;
  } else {
    return calculateCheckDigit(number, calculateEANCheckDigit);
  }
}