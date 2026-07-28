import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot123/widget/rot123.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot13/widget/rot13.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot18/widget/rot18.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot47/widget/rot47.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot5/widget/rot5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotation_general/widget/rotation_general.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotxyz/widget/rotxyz.dart';

class RotationSelection extends GCWSelection {
  const RotationSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        Rot13,
        Rot5,
        Rot18,
        Rot47,
        Rot123,
        RotXYZ,
        RotationGeneral
      });

    return GCWToolList(toolList: _toolList);
  }
}
