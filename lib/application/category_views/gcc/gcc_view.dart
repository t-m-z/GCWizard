import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/base_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/dna_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/e_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/hash_selection.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/adfgvx/widget/adfgvx.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/affine/widget/affine.dart';
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
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot13/widget/rot13.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/widget/substitution.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/tools/formula_solver/widget/formula_solver_formulagroups.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/color_tool/widget/color_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/projectiles/widget/projectiles.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class GCCView extends StatefulWidget {
  const GCCView({
    Key? key,
  }) : super(key: key);

  @override
  _GCCViewState createState() => _GCCViewState();
}

class _GCCViewState extends State<GCCView> {
  @override
  Future<void> _navigateToSubPage(GCWTool tool) async {
    Navigator.push(context, NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => tool));
  }

  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
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
                          const Text('ADFGVX'),
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
                          const Text('Affine'),
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
                          const Text('ASCII-UTF'),
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
                          const Text('Astronomy'),
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
                          const Text('Atbash'),
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
                          const Text('Bacon'),
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
                          const Text('Base'),
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
                          const Text('ASCII-UTF'),
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
                          const Text('Brainf*ck'),
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
                            className(ASCIIValues()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/asciivalues.png', width: 75, height: 75),
                          const Text('Buchstaben'),
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
                          const Text('Caesar'),
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
                          const Text('Chaocipher'),
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
                          const Text('Deadfish'),
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
                          const Text('DNA'),
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
                            className(ESelection()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/euler.png', width: 75, height: 75),
                          const Text('e/Euler'),
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
                            className(Enigma()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/enigma.png', width: 75, height: 75),
                          const Text('Enigma'),
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
                          const Text('Ersetzen'),
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
                            className(const ColorTool()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/color.png', width: 75, height: 75),
                          const Text('Farben'),
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
                            className(FormulaSolverFormulaGroups()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/formula.png', width: 75, height: 75),
                          const Text('Formeln'),
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
                            className(Gade()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/gade.png', width: 75, height: 75),
                          const Text('Gade'),
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
                            className(GCCode()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/gccode.png', width: 75, height: 75),
                          const Text('GC Code'),
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
                          const Text('Geschoss'),
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
                          const Text('Gray'),
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
                            className(HashSelection()),
                          ].contains(className(element.tool));
                        }).toList()[0]);
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/application/category_views/gcc/icons/hash.png', width: 75, height: 75),
                          const Text('Hash'),
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
                          const Text('Hint Dec.'),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
