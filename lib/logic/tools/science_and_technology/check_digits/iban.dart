import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

// http://www.pruefziffernberechnung.de/I/IBAN.shtml


final Map IBAN_COUNTRYCODE = {
  'A' : '10',
  'B' : '11',
  'C' : '12',
  'D' : '13',
  'E' : '14',
  'F' : '15',
  'G' : '16',
  'H' : '17',
  'I' : '18',
  'J' : '19',
  'K' : '20',
  'L' : '21',
  'M' : '22',
  'N' : '23',
  'O' : '24',
  'P' : '25',
  'Q' : '26',
  'R' : '27',
  'S' : '28',
  'T' : '29',
  'U' : '30',
  'V' : '31',
  'W' : '32',
  'X' : '33',
  'Y' : '34',
  'Z' : '35',
};

final Map IBAN_LENGTH = {
  'AD' : 24,
  'BE' : 16,
  'DK' : 18,
  'DE' : 22,
  'EE' : 20,
  'FI' : 18,
  'FR' : 27,
  'GI' : 23,
  'GR' : 27,
  'IE' : 22,
  'IS' : 26,
  'IT' : 27,
  'LV' : 21,
  'LT' : 20,
  'LU' : 20,
  'NL' : 18,
  'NO' : 15,
  'AT' : 20,
  'PL' : 28,
  'PT' : 25,
  'SE' : 24,
  'CH' : 21,
  'SK' : 24,
  'SI' : 19,
  'ES' : 24,
  'CZ' : 24,
  'HU' : 28,
  'CY' : 28,
};

CheckDigitOutput CheckIBANNumber(String number){
  number = number.toUpperCase();
  if (number == null || number == '' || number.length < 2)
    return CheckDigitOutput(false, '', ['']);
  if (number.length == IBAN_LENGTH[number[0] + number[1]]) {
    if (checkNumber(number, checkIBAN))
      return CheckDigitOutput(true, '', ['']);
    else {
      return CheckDigitOutput(false, CalculateNumber(number, CalculateIBANNumber), CalculateGlitch(number, checkIBAN));
    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String CalculateIBANNumber(String number){
  return number.substring(0,2) + calculateIBANCheckDigit(number) + number.substring(4);
}

List<String> CalculateIBANDigits(String number){

  return [''];
}

bool checkIBAN(String number) {
  return (number.substring(2,4) == calculateIBANCheckDigit(number));
}

String calculateIBANCheckDigit(String number) {
  number = number.substring(4) + IBAN_COUNTRYCODE[number[0]] + IBAN_COUNTRYCODE[number[1]] + '00';
  BigInt checkDigit = BigInt.from(98) - BigInt.parse(number) % BigInt.from(97);
  if (checkDigit < BigInt.from(10))
    number =  '0' + checkDigit.toString();
  else
    number =  checkDigit.toString();
  return number;
}