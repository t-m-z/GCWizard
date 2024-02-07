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
          ['I', '1', '', 'XXIII', '23'],
          ['II', '2', '', '', '24'],
          ['III', '3', '', '', '25'],
          ['IV', '4', '', '', '26'],
          ['V', '5', '', '', '27'],
          ['VI', '6', '', '', '28'],
          ['VII', '7', '', '', '29'],
          ['VIII', '8', '', 'XXX', '30'],
          ['IX', '9', '', 'XL', '40'],
          ['X', '10', '', 'L', '50'],
          ['XI', '11', '', 'LX', '60'],
          ['XII', '12', '', 'LXX', '70'],
          ['XIII', '13', '', 'LXXX', '80'],
          ['XIV', '14', '', 'XC', '90'],
          ['XV', '15', '', 'C', '100'],
          ['XVI', '16', '', 'CL', '150'],
          ['XVII', '17', '', 'CC', '200'],
          ['XVIII', '18', '', 'DC', '400'],
          ['XIX', '19', '', 'D', '500'],
          ['XX', '20', '', 'DCCC', '800'],
          ['XXI', '21', '', 'CM', '900'],
          ['XXII', '22', '', 'M', '1000'],
        ]),
      ],
    );
  }
}
