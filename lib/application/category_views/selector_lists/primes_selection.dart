import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_integerfactorization/widget/primes_integerfactorization.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_isprime/widget/primes_isprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_nearestprime/widget/primes_nearestprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_nthprime/widget/primes_nthprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_primeindex/widget/primes_primeindex.dart';

class PrimesSelection extends GCWSelection {
  const PrimesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NthPrime,
        IsPrime,
        NearestPrime,
        PrimeIndex,
        IntegerFactorization
      });

    return GCWToolList(toolList: _toolList);
  }
}
