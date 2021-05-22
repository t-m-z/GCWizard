import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';

// http://www.pruefziffernberechnung.de/I/IBAN.shtml
// https://de.wikipedia.org/wiki/Internationale_Bankkontonummer
// https://en.wikipedia.org/wiki/International_Bank_Account_Number
// https://web.archive.org/web/20171220203336/http://www.europebanks.info/ibanguide.php#5

// GC7DCXZ => calculate checkDigit
//         => calculate Number
// GC4TKB5 => calculate checkDigit


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


CheckDigitOutput CheckIBANNumber(String number){
  number = number.toUpperCase();
  if (number == null || number == '' || number.length < 5)
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  if (checkNumber(number, checkIBAN))
    return CheckDigitOutput(true, '', ['']);
  else {
    return CheckDigitOutput(false, CalculateNumber(number, CalculateIBANNumber), CalculateGlitch(number, checkIBAN));
  }
}

String CalculateIBANNumber(String number){
  if (number.length < 5)
    return ('checkdigits_invalid_length');
  else
    return number.substring(0,2) + calculateIBANCheckDigit(number) + number.substring(4);
}

List<String> CalculateIBANDigits(String number){
    return CalculateDigits(number, checkIBAN);
}

bool checkIBAN(String number) {
  number = number.substring(4) + IBAN_COUNTRYCODE[number[0]] + IBAN_COUNTRYCODE[number[1]] + number[2] + number[3];
  return (BigInt.parse(number) % BigInt.from(97) == BigInt.one);
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