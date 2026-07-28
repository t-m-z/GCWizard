import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_auth/widget/bundeswehr_auth.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_code/widget/bundeswehr_code.dart';

class BundeswehrTalkingBoardSelection extends GCWSelection {
  const BundeswehrTalkingBoardSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        BundeswehrTalkingBoardAuthentification,
        BundeswehrTalkingBoardObfuscation
      });

    return GCWToolList(toolList: _toolList);
  }
}
