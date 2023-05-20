// https://de.wikipedia.org/wiki/Opcode#Der_Relaisrechner_Zuse_Z3
// http://ed-thelen.org/comp-hist/Zuse_Z1_and_Z3.pdf

import 'dart:math';

import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

class Z3Output {
  final List<String> output;
  final List<String> assembler;
  final List<String> mnemonic;

  Z3Output(this.output, this.assembler, this.mnemonic);
}

Z3Output interpretZ3(String sourcecode, String inputData) {
  if (sourcecode == '') {
    return Z3Output([''], [''], ['']);
  }

  List<String> program = [];
  List<String> output = [];
  List<String> assembler = [];
  List<String> mnemonic = [];
  List<String> input = inputData.split(' ');

  double? r1 = 0.0;
  double? r2 = 0.0;
  int storageCell = 0;
  int inputCounter = 0;
  bool runtimeError = false;
  bool r1Loaded = false;
  Map<int, double> storage = <int, double>{};

  if (_isBinary(sourcecode.replaceAll('\n', ''))) {
    sourcecode = sourcecode.replaceAll('\n', '').replaceAll(' ', '');
    while (sourcecode.isNotEmpty) {
      if (sourcecode.length > 8) {
        program.add(sourcecode.substring(0, 8));
        sourcecode = sourcecode.substring(8);
      } else {
        program.add(sourcecode);
        sourcecode = '';
      }
    }
  } else {
    program = sourcecode.split('\n');
  }

  for (String command in program) {
    if (!runtimeError) {
      if (command == '01110000' || command == 'Lu') {
        // read keyboard - Lu
        mnemonic.add('Lu');
        assembler.add('01110000');
        if (inputCounter < input.length) {
          if (double.tryParse(input[inputCounter]) == null) {
            runtimeError = true;
            output.add('z3_runtimeerror_invalid_input');
          } else {
            if (r1Loaded) {
              r2 = double.parse(input[inputCounter]);
              inputCounter++;
            } else {
              r1 = double.parse(input[inputCounter]);
              inputCounter++;
              r1Loaded = true;
            }
          }
        } else {
          runtimeError = true;
          output.add('z3_runtimeerror_input_missing');
        }
      } else if (command == '01111000' || command == 'Ld') {
        // display result - Ld
        mnemonic.add('Ld');
        assembler.add('01111000');
        if (_isInt(r1!)) {
          output.add(r1.toInt().toString());
        } else {
          output.add(r1.toString());
        }
        r1 = 0.0;
        r1Loaded = false;
      } else if (command == '01001000' || command == 'Lm') {
        // multiplication - Lm
        mnemonic.add('Lm');
        assembler.add('01001000');
        r1 = r1! * r2!;
        r2 = 0.0;
      } else if (command == '01010000' || command == 'Li') {
        // division - Li
        mnemonic.add('Li');
        assembler.add('01010000');
        if (r2 == 0) {
          runtimeError = true;
          output.add('z3_runtimeerror_division_by_zero');
        } else {
          r1 = r1! / r2!;
          r2 = 0.0;
        }
      } else if (command == '01011000' || command == 'Lw') {
        // square root - Lw
        mnemonic.add('Lw');
        assembler.add('01011000');
        if (r1! < 0) {
          runtimeError = true;
          output.add('z3_runtimeerror_negative_sqrt');
        } else {
          r1 = sqrt(r1);
          r2 = 0.0;
        }
      } else if (command == '01100000' || command == 'La') {
        // addition - Ls1
        mnemonic.add('La');
        assembler.add('01100000');
        r1 = r1! + r2!;
        r2 = 0.0;
      } else if (command == '01101000' || command == 'Ls') {
        // subtraction - Ls2
        mnemonic.add('Ls');
        assembler.add('01101000');
        r1 = r1! - r2!;
        r2 = 0.0;
      } else if (command.startsWith('11') || command.startsWith('Pr')) {
        // load address - Pr z
        if (_isBinary(command.substring(2))) {
          storageCell = int.parse(convertBase(command.substring(2), 2, 10));
          mnemonic.add('Pr ' + command.substring(2));
          assembler.add('11' + command.substring(2));
          if (r1Loaded) {
            r2 = storage[storageCell];
            if (r2 == null) {
              runtimeError = true;
              output.add('z3_runtimeerror_illegal_storage_access');
            }
          } else {
            r1 = storage[storageCell];
            r1Loaded = true;
            if (r1 == null) {
              runtimeError = true;
              output.add('z3_runtimeerror_illegal_storage_access');
            }
          }
        } else if (int.tryParse(command.substring(2)) != null) {
          storageCell = int.parse(command.substring(2));
          mnemonic.add('Pr ' + command.substring(2));
          assembler.add('11' + convertBase(command.substring(2), 10, 2));
          if (r1Loaded) {
            r2 = storage[storageCell];
            if (r2 == null) {
              runtimeError = true;
              output.add('z3_runtimeerror_illegal_storage_access');
            }
          } else {
            r1 = storage[storageCell];
            r1Loaded = true;
            if (r1 == null) {
              runtimeError = true;
              output.add('z3_runtimeerror_illegal_storage_access');
            }
          }
        } else {
          runtimeError = true;
          output.add('z3_runtimeerror_illegal_storage_access');
        }
      } else if (command.startsWith('10') || command.startsWith('Ps')) {
        // store address - Ps z
        if (_isBinary(command.substring(2))) {
          storageCell = int.parse(convertBase(command.substring(2), 2, 10));
          storage[storageCell] = r1!;
          r1 = 0.0;
          r1Loaded = false;
          mnemonic.add('Ps ' + command.substring(2));
          assembler.add('10' + command.substring(2));
        } else if (int.tryParse(command.substring(2)) != null) {
          storageCell = int.parse(command.substring(2));
          storage[storageCell] = r1!;
          r1 = 0.0;
          r1Loaded = false;
          mnemonic.add('Ps ' + command.substring(2));
          assembler.add('10' + convertBase(command.substring(2), 10, 2));
        } else {
          runtimeError = true;
          output.add('z3_runtimeerror_illegal_storage_access');
        }
      } else {
        // invalid command
        runtimeError = true;
        output.add('z3_runtimeerror_invalid_command');
      }
    }
  }
  return Z3Output(output, assembler, mnemonic);
}

bool _isInt(double number) {
  return (number - number.toInt() * 1.0 == 0);
}

bool _isBinary(String x) {
  return (x.replaceAll('0', '').replaceAll('1', '').replaceAll(' ', '') == '');
}
