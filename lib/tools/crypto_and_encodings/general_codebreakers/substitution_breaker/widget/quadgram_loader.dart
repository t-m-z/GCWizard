import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/logic/substitution_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/logic/substitution_breaker_enums.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/logic/substitution_logic_aggregator.dart';
import 'package:gc_wizard/utils/json_utils.dart';

Future<Quadgrams?> loadQuadgramsAssets(SubstitutionBreakerAlphabet alphabet, BuildContext context,
    Map<SubstitutionBreakerAlphabet, Quadgrams> quadgramsMap, List<bool> isLoading) async {
  while (isLoading[0]) {}

  if (quadgramsMap.containsKey(alphabet)) return quadgramsMap[alphabet];

  isLoading[0] = true;

  Quadgrams? quadgrams = getQuadgrams(alphabet);
  if (quadgrams == null) return null;

  String data = await DefaultAssetBundle.of(context).loadString(quadgrams.assetLocation);
  Map<String, dynamic> jsonData = asJsonMap(jsonDecode(data));
  quadgrams.quadgramsCompressed = <int, List<int>>{};
  for (var entry in jsonData.entries) {
    quadgrams.quadgramsCompressed!
        .putIfAbsent(int.tryParse(entry.key) ?? 0, () => List<int>.from(entry.value as Iterable<dynamic>));
  }

  quadgramsMap.putIfAbsent(alphabet, () => quadgrams);

  isLoading[0] = false;

  return quadgrams;
}
