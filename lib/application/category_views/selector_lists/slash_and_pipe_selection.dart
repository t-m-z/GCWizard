import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/slash_and_pipe/widget/slash_and_pipe.dart';

class SlashAndPipeSelection extends GCWSelection {
  const SlashAndPipeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {
          'slash_and_pipe',
          'slash_and_pipe_underland',
          'slash_and_pipe_codeofclaw'
        }, const {SlashAndPipe});

    return GCWToolList(toolList: _toolList);
  }
}
