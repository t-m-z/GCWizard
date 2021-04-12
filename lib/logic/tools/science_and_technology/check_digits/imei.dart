import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';


CheckDigitOutput checkDigitsIMEICheckNumber(String number){
  if (number.length == 15) {
    if (_checkIMEI(number))
      return CheckDigitOutput(true, '', ['']);
    else {
      int length = number.length;

      // Calculate new Check Digit
      String checkDigit = '';
      checkDigit = checkDigitsIMEICalculateNumber(number.substring(0, number.length - 1));

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
          if (_checkIMEI(test))
            result.add(test);
        } // for testDigit
      } // for index
      return CheckDigitOutput(false, checkDigit, result);

    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String checkDigitsIMEICalculateNumber(String number){
  if (number.length == 14) {
    return number + _calculateIMEICheckDigit(number);
  }
  return '';
}

List<String> checkDigitsIMEICalculateDigits(String number){
  if (number.length == 14 && int.tryParse(number[number.length - 1]) != null) {
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
      if (_checkIMEI(checkNumber))
        result.add(checkNumber);
    }
    return result;
  } else
    return [''];
}


bool _checkIMEI(String number) {
  return (number[14] == _calculateIMEICheckDigit(number.substring(0, number.length - 1)));
}

String  _calculateIMEICheckDigit(String number) {
  int sum = 0;
  int product = 0;
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0)
      product = 1 * int.parse(number[i]);
    else
      product = 2 * int.parse(number[i]);
    sum = sum + product ~/ 10 + product % 10;
  }
  if (sum >= 100)
    sum = sum % 100;
  sum = sum % 10;
  sum = 10 - sum;
  return sum.toString();
}