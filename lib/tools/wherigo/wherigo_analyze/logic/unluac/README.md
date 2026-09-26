# unluac (Dart port)

A Dart port of [unluac](https://github.com/HansWessels/unluac), a Lua bytecode
decompiler. It parses compiled Lua chunks (Lua 5.0 through 5.3) and
reconstructs readable Lua source.

## Usage

```dart
import 'dart:io';
import 'package:unluac/unluac.dart';

void main() {
  final bytecode = File('script.luac').readAsBytesSync();
  final source = decompileLua(bytecode);
  print(source);
}
```

`decompileLua` takes the raw `Uint8List` bytes of a compiled Lua chunk
(the output of `luac` or Lua's `string.dump`) and returns the decompiled
Lua source as a `String`. Pass a `Configuration` to control minor output
options (currently just `rawstring`, matching unluac's `--rawstring` flag).

A small CLI wrapper is included for manual testing:

```
dart run bin/decompile.dart path/to/script.luac
```

## Status

This is a structural, method-for-method port of the Java original — the
bytecode header/constant parsing, the register/expression/statement model,
and the control-flow reconstruction (blocks, branches, loops, if/else,
for/while/repeat) all mirror `unluac`'s design directly, including its
opcode tables for Lua 5.0, 5.1, 5.2, and 5.3.

It has been validated against the real Java `unluac` (built from the
`src/` tree in this repository) by decompiling every `.lua` file under
`test/src/`, compiled with both `luac5.1` and `luac5.3`, and diffing the
two tools' output — all 222 cases currently match byte-for-byte.

Not ported: the `unluac.test` package (the Java test harness itself) and
`Main`'s CLI option parsing beyond what `decompileLua`'s `Configuration`
parameter exposes.

## Development

```
dart pub get
dart analyze
dart run bin/decompile.dart <file.luac>
```
