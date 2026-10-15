import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hash_breaker/widget/hash_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes/widget/hashes.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes_identification/widget/hashes_identification.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes_overview/widget/hashes_overview.dart';
import 'package:gc_wizard/tools/wherigo/urwigo_hashbreaker/widget/urwigo_hashbreaker.dart';

class HashSelection extends GCWSelection {
  const HashSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        HashBreaker,
        UrwigoHashBreaker,
        HashOverview,
        HashIdentification,
        MD5,
        SHA1,
        SHA224,
        SHA256,
        SHA384,
        SHA512,
        SHA512_224,
        SHA512_256,
        SHA3_224,
        SHA3_256,
        SHA3_384,
        SHA3_512,
        BLAKE2b_160,
        BLAKE2b_224,
        BLAKE2b_256,
        BLAKE2b_384,
        BLAKE2b_512,
        Keccak_128,
        Keccak_224,
        Keccak_256,
        Keccak_288,
        Keccak_384,
        Keccak_512,
        MD2,
        MD4,
        RIPEMD_128,
        RIPEMD_160,
        RIPEMD_256,
        RIPEMD_320,
        Tiger_192,
        Whirlpool_512,
        MD5HMac,
        SHA1HMac,
        SHA224HMac,
        SHA256HMac,
        SHA384HMac,
        SHA512HMac,
        SHA512_224HMac,
        SHA512_256HMac,
        SHA3_224HMac,
        SHA3_256HMac,
        SHA3_384HMac,
        SHA3_512HMac,
        MD2HMac,
        MD4HMac,
        RIPEMD_128HMac,
        RIPEMD_160HMac,
        RIPEMD_256HMac,
        RIPEMD_320HMac,
        Tiger_192HMac,
        Whirlpool_512HMac
      });

    return GCWToolList(toolList: _toolList);
  }
}
