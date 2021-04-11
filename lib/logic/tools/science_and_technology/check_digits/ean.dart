import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

// https://de.wikipedia.org/wiki/Pr%C3%BCfziffer#:~:text=Berechnung%20der%20Pr%C3%BCfziffer%3A%201%20Von%20links%20nach%20rechts,unmittelbar%20nach%20der%20Produktbildung%20erfolgen.%20Weitere%20Artikel...%20
// https://www.activebarcode.de/codes/checkdigit/modulo10.html

CheckDigitOutput checkDigitsEANCheckNumber(String number){
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18) {

    if (_checkEAN(number, 8) || _checkEAN(number, 13) || _checkEAN(number, 14) || _checkEAN(number, 18))
      return CheckDigitOutput(true, '', ['']);
    else {
      int length = number.length;

      // Calculate new Check Digit
      String checkDigit = '';
      for (int i = 0; i < length - 1; i++)
        checkDigit = checkDigit + number[i];
      checkDigit = checkDigitsEANCalculateNumber(checkDigit);

      // test length-1 digits to fix the error
      List<String> result = new List<String>();
      String testEAN = '';
      String testEANleft = '';
      String testEANright = '';
      for (int index = 0; index < length - 1; index ++) {
        testEANleft = '';
        testEANright = '';
        for (int j = 0; j < index; j++)
          testEANleft = testEANleft + number[j];
        for (int j = index + 1; j < length; j++)
          testEANright = testEANright + number[j];

        for (int testDigit = 0; testDigit <= 9; testDigit++) {
          testEAN = testEANleft + testDigit.toString() + testEANright;
          if (_checkEAN(testEAN, length))
            result.add(testEAN);
        } // for testDigit
      } // for index
      return CheckDigitOutput(false, checkDigit, result);
    }
  }
  return CheckDigitOutput(false, '', ['']);
}


bool _checkEAN(String number, int length) {
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


String checkDigitsEANCalculateNumber(String number){
  if (number.length == 7 || number.length == 12 || number.length == 13 || number.length == 17) {
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

    return number + sum.toString();
  }
  return '44';
}

List<String> checkDigitsEANCalculateDigits(String number){
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18 && int.tryParse(number[number.length - 1]) != null) {
    List<String> result = new List<String>();
    int maxDigits = 0;
    int len = 0;
    String maxNumber = '';
    int index = 0;
    String checkEAN = '';
    for (int i = 0; i < number.length; i++)
      if (int.tryParse(number[i]) == null) {
        maxNumber = maxNumber + '9';
      }

    len = maxNumber.length;
    maxDigits = int.parse(maxNumber);
    print('checkDigitsEANCalculateDigits');
    print('ean       '+number);
    print('maxnumber '+maxNumber);
    print('maxdigits '+maxDigits.toString());
    print('len       '+len.toString());
    for (int i = 0; i < maxDigits; i++) {
      maxNumber = i.toString();
      maxNumber = maxNumber.padLeft(len, '0');
      print('maxnumber '+maxNumber);
      index = 0;
      checkEAN = '';
      for (int i = 0; i < number.length; i++) {
        if (int.tryParse(number[i]) == null) {
          checkEAN = checkEAN + maxNumber[index];
          index++;
        } else {
          checkEAN = checkEAN + number[i];
        }
      }
      print('checkEAN '+checkEAN);
      if (_checkEAN(checkEAN, number.length))
        result.add(checkEAN);
    }
    return result;
  } else
    return [''];
}