import 'dart:convert';
import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:prefs/prefs.dart';

String className(Widget widget) {
  return widget.runtimeType.toString();
}

enum SpinnerLayout { HORIZONTAL, VERTICAL }

String printErrorMessage(BuildContext context, String message) {
  return i18n(context, 'common_error') + ': ' + i18n(context, message);
}

defaultFontSize() {
  var fontSize = Prefs.get(PREFERENCE_THEME_FONT_SIZE);

  if (fontSize < FONT_SIZE_MIN) {
    Prefs.setDouble(PREFERENCE_THEME_FONT_SIZE, FONT_SIZE_MIN.toDouble());
    return FONT_SIZE_MIN;
  }

  if (fontSize > FONT_SIZE_MAX) {
    Prefs.setDouble(PREFERENCE_THEME_FONT_SIZE, FONT_SIZE_MAX.toDouble());
    return FONT_SIZE_MAX;
  }

  return fontSize;
}

List<Widget> columnedMultiLineOutput(BuildContext context, List<List<dynamic>> data,
    {List<int> flexValues = const [],
    int copyColumn,
    bool suppressCopyButtons: false,
    bool hasHeader: false,
    bool copyAll: false,
    List<Function> tappables,
    double fontSize}) {
  var odd = true;
  var isFirst = true;

  int index = 0;
  return data.where((row) => row != null).map((rowData) {
    Widget output;

    var columns = rowData
        .asMap()
        .map((index, column) {
          var textStyle = gcwTextStyle(fontSize: fontSize);
          if (isFirst && hasHeader) textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);

          var child;

          if (column is Widget) {
            child = column;
          } else {
            if (tappables == null || tappables.isEmpty) {
              child = GCWText(text: column != null ? column.toString() : '', style: textStyle);
            } else {
              child = Text(column != null ? column.toString() : '', style: textStyle);
            }
          }

          return MapEntry(index, Expanded(child: child, flex: index < flexValues.length ? flexValues[index] : 1));
        })
        .values
        .toList();

    if (copyColumn == null) copyColumn = rowData.length - 1;
    var copyText = rowData[copyColumn].toString();
    if (isFirst && hasHeader && copyAll) {
      copyText = '';
      data.where((row) => row != null).skip(1).forEach((dataRow) {
        copyText += dataRow[copyColumn].toString() + '\n';
      });
    }

    var row = Container(
      child: Row(
        children: [
          Expanded(
            child: Row(children: columns),
          ),
          context == null
              ? Container()
              : Container(
                  child: (((isFirst && hasHeader) & !copyAll) || suppressCopyButtons)
                      ? Container()
                      : GCWIconButton(
                          icon: Icons.content_copy,
                          size: IconButtonSize.TINY,
                          onPressed: () {
                            insertIntoGCWClipboard(context, copyText);
                          },
                        ),
                  width: 25,
                  height: 22,
                )
        ],
      ),
      margin: EdgeInsets.only(top: 6, bottom: 6),
    );

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }
    odd = !odd;

    isFirst = false;

    if (tappables != null) {
      return InkWell(
        child: output,
        onTap: tappables[index++],
      );
    } else {
      return output;
    }
  }).toList();
}

insertIntoGCWClipboard(BuildContext context, String text, {useGlobalClipboard: true}) {
  if (useGlobalClipboard) Clipboard.setData(ClipboardData(text: text));

  var gcwClipboard = Prefs.getStringList(PREFERENCE_CLIPBOARD_ITEMS);

  var existingText = gcwClipboard.firstWhere((item) => jsonDecode(item)['text'] == text, orElse: () => null);

  if (existingText != null) {
    gcwClipboard.remove(existingText);
    gcwClipboard.insert(
        0,
        jsonEncode(
            {'text': jsonDecode(existingText)['text'], 'created': DateTime.now().millisecondsSinceEpoch.toString()}));
  } else {
    gcwClipboard.insert(0, jsonEncode({'text': text, 'created': DateTime.now().millisecondsSinceEpoch.toString()}));
    while (gcwClipboard.length > Prefs.get(PREFERENCE_CLIPBOARD_MAX_ITEMS)) gcwClipboard.removeLast();
  }

  Prefs.setStringList(PREFERENCE_CLIPBOARD_ITEMS, gcwClipboard);

  if (useGlobalClipboard) showToast(i18n(context, 'common_clipboard_copied') + ':\n' + text);
}

String textControllerInsertText(String input, String currentText, TextEditingController textController) {
  var cursorPosition = max(textController.selection.end, 0);

  currentText = currentText.substring(0, cursorPosition) + input + currentText.substring(cursorPosition);
  textController.text = currentText;
  textController.selection = TextSelection.collapsed(offset: cursorPosition + input.length);

  return currentText;
}

String textControllerDoBackSpace(String currentText, TextEditingController textController) {
  var cursorPosition = max(textController.selection.end, 0);
  if (cursorPosition == 0) return currentText;

  currentText = currentText.substring(0, cursorPosition - 1) + currentText.substring(cursorPosition);
  textController.text = currentText;
  textController.selection = TextSelection.collapsed(offset: cursorPosition - 1);

  return currentText;
}

double maxScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - 100;
}

int sortToolListAlphabetically(GCWTool a, GCWTool b) {
  return removeDiacritics(a.toolName).toLowerCase().compareTo(removeDiacritics(b.toolName).toLowerCase());
}
