import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';


CheckDigitOutput checkDigitsDETaxIDCheckNumber(String number){
  if (number.length == 11) {
    if (_checkDETaxID(number))
      return CheckDigitOutput(true, '', ['']);
    else {
      int length = number.length;

      // Calculate new Check Digit
      String checkDigit = '';
      checkDigit = checkDigitsDETaxIDCalculateNumber(number.substring(0, number.length - 1));

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
          if (_checkDETaxID(test))
            result.add(test);
        } // for testDigit
      } // for index
      return CheckDigitOutput(false, checkDigit, result);

    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String checkDigitsDETaxIDCalculateNumber(String number){
  if (number.length == 10) {
    return number + _calculateDETaxIDCheckDigit(number);
  }
  return '';
}

List<String> checkDigitsDETaxIDCalculateDigits(String number){
  if (number.length == 11 && int.tryParse(number[number.length - 1]) != null) {
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
      if (_checkDETaxID(checkNumber))
        result.add(checkNumber);
    }
    return result;
  } else
    return [''];
}


bool _checkDETaxID(String number) {
  return (number[10] == _calculateDETaxIDCheckDigit(number.substring(0, number.length - 1)));
}


String  _calculateDETaxIDCheckDigit(String number) {
  int product = 10;
  int sum = 0;
  int pz = 0;
  for (int i = 0; i < 10; i++){
    sum = (int.parse(number[i]) + product) % 10;
    if (sum == 0)
      sum = 10;
    product = (sum * 2) % 11;
  }
  pz = 11 - product;
  if (pz == 10)
    pz = 0;
  return pz.toString();
}