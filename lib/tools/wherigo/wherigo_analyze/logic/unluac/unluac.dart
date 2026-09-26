/// A Lua bytecode decompiler, ported from the Java `unluac` project
/// (https://github.com/HansWessels/unluac).
///
/// Supports Lua 5.0 through 5.3 bytecode. The single entry point is
/// [decompileLua], which takes the raw bytecode of a compiled Lua chunk
/// (as produced by `luac` / `string.dump`) and returns reconstructed Lua
/// source text.
library;

import 'dart:typed_data';

//export 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/configuration.dart' show Configuration;

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/code.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/code50.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/code_extract.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/constant.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/constant_pool.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/declaration.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/op.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/opcode_format.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/opcode_map.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output_provider.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/registers.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/upvalues.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/variable_finder.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/always_loop.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/boolean_indicator.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/break_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/compare_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/do_end_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/else_end_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/for_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/if_then_else_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/if_then_end_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/outer_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/repeat_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/set_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/tfor_block.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/block/while_block.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/and_branch.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/assign_node.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/branch.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/eq_node.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/le_node.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/lt_node.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/not_branch.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/or_branch.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/test_node.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/test_set_node.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/branch/true_node.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/binary_expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/closure_expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/constant_expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/function_call.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/global_expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/local_variable.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/table_literal.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/table_reference.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/unary_expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/upvalue_expression.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/expression/vararg.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/call_operation.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/global_set.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/operation.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/register_set.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/return_operation.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/table_set.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/operation/upvalue_set.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/assignment.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/function_call_statement.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/return_statement.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/statement/statement.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/global_target.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/table_target.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/target.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/upvalue_target.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/target/variable_target.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_header.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_integer.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_integer_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_list.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_object.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_object_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_size_t.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/b_size_t_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/byte_reader.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_boolean.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_boolean_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_constant_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_function.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_function_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_header.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_header_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_local.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_local_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_nil.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_number.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_number_reader.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_number_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_object.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_string.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_string_type.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_upvalue.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/l_upvalue_type.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/configuration.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/version.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/stack.dart';

class _StringBufferOutputProvider implements _OutputProvider {
  final StringBuffer buffer = StringBuffer();

  @override
  void printString(String s) => buffer.write(s);

  @override
  void printByte(int b) => buffer.writeCharCode(b & 0xFF);

  @override
  void println() => buffer.writeln();
}

/// Decompiles a Lua bytecode chunk (Lua 5.0 - 5.3) into Lua source text.
///
/// [bytecode] is the raw byte content of a compiled Lua chunk, e.g. the
/// output of `luac -o out.luac script.lua` or Lua's `string.dump`.
///
/// Throws a [StateError] (or [RangeError] for malformed/truncated input) if
/// the bytecode is not a valid or supported Lua chunk.
String decompileLua(Uint8List bytecode, {_Configuration? configuration}) {
  try {
    final provider = _StringBufferOutputProvider();
    final reader = _ByteReader(bytecode);
    final header = _BHeader(reader, configuration ?? _Configuration());
    final decompiler = _Decompiler(header.main);
    decompiler.decompile();
    final output = _Output(provider);
    decompiler.print(output);
    return provider.buffer.toString();
  } catch (exception, stacktrace) {
    return ['EXCEPTION', exception.toString(), ' ', 'STACKTRACE', stacktrace.toString()].join('~');
  }
}
