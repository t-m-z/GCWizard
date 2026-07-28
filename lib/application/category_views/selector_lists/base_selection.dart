import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base122/widget/base122.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base16/widget/base16.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base32/widget/base32.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base58/widget/base58.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base64/widget/base64.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base85/widget/base85.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base91/widget/base91.dart';

class BaseSelection extends GCWSelection {
  const BaseSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        Base16,
        Base32,
        Base58,
        Base64,
        Base85,
        Base91,
        Base122
      });

    return GCWToolList(toolList: _toolList);
  }
}
