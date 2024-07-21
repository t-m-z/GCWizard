part of 'gcwizard_scipt_test.dart';

// ignore: unused_element
List<Map<String, Object?>> _inputsHashToExpected = [
  {'code' : 'print HASH(2, 0, 0, "testkey", "test")', 'expectedOutput' : '', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print HASH(2.0, 0, 0, "testkey", "test")', 'expectedOutput' : '', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print HASH("MD2", "0", 0, "testkey", "test")', 'expectedOutput' : '', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print HASH("MD2", 0, "0", "testkey", "test")', 'expectedOutput' : '', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print HASH("MD2", 0, "0", 0, "test")', 'expectedOutput' : '', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print HASH("MD2", 0, 0, 0, "test")', 'expectedOutput' : '', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print HASH("MD2", 0, 0, "testkey", "test", 0)', 'expectedOutput' : '', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print HASH("MD2", 0, 0, "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_syntax_error'},

  {'code' : 'print HASH("MD2", 0, 0, "testkey", "test")', 'expectedOutput' : 'dd34716876364a02d0195e2fb9ae2d1b'},
  {'code' : 'print HASH("MD2", 0, 1, "testkey", "test")', 'expectedOutput' : '1085c46a71db0553315b7e6a6e8f3573'},
  {'code' : 'print HASH("MD2", 0, 0, "testkey", "0")', 'expectedOutput' : 'dbd315c8e6f342d62799fa6669249ead'},
  {'code' : 'print HASH("MD2", 0, 0, "testkey", 0)', 'expectedOutput' : 'dbd315c8e6f342d62799fa6669249ead'},

  {'code' : 'print HASH("MD4", 0, 0, "test", "testkey")', 'expectedOutput' : '1d262f0fe3cc1000b5661a094ee9fe3a'},
  {'code' : 'print HASH("MD4", 0, 1, "test", "testkey")', 'expectedOutput' : 'a478d32055d326121e325838c3b37449'},

  {'code' : 'print HASH("MD5", 0, 0, "test", "testkey")', 'expectedOutput' : '221b368d7f5f597867f525971f28ff75'},
  {'code' : 'print HASH("MD5", 0, 1, "test", "testkey")', 'expectedOutput' : '2d0335d9318888e9fdaa1c343ddc7160'},

  {'code' : 'print HASH("SHA1", 0, 0, "test", "testkey")', 'expectedOutput' : '913a73b565c8e2c8ed94497580f619397709b8b6'},
  {'code' : 'print HASH("SHA1", 0, 1, "test", "testkey")', 'expectedOutput' : '856c5fc328bcffd05f751e31e2634fa6a3c5bbbf'},

  {'code' : 'print HASH("SHA", 0, 1, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("SHA", 0, 0, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("SHA", 224, 0, "test", "testkey")', 'expectedOutput' : '934a26c6ec10c1c44e1e140c6ffa25036166c0afd0efcfe638693e6a'},
  {'code' : 'print HASH("SHA", 256, 0, "test", "testkey")', 'expectedOutput' : '98483c6eb40b6c31a448c22a66ded3b5e5e8d5119cac8327b655c8b5c4836489'},
  {'code' : 'print HASH("SHA", 384, 0, "test", "testkey")', 'expectedOutput' : '2c37ac4db1bf3f1a237b5221083c3166fc1f5da9018e533db50b1baa9a422daaf399d35e45c82bfc8e2671508e6cf13d'},
  {'code' : 'print HASH("SHA", 512, 0, "test", "testkey")', 'expectedOutput' : 'fc2fb108fc2a781c2956188b6a96704ebdf9ae60e2384e3367b151585acbcd5742a1eff19e2ceca7e744568197eb9bef55dfe3ccb37ed01ec87e3fecfafaf167'},
  {'code' : 'print HASH("SHA", 224, 1, "test", "testkey")', 'expectedOutput' : '346e00b81ef9743e055bf4b8c33a51c00871f1d841f9661a77c3a32a'},
  {'code' : 'print HASH("SHA", 256, 1, "test", "testkey")', 'expectedOutput' : '16dce7f237a2c9668ce15c7465aec7b41221527e0d3be6a223f21b9408bf77b2'},
  {'code' : 'print HASH("SHA", 384, 1, "test", "testkey")', 'expectedOutput' : '49fb5e996a343d968c24ebd6e7a183069d4aeaa288a21b822380aee419be6b73c3609a31793a128a5aa7a104483c01c9'},
  {'code' : 'print HASH("SHA", 512, 1, "test", "testkey")', 'expectedOutput' : '9933ce5d421aa8c9a4bd589a3b3810e45cd03628a304ff489b2c4098285da1e98b58c3f2f8f68ec25d3532ffc2b292ebe6d135ee9bc29a6dd31fde091e5662ba'},

  {'code' : 'print HASH("SHA3", 0, 1, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("SHA3", 0, 0, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("SHA3", 224, 0, "test", "testkey")', 'expectedOutput' : '07996822081c229c52f770c3a7a476d48a4bd51f7fd1e9bcb9142433'},
  {'code' : 'print HASH("SHA3", 256, 0, "test", "testkey")', 'expectedOutput' : 'a66d92823267bed0f683c956e5bd158611d8b28b7ec49db2603332cd09cc754c'},
  {'code' : 'print HASH("SHA3", 384, 0, "test", "testkey")', 'expectedOutput' : '37d8bbd2a9cff4b0b9e8a8a4b9c44d1ef4222733d5f2ad6e14b2e56f810207e39fa7307158c0c20365b67385940be65d'},
  {'code' : 'print HASH("SHA3", 512, 0, "test", "testkey")', 'expectedOutput' : 'd045c496930952d061cc0fe2c7f65ff054ffe42e618efc1f479b328f763e70ae5e007415e90ed41811e8b6f20487e045ccf65940f06ef86d060ef99c73a754c2'},
  {'code' : 'print HASH("SHA3", 224, 1, "test", "testkey")', 'expectedOutput' : '7e59f50721bd1973101bb7c3ea6d5377976cdf0b22a5986f781adb27'},
  {'code' : 'print HASH("SHA3", 256, 1, "test", "testkey")', 'expectedOutput' : '3a14de1008d5aab3dba1fefbac55aa91c084ac7566a88149970703ae541c50f7'},
  {'code' : 'print HASH("SHA3", 384, 1, "test", "testkey")', 'expectedOutput' : 'd30492bf73bfd371cbbc2d083b0c1e5c761613f2f35da5cc447fc608e480f65b8556438133a5d57e55603cb35c8cf906'},
  {'code' : 'print HASH("SHA3", 512, 1, "test", "testkey")', 'expectedOutput' : '8f9c1ebb64b74f1451dabd0cc13040be38c309e943eeab7140adbf5b335e5770a9a4be5251619d1ddf7266872a2d56ff07751a8ce967d316e6df511b8a48bc56'},

  {'code' : 'print HASH("BLAKE2B", 0, 1, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("BLAKE2B", 0, 0, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("BLAKE2B", 160, 1, "test", "testkey")', 'expectedOutput' : 'b1db97883efc89b3df71ddf3b45fa55712ad5b83'},
  {'code' : 'print HASH("BLAKE2B", 160, 0, "test", "testkey")', 'expectedOutput' : 'b1db97883efc89b3df71ddf3b45fa55712ad5b83'},
  {'code' : 'print HASH("BLAKE2B", 224, 0, "test", "testkey")', 'expectedOutput' : '3d5211888d78d39ab22a57b92d84bcad4b9fa45d749cb1def8ab39d7'},
  {'code' : 'print HASH("BLAKE2B", 256, 0, "test", "testkey")', 'expectedOutput' : '7af630cfe6d6c180dc56caabc76c36965185eabbd71c0a0b4ef800298d147816'},
  {'code' : 'print HASH("BLAKE2B", 384, 0, "test", "testkey")', 'expectedOutput' : 'bee6b898a14785913fc2c121b666170578f357ea46cc14370d8bfc01fa54812d306ef6dbd346173893d554cf6589f894'},
  {'code' : 'print HASH("BLAKE2B", 512, 0, "test", "testkey")', 'expectedOutput' : '084d84423e6d5d1309b6fb5217fad337865a53bd65953dd9d32ff25e8cbcf9e5e364bea513aab7ca3cce843fbcfa3810c76ead70d861af1b32f1eccdfd7ca84f'},

  {'code' : 'print HASH("KECCAK", 0, 1, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("KECCAK", 0, 0, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("KECCAK", 128, 1, "test", "testkey")', 'expectedOutput' : 'dfbab27f41c913da5aeac1f311b6c00c'},
  {'code' : 'print HASH("KECCAK", 128, 0, "test", "testkey")', 'expectedOutput' : 'dfbab27f41c913da5aeac1f311b6c00c'},
  {'code' : 'print HASH("KECCAK", 256, 0, "test", "testkey")', 'expectedOutput' : '45b159868255e01c6aa075b4af4f5a62d5096270bbd61ba6988605395ee7356f'},
  {'code' : 'print HASH("KECCAK", 288, 0, "test", "testkey")', 'expectedOutput' : 'e34f55fb60f63c09ec7e4aa0e26535b3ac3b88f7bbd925f0c46ecf72e0b61372280f16b9'},
  {'code' : 'print HASH("KECCAK", 384, 0, "test", "testkey")', 'expectedOutput' : '6d82eeeaa7a3f1b2d5d891a3d4d7d2f3bc52c6c24d426f01d448a7d574cca4391e6f068530a3c9fdb32b40fc88c209d7'},
  {'code' : 'print HASH("KECCAK", 512, 0, "test", "testkey")', 'expectedOutput' : '7f5ec6e4c8bb433feddd1ee2a0c1ac347501833d26f3e4ed3cb5abbe62f03b67b9ca5e043280b3651e424c0d92d58774da8acd41dfafa044884262c77f19e3dc'},

  {'code' : 'print HASH("RIPEMD", 0, 1, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("RIPEMD", 0, 0, "test", "testkey")', 'expectedOutput' : '', 'error': 'gcwizard_script_invalid_hashbitrate'},
  {'code' : 'print HASH("RIPEMD", 128, 0, "test", "testkey")', 'expectedOutput' : '79732ce718a2abf9a7775fb4eafe22d6'},
  {'code' : 'print HASH("RIPEMD", 160, 0, "test", "testkey")', 'expectedOutput' : '15b94ec55342397a2edf3b6d0348e14793982d83'},
  {'code' : 'print HASH("RIPEMD", 256, 0, "test", "testkey")', 'expectedOutput' : 'ccd47970a5fade4b2fd40ebfc3f4d945c7b69394736c9d060f88435f8bd683de'},
  {'code' : 'print HASH("RIPEMD", 320, 0, "test", "testkey")', 'expectedOutput' : '54f6c14817dac5732c3c69b1d3cfc14390718bfe1f615e3ec1fe1d0a526f8a669dfe1148b493454c'},
  {'code' : 'print HASH("RIPEMD", 128, 1, "test", "testkey")', 'expectedOutput' : 'b6cf4863a0c48c6a862b9b26e2b8128c'},
  {'code' : 'print HASH("RIPEMD", 160, 1, "test", "testkey")', 'expectedOutput' : '6c1ef2a15f9809ffe40e98f3306289670199fe18'},
  {'code' : 'print HASH("RIPEMD", 256, 1, "test", "testkey")', 'expectedOutput' : '76ca93440e9fb7d8b73eaa98e47dfde3cb168fcae409dbd02d127e1e8183e460'},
  {'code' : 'print HASH("RIPEMD", 320, 1, "test", "testkey")', 'expectedOutput' : '35b559e8382825920b1bcecda6d47afb61dbf6d51bbab779b10c7ca084f58c5d912423ecb5af6b26'},

  {'code' : 'print HASH("TIGER", 0, 0, "test", "testkey")', 'expectedOutput' : '9cc3b801052e39991ec9d1b8a4c60dcaf48ba50c47623dae'},
  {'code' : 'print HASH("TIGER", 0, 1, "test", "testkey")', 'expectedOutput' : '83ec22f43ad36d9fb5993e149fd98d1f7ec3afce09066278'},

  {'code' : 'print HASH("WHIRLPOOL", 0, 0, "test", "testkey")', 'expectedOutput' : '0f60dbaeb4be897a4ffffe85ca56d831eb5fc8222e63b4588ff6b7946c94927955a47a231612174ba614e8f3016f58455aae26feaa4a05a1090ad0ced1bc6193'},
  {'code' : 'print HASH("WHIRLPOOL", 0, 1, "test", "testkey")', 'expectedOutput' : '63646cacdd6d6e2bcc3d296306701758c0605718bb2da04429dcdccacc5db6dd54de01187316ef2f5eec7a1b83ec98101bb8bb3b511255ec5e5c42d9bb984a2b'},
];