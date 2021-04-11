import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/ean.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_persid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_taxid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/iban.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/imei.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/isbn.dart';

enum CheckDigitsMode {
  EAN,
  DEPERSID,
  DETAXID,
  IBAN,
  IMEI,
  ISBN
}

final Map maxInt = {
  CheckDigitsMode.EAN : 999999999999999999,
  CheckDigitsMode.IMEI : 999999999999999,
  CheckDigitsMode.ISBN : 9999999999999,
  CheckDigitsMode.DETAXID : 99999999999,
};

class CheckDigitOutput{
  final bool correct;
  final String correctDigit;
  final List<String> correctNumbers;

  CheckDigitOutput(this.correct, this.correctDigit, this.correctNumbers);
}

CheckDigitOutput checkDigitsCheckNumber(CheckDigitsMode mode, String number){
  switch(mode) {
    case CheckDigitsMode.EAN:
      return checkDigitsEANCheckNumber(number);
    case CheckDigitsMode.DEPERSID:
      return checkDigitsDEPersIDCheckNumber(number);
    case CheckDigitsMode.DETAXID:
      return checkDigitsDETaxIDCheckNumber(number);
    case CheckDigitsMode.IBAN:
      return checkDigitsIBANCheckNumber(number);
    case CheckDigitsMode.IMEI:
      return checkDigitsIMEICheckNumber(number);
    case CheckDigitsMode.ISBN:
      return checkDigitsISBNCheckNumber(number);
    default:
      return CheckDigitOutput(false, '', ['']);
  }
}

String checkDigitsCalculateNumber(CheckDigitsMode mode, String number){
  switch(mode) {
    case CheckDigitsMode.EAN:
      return checkDigitsEANCalculateNumber(number);
    case CheckDigitsMode.DEPERSID:
      return checkDigitsDEPersIDCalculateNumber(number);
    case CheckDigitsMode.DETAXID:
      return checkDigitsDETaxIDCalculateNumber(number);
    case CheckDigitsMode.IBAN:
      return checkDigitsIBANCalculateNumber(number);
    case CheckDigitsMode.IMEI:
      return checkDigitsIMEICalculateNumber(number);
    case CheckDigitsMode.ISBN:
      return checkDigitsISBNCalculateNumber(number);
    default:
      return '';
  }
}

List<String> checkDigitsCalculateDigits(CheckDigitsMode mode, String number){
  switch(mode) {
    case CheckDigitsMode.EAN:
      return checkDigitsEANCalculateDigits(number);
    case CheckDigitsMode.DEPERSID:
      return checkDigitsDEPersIDCalculateDigits(number);
    case CheckDigitsMode.DETAXID:
      return checkDigitsDETaxIDCalculateDigits(number);
    case CheckDigitsMode.IBAN:
      return checkDigitsIBANCalculateDigits(number);
    case CheckDigitsMode.IMEI:
      return checkDigitsIMEICalculateDigits(number);
    case CheckDigitsMode.ISBN:
      return checkDigitsISBNCalculateDigits(number);
    default:
      return [''];
  }
}