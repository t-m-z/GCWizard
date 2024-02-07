import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';

class GCCTableRoman extends StatefulWidget {
  const GCCTableRoman({Key? key}) : super(key: key);

  @override
  _GCCTableRomanState createState() => _GCCTableRomanState();
}

class _GCCTableRomanState extends State<GCCTableRoman> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GCWColumnedMultilineOutput(flexValues: [
          4,
          2,
          2,
          4,
          2
        ], data: [
          ['I', '1', '', 'XXX', '30'],
          ['II', '2', '', 'XL', '40'],
          ['III', '3', '', 'L', '50'],
          ['IV', '4', '', 'LX', '60'],
          ['V', '5', '', 'LXX', '70'],
          ['VI', '6', '', 'LXXX', '80'],
          ['VII', '7', '', 'XC', '90'],
          ['VIII', '8', '', 'C', '100'],
          ['IX', '9', '', 'CL', '150'],
          ['X', '10', '', 'CC', '200'],
          ['XI', '11', '', 'CCC', '300'],
          ['XII', '12', '', 'CD', '400'],
          ['XIII', '13', '', 'D', '500'],
          ['XIV', '14', '', 'XC', '600'],
          ['XV', '15', '', 'C', '700'],
          ['XVI', '16', '', 'CL', '800'],
          ['XVII', '17', '', 'CC', '900'],
          ['XVIII', '18', '', 'M', '1000'],
          ['XIX', '19', '', 'MC', '1100'],
          ['XX', '20', '', 'MD', '1500'],
          ['XXI', '21', '', 'MM', '2000'],
          ['XXII', '22', '', 'MMM', '3000'],
          ['XXIII', '23', '', '', ''],
          ['XXIV', '24', '', '', ''],
          ['XXV', '25', '', '', ''],
          ['XXVI', '26', '', '', ''],
          ['XXVII', '27', '', '', ''],
          ['XXVIII', '28', '', '', ''],
          ['XXIX', '29', '', '', ''],
        ]),
      ],
    );
  }
}
