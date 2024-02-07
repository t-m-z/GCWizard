import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';

class GCCTableResistor5 extends StatefulWidget {
  const GCCTableResistor5({Key? key}) : super(key: key);

  @override
  _GCCTableResistor5State createState() => _GCCTableResistor5State();
}

class _GCCTableResistor5State extends State<GCCTableResistor5> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Container(alignment: AlignmentDirectional.center,
              child: Text(i18n(context, 'gcc_tables_resistors_color')),),
            Container(alignment: AlignmentDirectional.center,
              child: Text(i18n(context, 'gcc_tables_resistors_ring') + ' 1, 2'),),
            Container(alignment: AlignmentDirectional.center,
              child: Text(i18n(context, 'gcc_tables_resistors_ring') + ' 3'),),
            Container(alignment: AlignmentDirectional.center,
              child: Text(i18n(context, 'gcc_tables_resistors_ring') + ' 4'),),
            Container(alignment: AlignmentDirectional.center,
              child: Text(i18n(context, 'gcc_tables_resistors_ring') + ' 5'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(),
            Container(),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('0.01'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 10 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(),
            Container(),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('0.1'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 5 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('-'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('0'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('1'),
            ),
            Container(),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('1'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('1'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('10'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 1 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('2'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('2'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('100'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 2 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('3'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('3'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('1 K'),),
            Container(),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('4'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('4'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('10 K'),),
            Container(),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('5'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('5'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('100 K'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 0.50 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('6'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('6'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('1 M'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 0.25 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('7'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('7'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('10 M'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 0.10 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('8'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('8'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('100 M'),),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('\u00B1 0.05 %'),),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN, horizontal: DOUBLE_DEFAULT_MARGIN),
                  margin: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),child: const Text(''),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('9'),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('9'),
            ),
            Container(alignment: AlignmentDirectional.center,
              child: const Text('1 G'),),
            Container(),
          ],
        ),
      ],
    );
  }
}