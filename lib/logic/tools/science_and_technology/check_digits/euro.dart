import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';


CheckDigitOutput checkDigitsEUROCheckNumber(String number){
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18) {

    if (checkEURO(number))
      return CheckDigitOutput(true, '', ['']);
    else {
      int length = number.length;

      // Calculate new Check Digit
      String checkDigit = '';
      checkDigit = checkDigitsEUROCalculateNumber(number.substring(0, number.length - 1));

      // test length-1 digits to fix the error
      List<String> result = new List<String>();
      String test = '';
      String testLeft = '';
      String testRight = '';
      for (int index = 1; index < length; index ++) {
        testLeft = number.substring(0, index - 1);
        testRight = number.substring(index);
        for (int testDigit = 0; testDigit <= 9; testDigit++) {
          test = testLeft + testDigit.toString() + testRight;
          if (checkEURO(test))
            result.add(test);
        } // for testDigit
      } // for index
      return CheckDigitOutput(false, checkDigit, result);
    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String checkDigitsEUROCalculateNumber(String number){
  if (number.length == 7 || number.length == 12 || number.length == 13 || number.length == 17) {
    return number + calculateEUROCheckDigit(number);
  }
  return '';
}

List<String> checkDigitsEUROCalculateDigits(String number){
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18 && int.tryParse(number[number.length - 1]) != null) {
    List<String> result = new List<String>();
    int maxDigits = 0;
    int len = 0;
    String maxNumber = '';
    int index = 0;
    String checkNumber = '';
    for (int i = 0; i < number.length; i++)
      if (int.tryParse(number[i]) == null) {
        maxNumber = maxNumber + '9';
      }

    len = maxNumber.length;
    maxDigits = int.parse(maxNumber);
    for (int i = 0; i < maxDigits; i++) {
      maxNumber = i.toString();
      maxNumber = maxNumber.padLeft(len, '0');
      index = 0;
      checkNumber = '';
      for (int i = 0; i < number.length; i++) {
        if (int.tryParse(number[i]) == null) {
          checkNumber = checkNumber + maxNumber[index];
          index++;
        } else {
          checkNumber = checkNumber + number[i];
        }
      }
      if (checkEURO(checkNumber))
        result.add(checkNumber);
    }
    return result;
  } else
    return [''];
}

bool checkEURO(String number) {
  return (number[number.length - 1] == calculateEUROCheckDigit(number.substring(0, number.length - 1)));
}

String  calculateEUROCheckDigit(String number) {
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