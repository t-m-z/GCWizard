import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_page_spinner.dart';
import 'package:gc_wizard/tools/games/tridoku/logic/tridoku.dart';
import 'package:gc_wizard/tools/games/tridoku/logic/tridoku_solver.dart';
import 'package:touchable/touchable.dart';

part 'package:gc_wizard/tools/games/tridoku/widget/tridoku_board.dart';

class TridokuSolver extends StatefulWidget {
  const TridokuSolver({super.key});

  @override
  _TridokuSolverState createState() => _TridokuSolverState();
}

class _TridokuSolverState extends State<TridokuSolver> {
  late TridokuBoard _currentBoard;
  int _currentSolution = 0;

  final int _MAX_SOLUTIONS = 1000;

  @override
  void initState() {
    super.initState();

    _currentBoard = TridokuBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWPainterContainer(
          child: _TridokuBoard(
            board: _currentBoard,
            onChanged: (newBoard) {
              setState(() {
                _currentBoard = newBoard;
              });
            },
          ),
        ),
        Container(height: 8 * DOUBLE_DEFAULT_MARGIN),
        if (_currentBoard.solutions != null && _currentBoard.solutions!.length > 1)
          GCWPageSpinner(
            textExtension:  (_currentBoard.solutions!.length >= _MAX_SOLUTIONS ? ' *' : ''),
            max: _currentBoard.solutions!.length,
            index: _currentSolution + 1,
            onChanged: (index) {
              setState(() {
                _currentSolution = index - 1;
                _showSolution();
              });
            },
          ),
        if (_currentBoard.solutions != null && _currentBoard.solutions!.length >= _MAX_SOLUTIONS)
          Container(
            padding: const EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN),
            child: GCWText(text: '*) ' + i18n(context, 'sudokusolver_maximumsolutions')),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
                child: GCWButton(
                  text: i18n(context, 'sudokusolver_solve'),
                  onPressed: () {
                    setState(() {
                      _currentBoard.solveTridoku(_MAX_SOLUTIONS);
                      if (_currentBoard.solutions == null) {
                        showSnackBar(i18n(context, 'sudokusolver_error'), context);
                      } else {
                        _currentSolution = 0;
                        _showSolution();
                      }
                    });
                  },
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
              child: GCWButton(
                text: i18n(context, 'sudokusolver_clearcalculated'),
                onPressed: () {
                  setState(() {
                    _currentBoard.removeCalculated();
                  });
                },
              ),
            )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWButton(
                text: i18n(context, 'sudokusolver_clearall'),
                onPressed: () {
                  showDeleteAlertDialog(
                    context,
                    i18n(context, 'sudokusolver_clearall_board'),
                    () {
                      setState(() {
                        _currentBoard = TridokuBoard();
                      });
                    },
                  );
                },
              ),
            ))
          ],
        )
      ],
    );
  }

  void _showSolution() {
    _currentBoard.mergeSolution(_currentSolution);
  }
}
