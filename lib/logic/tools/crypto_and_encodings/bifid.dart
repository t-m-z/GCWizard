import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/constants.dart';

class BifidOutput {
  final String state;
  final String output;
  final String grid;

  BifidOutput(this.state, this.output, this.grid);
}

BifidOutput encryptBifid(String input, String key,
    {PolybiosMode mode: PolybiosMode.AZ09,
    String alphabet,
    AlphabetModificationMode alphabetMode: AlphabetModificationMode.J_TO_I}) {
  if (input == null || key == null)
    //return null; //TODO Exception
    return BifidOutput('ERROR', 'bifid_error_no_encrypt_input', null);

  int dim = key.length;
  if (dim != 5 && dim != 6)
    //return null; //TODO Exception
    return BifidOutput('ERROR', 'bifid_error_wrong_griddimension', null);

  PolybiosOutput polybiosOutput =
      encryptPolybios(input, key, mode: mode, fillAlphabet: alphabet, modificationMode: alphabetMode);

  if (polybiosOutput == null)
    //return null;
    return BifidOutput('ERROR', 'bifid_error_no_output', null);

  var polybiosEncoded = polybiosOutput.output.replaceAll(' ', '');

  /// split output into two rows und build a new string with digits
  /// use this string as input for the decrypt-routine
  String row1 = '';
  String row2 = '';
  String helpInput = '';

  for (var i = 0; i < polybiosEncoded.length; i = i + 2) {
    row1 = row1 + polybiosEncoded.substring(i, i + 1);
    row2 = row2 + polybiosEncoded.substring(i + 1, i + 2);
  }
  helpInput = row1 + row2;

  polybiosOutput = decryptPolybios(helpInput, key, mode: mode, fillAlphabet: alphabet, modificationMode: alphabetMode);

  return BifidOutput('OK', polybiosOutput.output, polybiosOutput.grid);
}

BifidOutput decryptBifid(String input, String key,
    {PolybiosMode mode: PolybiosMode.AZ09,
    String alphabet,
    AlphabetModificationMode alphabetMode: AlphabetModificationMode.J_TO_I}) {
  if (input == null || key == null)
    //return null; //TODO Exception
    return BifidOutput('ERROR', 'bifid_error_no_decrypt_input', null);

  int dim = key.length;
  if (dim != 5 && dim != 6)
    //return null; //TODO Exception
    return BifidOutput('ERROR', 'bifid_error_wrong_griddimension', null);

  PolybiosOutput polybiosOutput =
      encryptPolybios(input, key, mode: mode, fillAlphabet: alphabet, modificationMode: alphabetMode);

  if (polybiosOutput == null)
    //return null;
    return BifidOutput('ERROR', 'bifid_error_no_output', null);

  var polybiosEncoded = polybiosOutput.output.replaceAll(' ', '');

  /// split output into two rows und build a new string with digits
  /// use this string as input for the decrypt-routine
  String row1 = '';
  String row2 = '';
  String helpInput = '';

  row1 = polybiosEncoded.substring(0, polybiosEncoded.length ~/ 2);
  row2 = polybiosEncoded.substring(polybiosEncoded.length ~/ 2, polybiosEncoded.length);

  for (var i = 0; i < polybiosEncoded.length / 2; i = i + 1) {
    helpInput = helpInput + row1.substring(i, i + 1) + row2.substring(i, i + 1);
  }

  polybiosOutput = decryptPolybios(helpInput, key, mode: mode, fillAlphabet: alphabet, modificationMode: alphabetMode);

  return BifidOutput('OK', polybiosOutput.output, polybiosOutput.grid);
}
