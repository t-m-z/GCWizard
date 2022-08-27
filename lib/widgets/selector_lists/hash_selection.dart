import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/hashes/hash_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/wherigo_urwigo/urwigo_hashbreaker.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class HashSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(HashBreaker()),
        className(UrwigoHashBreaker()),
        className(MD5()),
        className(SHA1()),
        className(SHA224()),
        className(SHA256()),
        className(SHA384()),
        className(SHA512()),
        className(SHA3_224()),
        className(SHA3_256()),
        className(SHA3_384()),
        className(SHA3_512()),
        className(BLAKE2b_160()),
        className(BLAKE2b_224()),
        className(BLAKE2b_256()),
        className(BLAKE2b_384()),
        className(BLAKE2b_512()),
        className(Keccak_128()),
        className(Keccak_224()),
        className(Keccak_256()),
        className(Keccak_288()),
        className(Keccak_384()),
        className(Keccak_512()),
        className(MD2()),
        className(MD4()),
        className(RIPEMD_128()),
        className(RIPEMD_160()),
        className(RIPEMD_256()),
        className(RIPEMD_320()),
        className(Tiger_192()),
        className(Whirlpool_512())
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
