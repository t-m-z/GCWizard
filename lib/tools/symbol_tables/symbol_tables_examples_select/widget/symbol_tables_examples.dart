import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/logic/symbol_table_data.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_table_text_to_symbols.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_table_tool.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_table_zoom_buttons.dart';
import 'package:prefs/prefs.dart';

class SymbolTableExamples extends StatefulWidget {
  final List<String> symbolKeys;

  const SymbolTableExamples({Key? key, required this.symbolKeys}) : super(key: key);

  @override
 _SymbolTableExamplesState createState() => _SymbolTableExamplesState();
}

class _SymbolTableExamplesState extends State<SymbolTableExamples> {
  late TextEditingController _controller;
  String _currentInput = 'ABC123';

  var symbolKeys = <String>[];

  Map<String, SymbolTableData> data = {};

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);

    _initialize();
  }

  Future<void> _initialize() async {
    if (widget.symbolKeys.isEmpty) {
      return;
    }

    symbolKeys = List.from(widget.symbolKeys);

    for (String symbolKey in symbolKeys) {
      var symbolTableData = SymbolTableData(context, symbolKey);
      await symbolTableData.initialize();
      data.putIfAbsent(symbolKey, () => symbolTableData);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.getInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT)
        : Prefs.getInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE);

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'symboltablesexamples_exampletext'),
          suppressTopSpace: true,
        ),
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextDivider(
            text: i18n(context, 'common_output'),
            suppressTopSpace: true,
            trailing: GCWSymbolTableZoomButtons(
              countColumns: countColumns,
              mediaQueryData: mediaQueryData,
              onChanged: () {
                setState(() {});
              },
            )),
        Expanded(
          child: _createSymbols(countColumns),
        )
      ],
    );
  }

  Widget _createSymbols(int countColumns) {
    if (data.isEmpty) return Container();

    var symbols = symbolKeys.map<Widget>((symbolKey) {
      var tableOutput = GCWSymbolTableTextToSymbols(
          text: _currentInput,
          ignoreUnknown: true,
          countColumns: countColumns,
          data: data[symbolKey]!,
          showExportButton: false,
          specialEncryption: false,
          fixed: true);

      return Column(
        children: [
          GCWTextDivider(
              text: i18n(context, 'symboltables_${symbolKey}_title'),
              trailing: GCWIconButton(
                icon: Icons.open_in_new,
                size: IconButtonSize.SMALL,
                onPressed: () {
                  Navigator.push(
                      context,
                      NoAnimationMaterialPageRoute<GCWSymbolTableTool>(
                          builder: (context) => GCWSymbolTableTool(
                                symbolKey: symbolKey,
                                symbolSearchStrings: const [],
                              )));
                },
              )),
          tableOutput
        ],
      );
    }).toList();

    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        primary: true,
        child: Column(
            children: symbols
        )
    );
  }
}
