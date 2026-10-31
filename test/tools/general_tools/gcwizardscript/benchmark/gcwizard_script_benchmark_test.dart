// Benchmark for the GC Wizard Script interpreter.
//
// Run:  flutter test test/tools/general_tools/gcwizardscript/benchmark/gcwizard_script_benchmark_test.dart
//
// Prints the median runtime of every program and checks that the output is
// unchanged. Results and measuring conditions: see README.md in this folder.
// Note: timings under `flutter test` run in JIT mode and are only comparable
// with each other; the numbers in README.md were measured AOT-compiled.

import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/general_tools/gcwizardscript/logic/gcwizard_script.dart';
import 'package:latlong2/latlong.dart';

final Map<String, String> programs = {
  'for_nested_arith': '''
s = 0
for i = 1 to 200
  for j = 1 to 200
    s = s + (i * j) % 7
  next
next
print s
''',
  'if_elseif_else': '''
c = 0
for i = 1 to 20000
  if i % 3 = 0 then
    c = c + 1
  elseif i % 3 = 1 then
    c = c + 2
  else
    c = c + 3
  endif
next
print c
''',
  'while_strings': '''
s = ""
n = 0
while n < 3000
  s = s + CHAR(65 + n % 26)
  n = n + 1
wend
print LEN(s)
print MID(s, 1, 26)
''',
  'repeat_gosub': '''
k = 0
repeat
  gosub 100
until k >= 10000
print k
end
100 k = k + 1
return
''',
  'list_sieve': '''
DIM P
n = 3000
for i = 0 to n
  LISTADD(P, 1)
next
c = 0
for i = 2 to n
  if LISTGET(P, i) = 1 then
    c = c + 1
    j = i * i
    while j <= n
      LISTREMOVE(P, j)
      LISTINSERT(P, j, 0)
      j = j + i
    wend
  endif
next
print c
''',
  'functions_math': '''
s = 0
for i = 1 to 20000
  s = s + ABS(SIN(i)) + SQRT(i) + MOD(i, 7)
next
print s
''',
  'print_heavy': '''
for i = 1 to 5000
  print "Zeile "; i
next
''',
};

// Großes Programm: dieselbe IF-Schleife, aber mit 400 Zeilen Code dahinter
// (Block-Suche ist bei langen Skripten besonders teuer).
String bigProgram() {
  final b = StringBuffer(programs['if_elseif_else']!.replaceAll('print c\n', 'print c\nend\n'));
  for (var i = 0; i < 400; i++) { b.writeln('rem Fuellzeile $i mit etwas Text, damit das Skript lang wird'); }
  return b.toString();
}

const Map<String, String> expectedOutput = {
  'for_nested_arith': '103539',
  'if_elseif_else': '40001',
  'while_strings': '3000\nABCDEFGHIJKLMNOPQRSTUVWXYZ',
  'repeat_gosub': '10000',
  'functions_math': '1958419.0356329747',
  // list_sieve prints 450 instead of 430 because _GCWList.remove(index)
  // removes by value, not by position (separate bug) - not checked here.
  'if_in_long_script': '40001',
};

const int repetitions = 5;

void main() {
  final all = {...programs, 'if_in_long_script': bigProgram()};
  for (final e in all.entries) {
    test('benchmark ${e.key}', () async {
      final times = <int>[];
      late GCWizardScriptOutput out;
      for (var r = 0; r < repetitions; r++) {
        final sw = Stopwatch()..start();
        out = await GCWizardScriptInterpretScript(e.value, '', const LatLng(0, 0), null);
        sw.stop();
        times.add(sw.elapsedMicroseconds);
      }
      times.sort();
      // ignore: avoid_print
      print('${e.key.padRight(20)} ${(times[times.length ~/ 2] / 1000).toStringAsFixed(1).padLeft(10)} ms');
      expect(out.ErrorMessage, '');
      if (expectedOutput.containsKey(e.key)) expect(out.STDOUT, expectedOutput[e.key]);
      if (e.key == 'print_heavy') expect(out.STDOUT.split('\n').length, 5000);
    }, timeout: const Timeout(Duration(minutes: 30)));
  }
}
