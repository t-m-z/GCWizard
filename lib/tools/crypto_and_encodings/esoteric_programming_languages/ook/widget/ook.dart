import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/logic/brainfk_derivative.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/widget/brainfk.dart';

class Ook extends Brainfk {
  Ook({Key? key})
      : super(
            key: key,
            interpret: BRAINFKDERIVATIVE_SHORTOOK.interpretBrainfkDerivatives,
            generate: BRAINFKDERIVATIVE_OOK.generateBrainfkDerivative);
}
