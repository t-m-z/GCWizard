import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/gcc_symbols_selection.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/gcc_tables_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/base_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/colors_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/coords_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/crosssum_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/dna_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/e_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/hash_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/periodic_table_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/phi_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/pi_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/primes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/roman_numbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/scrabble_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/vigenere_selection.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/main_menu/about.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/settings/widget/settings_coordinates.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/adfgvx/widget/adfgvx.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/affine/widget/affine.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/alphabet_values/widget/alphabet_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/atbash/widget/atbash.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/widget/bacon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/caesar/widget/caesar.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/chao/widget/chao.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/charsets/ascii_values/widget/ascii_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enigma/widget/enigma.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/widget/brainfk.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/deadfish/widget/deadfish.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gade/widget/gade.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gc_code/widget/gc_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gray/widget/gray.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/homophone/widget/homophone.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/kamasutra/widget/kamasutra.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/kenny/widget/kenny.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/pig_latin/widget/pig_latin.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/morse/widget/morse.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/one_time_pad/widget/one_time_pad.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/playfair/widget/playfair.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/widget/polybios.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rail_fence/widget/rail_fence.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rc4/widget/rc4.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/reverse/widget/reverse.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot13/widget/rot13.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotation_general/widget/rotation_general.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa/widget/rsa.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/skytale/widget/skytale.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/solitaire/widget/solitaire.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/widget/substitution.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tap_code/widget/tap_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tapir/widget/tapir.dart';
import 'package:gc_wizard/tools/formula_solver/widget/formula_solver_formulagroups.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/heat_index/widget/heat_index.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/windchill/widget/windchill.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/permutation/widget/permutation.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/widget/numeral_bases.dart';
import 'package:gc_wizard/tools/science_and_technology/projectiles/widget/projectiles.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/z22/widget/z22.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class GCCView extends StatefulWidget {
  const GCCView({
    Key? key,
  }) : super(key: key);

  @override
  _GCCViewState createState() => _GCCViewState();
}

class _GCCViewState extends State<GCCView> {

  Future<void> _navigateToSubPage(GCWTool tool) async {
    Navigator.push(context, NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => tool));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.orientation == Orientation.portrait){
      return _portrait();
    } else{// is landscape
      return _landscape();
    }

  }

  Widget _portrait(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        children: [
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ADFGVX()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/adfgvx.png', width: 75, height: 75),
                        Text(i18n(context, 'adfgvx_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Affine()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/affine.png', width: 75, height: 75),
                        Text(i18n(context, 'affine_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ASCIIValues()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/ascii.png', width: 75, height: 75),
                        Text(i18n(context, 'asciivalues_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const AstronomySelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/astronomy.png', width: 75, height: 75),
                        Text(i18n(context, 'astronomy_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Atbash()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/atbash.png', width: 75, height: 75),
                        Text(i18n(context, 'atbash_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Bacon()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/bacon.png', width: 75, height: 75),
                        Text(i18n(context, 'bacon_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const BaseSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/base.png', width: 75, height: 75),
                        Text(i18n(context, 'base_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const BCDSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/bcd.png', width: 75, height: 75),
                        Text(i18n(context, 'bcd_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Brainfk()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/brainfck.png', width: 75, height: 75),
                        Text(i18n(context, 'brainfk_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(AlphabetValues()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/asciivalues.png', width: 75, height: 75),
                        Text(i18n(context, 'alphabetvalues_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Caesar()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/caesar.png', width: 75, height: 75),
                        Text(i18n(context, 'caesar_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Chao()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/chaocipher.png', width: 75, height: 75),
                        Text(i18n(context, 'chao_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Deadfish()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/deadfish.png', width: 75, height: 75),
                        Text(i18n(context, 'deadfish_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const DNASelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/dna.png', width: 75, height: 75),
                        Text(i18n(context, 'dna_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ESelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/euler.png', width: 75, height: 75),
                        Text(i18n(context, 'e_selection_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Enigma()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/enigma.png', width: 75, height: 75),
                        Text(i18n(context, 'enigma_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Substitution()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/substitution.png', width: 75, height: 75),
                        Text(i18n(context, 'substitution_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ColorsSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/color.png', width: 75, height: 75),
                        Text(i18n(context, 'colors_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const FormulaSolverFormulaGroups()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/formula.png', width: 75, height: 75),
                        Text(i18n(context, 'formulasolver_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Gade()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/gade.png', width: 75, height: 75),
                        Text(i18n(context, 'gade_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const GCCode()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/gccode.png', width: 75, height: 75),
                        Text(i18n(context, 'gccode_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Projectiles()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/projectiles.png', width: 75, height: 75),
                        Text(i18n(context, 'projectiles_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Gray()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/gray.png', width: 75, height: 75),
                        Text(i18n(context, 'gray_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const HashSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/hash.png', width: 75, height: 75),
                        Text(i18n(context, 'hashes_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Rot13()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rot13.png', width: 75, height: 75),
                        Text(i18n(context, 'rotation_rot13_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const HeatIndex()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/heatindex.png', width: 75, height: 75),
                        Text(i18n(context, 'heatindex_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Homophone()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/homophone.png', width: 75, height: 75),
                        Text(i18n(context, 'homophone_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Kamasutra()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/kamasutra.png', width: 75, height: 75),
                        Text(i18n(context, 'kamasutra_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Kenny()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/kenny.png', width: 75, height: 75),
                        Text(i18n(context, 'kenny_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const TapCode()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/tapcode.png', width: 75, height: 75),
                        Text(i18n(context, 'tapcode_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const CoordsSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/coordinates.png', width: 75, height: 75),
                        Text(i18n(context, 'coords_selection_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RailFence()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/railfence.png', width: 75, height: 75),
                        Text(i18n(context, 'railfence_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Morse()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/morse.png', width: 75, height: 75),
                        Text(i18n(context, 'morse_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const GCCSymbolsSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/symbols.png', width: 75, height: 75),
                        const Text('MyGeoTools'),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(OneTimePad()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/onetimepad.png', width: 75, height: 75),
                        Text(i18n(context, 'onetimepad_title')),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PeriodicTableSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/periodictable.png', width: 75, height: 75),
                        Text(i18n(context, 'periodictable_selection_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Permutation()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/permutation.png', width: 75, height: 75),
                        Text(i18n(context, 'combinatorics_permutation_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PhiSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/phi.png', width: 75, height: 75),
                        Text(i18n(context, 'phi_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PiSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/pi.png', width: 75, height: 75),
                        Text(i18n(context, 'pi_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PigLatin()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/piglatin.png', width: 75, height: 75),
                        Text(i18n(context, 'piglatin_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Playfair()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/playfair.png', width: 75, height: 75),
                        Text(i18n(context, 'playfair_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Polybios()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/polybios.png', width: 75, height: 75),
                        Text(i18n(context, 'polybios_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PrimesSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/primes.png', width: 75, height: 75),
                        Text(i18n(context, 'primes_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const CrossSumSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/sum.png', width: 75, height: 75),
                        Text(i18n(context, 'crosssum_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RC4()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rc4.png', width: 75, height: 75),
                        Text(i18n(context, 'rc4_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RotationSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rotx.png', width: 75, height: 75),
                        Text(i18n(context, 'rotation_selection_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(RotationGeneral()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rotation.png', width: 75, height: 75),
                        Text(i18n(context, 'rotation_general_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RSA()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rsa.png', width: 75, height: 75),
                        Text(i18n(context, 'rsa_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RomanNumbersSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/roman.png', width: 75, height: 75),
                        Text(i18n(context, 'romannumbers_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ScrabbleSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/scrabble.png', width: 75, height: 75),
                        Text(i18n(context, 'scrabble_selection_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Skytale()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/scytale.png', width: 75, height: 75),
                        Text(i18n(context, 'skytale_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Solitaire()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/solitaire.png', width: 75, height: 75),
                        Text(i18n(context, 'solitaire_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const GCCTableSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/tables.png', width: 75, height: 75),
                        Text(i18n(context, 'gcc_tables_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Tapir()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/tapir.png', width: 75, height: 75),
                        Text(i18n(context, 'tapir_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const VanitySelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/telephone.png', width: 75, height: 75),
                        Text(i18n(context, 'vanity_selection_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Reverse()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/reverse.png', width: 75, height: 75),
                        Text(i18n(context, 'reverse_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const VigenereSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/vigenere.png', width: 75, height: 75),
                        Text(i18n(context, 'vigenere_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ResistorSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/resistor.png', width: 75, height: 75),
                        Text(i18n(context, 'resistor_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Windchill()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/windchill.png', width: 75, height: 75),
                        Text(i18n(context, 'windchill_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const NumeralBases()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/numbersystem.png', width: 75, height: 75),
                        Text(i18n(context, 'numeralbases_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Z22()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/z22.png', width: 75, height: 75),
                        Text(i18n(context, 'z22_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const CoordinatesSettings()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/settings.png', width: 75, height: 75),
                        Text(i18n(context, 'settings_coordinates_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const About()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/about.png', width: 75, height: 75),
                        Text(i18n(context, 'about_version'),),
                      ],
                    )),
              ),
              Container(
              ),
              Container(
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _landscape(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        children: [
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ADFGVX()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/adfgvx.png', width: 75, height: 75),
                        Text(i18n(context, 'adfgvx_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Affine()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/affine.png', width: 75, height: 75),
                        Text(i18n(context, 'affine_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ASCIIValues()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/ascii.png', width: 75, height: 75),
                        Text(i18n(context, 'asciivalues_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const AstronomySelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/astronomy.png', width: 75, height: 75),
                        Text(i18n(context, 'astronomy_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Atbash()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/atbash.png', width: 75, height: 75),
                        Text(i18n(context, 'atbash_title'),),
                      ],
                    )),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Bacon()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/bacon.png', width: 75, height: 75),
                        Text(i18n(context, 'bacon_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const BaseSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/base.png', width: 75, height: 75),
                        Text(i18n(context, 'base_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const BCDSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/bcd.png', width: 75, height: 75),
                        Text(i18n(context, 'bcd_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Brainfk()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/brainfck.png', width: 75, height: 75),
                        Text(i18n(context, 'brainfk_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(AlphabetValues()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/asciivalues.png', width: 75, height: 75),
                        Text(i18n(context, 'alphabetvalues_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Caesar()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/caesar.png', width: 75, height: 75),
                        Text(i18n(context, 'caesar_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Chao()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/chaocipher.png', width: 75, height: 75),
                        Text(i18n(context, 'chao_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Deadfish()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/deadfish.png', width: 75, height: 75),
                        Text(i18n(context, 'deadfish_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const DNASelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/dna.png', width: 75, height: 75),
                        Text(i18n(context, 'dna_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ESelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/euler.png', width: 75, height: 75),
                        Text(i18n(context, 'e_selection_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Enigma()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/enigma.png', width: 75, height: 75),
                        Text(i18n(context, 'enigma_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Substitution()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/substitution.png', width: 75, height: 75),
                        Text(i18n(context, 'substitution_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ColorsSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/color.png', width: 75, height: 75),
                        Text(i18n(context, 'colors_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const FormulaSolverFormulaGroups()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/formula.png', width: 75, height: 75),
                        Text(i18n(context, 'formulasolver_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Gade()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/gade.png', width: 75, height: 75),
                        Text(i18n(context, 'gade_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const GCCode()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/gccode.png', width: 75, height: 75),
                        Text(i18n(context, 'gccode_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Projectiles()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/projectiles.png', width: 75, height: 75),
                        Text(i18n(context, 'projectiles_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Gray()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/gray.png', width: 75, height: 75),
                        Text(i18n(context, 'gray_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const HashSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/hash.png', width: 75, height: 75),
                        Text(i18n(context, 'hashes_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Rot13()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rot13.png', width: 75, height: 75),
                        Text(i18n(context, 'rotation_rot13_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const HeatIndex()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/heatindex.png', width: 75, height: 75),
                        Text(i18n(context, 'heatindex_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Homophone()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/homophone.png', width: 75, height: 75),
                        Text(i18n(context, 'homophone_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Kamasutra()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/kamasutra.png', width: 75, height: 75),
                        Text(i18n(context, 'kamasutra_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Kenny()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/kenny.png', width: 75, height: 75),
                        Text(i18n(context, 'kenny_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const TapCode()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/tapcode.png', width: 75, height: 75),
                        Text(i18n(context, 'tapcode_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const CoordsSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/coordinates.png', width: 75, height: 75),
                        Text(i18n(context, 'coords_selection_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RailFence()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/railfence.png', width: 75, height: 75),
                        Text(i18n(context, 'railfence_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Morse()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/morse.png', width: 75, height: 75),
                        Text(i18n(context, 'morse_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const GCCSymbolsSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/symbols.png', width: 75, height: 75),
                        const Text('MyGeoTools'),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(OneTimePad()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/onetimepad.png', width: 75, height: 75),
                        Text(i18n(context, 'onetimepad_title')),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PeriodicTableSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/periodictable.png', width: 75, height: 75),
                        Text(i18n(context, 'periodictable_selection_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Permutation()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/permutation.png', width: 75, height: 75),
                        Text(i18n(context, 'combinatorics_permutation_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PhiSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/phi.png', width: 75, height: 75),
                        Text(i18n(context, 'phi_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PiSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/pi.png', width: 75, height: 75),
                        Text(i18n(context, 'pi_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PigLatin()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/piglatin.png', width: 75, height: 75),
                        Text(i18n(context, 'piglatin_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Playfair()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/playfair.png', width: 75, height: 75),
                        Text(i18n(context, 'playfair_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Polybios()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/polybios.png', width: 75, height: 75),
                        Text(i18n(context, 'polybios_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const PrimesSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/primes.png', width: 75, height: 75),
                        Text(i18n(context, 'primes_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const CrossSumSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/sum.png', width: 75, height: 75),
                        Text(i18n(context, 'crosssum_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RC4()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rc4.png', width: 75, height: 75),
                        Text(i18n(context, 'rc4_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RotationSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rotx.png', width: 75, height: 75),
                        Text(i18n(context, 'rotation_selection_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(RotationGeneral()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rotation.png', width: 75, height: 75),
                        Text(i18n(context, 'rotation_general_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RSA()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/rsa.png', width: 75, height: 75),
                        Text(i18n(context, 'rsa_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const RomanNumbersSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/roman.png', width: 75, height: 75),
                        Text(i18n(context, 'romannumbers_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ScrabbleSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/scrabble.png', width: 75, height: 75),
                        Text(i18n(context, 'scrabble_selection_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Skytale()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/scytale.png', width: 75, height: 75),
                        Text(i18n(context, 'skytale_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Solitaire()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/solitaire.png', width: 75, height: 75),
                        Text(i18n(context, 'solitaire_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const GCCTableSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/tables.png', width: 75, height: 75),
                        Text(i18n(context, 'gcc_tables_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(Tapir()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/tapir.png', width: 75, height: 75),
                        Text(i18n(context, 'tapir_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const VanitySelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/telephone.png', width: 75, height: 75),
                        Text(i18n(context, 'vanity_selection_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Reverse()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/reverse.png', width: 75, height: 75),
                        Text(i18n(context, 'reverse_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const VigenereSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/vigenere.png', width: 75, height: 75),
                        Text(i18n(context, 'vigenere_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const ResistorSelection()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/resistor.png', width: 75, height: 75),
                        Text(i18n(context, 'resistor_selection_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Windchill()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/windchill.png', width: 75, height: 75),
                        Text(i18n(context, 'windchill_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const NumeralBases()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/numbersystem.png', width: 75, height: 75),
                        Text(i18n(context, 'numeralbases_title'),),
                      ],
                    )),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const Z22()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/z22.png', width: 75, height: 75),
                        Text(i18n(context, 'z22_title'),),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const CoordinatesSettings()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/settings.png', width: 75, height: 75),
                        Text(i18n(context, 'settings_coordinates_title'),),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                child: GestureDetector(
                    onTap: () {
                      // Handle icon tap
                      _navigateToSubPage(registeredTools.where((element) {
                        return [
                          className(const About()),
                        ].contains(className(element.tool));
                      }).toList()[0]);
                    },
                    child: Column(
                      children: [
                        Image.asset('lib/application/category_views/gcc/icons/about.png', width: 75, height: 75),
                        Text(i18n(context, 'about_version'),),
                      ],
                    )),
              ),
              Container(
              ),
              Container(
              ),
              Container(
              ),
              Container(
              ),
              Container(
              ),
              Container(
              ),
              Container(
              ),
            ],
          ),

        ],
      ),
    );
  }
}
