import 'package:flutter/services.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/ean.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_persid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_taxid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/iban.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/imei.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/isbn.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/euro.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum CheckDigitsMode {
  EAN,
  DEPERSID,
  DETAXID,
  EURO,
  IBAN,
  IMEI,
  ISBN
}

final MASKINPUTFORMATTER_EURO = MaskTextInputFormatter(mask: "@########", filter: {"@": RegExp(r'[AB]'), "#": RegExp(r'[0-9]')});
final MASKINPUTFORMATTER_IBAN = MaskTextInputFormatter(mask: "@@################################", filter: {"@": RegExp(r'[A-Za-z]'), "#": RegExp(r'[0-9]')});
final MASKINPUTFORMATTER_ISBN = MaskTextInputFormatter(mask: "#########@###", filter: {"@": RegExp(r'[A-Za-z0-9]'), "#": RegExp(r'[0-9]')});
final MASKINPUTFORMATTER_DEPERSID = MaskTextInputFormatter(mask: "##########@<<#######<#######<<<<<<<#", filter: {"@": RegExp(r'[A-Za-z]'), "#": RegExp(r'[0-9]')});
final MASKINPUTFORMATTER_DETAXID = MaskTextInputFormatter(mask: "###########");
final MASKINPUTFORMATTER_IMEI = MaskTextInputFormatter(mask: "###############");
final MASKINPUTFORMATTER_EAN = MaskTextInputFormatter(mask: "##################");

Map INPUTFORMATTERS = {
  CheckDigitsMode.ISBN : MASKINPUTFORMATTER_ISBN,
  CheckDigitsMode.IBAN : MASKINPUTFORMATTER_IBAN,
  CheckDigitsMode.EURO : MASKINPUTFORMATTER_EURO,
  CheckDigitsMode.DEPERSID : MASKINPUTFORMATTER_DEPERSID,
};

Map INPUTFORMATTERS_HINT = {
  CheckDigitsMode.ISBN : "000000000@000",
  CheckDigitsMode.IBAN : "AA00000000000000000000000000000000",
  CheckDigitsMode.EURO : "A@0000000000",
  CheckDigitsMode.DEPERSID : "0000000000@<<0000000<0000000<<<<<<<0",
};

final Map maxInt = {
  CheckDigitsMode.EAN     : 999999999999999999, // 18 digits
  CheckDigitsMode.IMEI    : 999999999999999,    // 15 digits
  CheckDigitsMode.DETAXID : 99999999999,        // 11 digits
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
    case CheckDigitsMode.EURO:
      return checkDigitsEUROCheckNumber(number);
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
    case CheckDigitsMode.EURO:
      return checkDigitsEUROCalculateNumber(number);
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
    case CheckDigitsMode.EURO:
      return checkDigitsIBANCalculateDigits(number);
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