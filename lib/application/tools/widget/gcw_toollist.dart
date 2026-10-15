import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/app_builder.dart';
import 'package:gc_wizard/application/category_views/all_tools_view.dart';
import 'package:gc_wizard/application/category_views/favorites.dart';
import 'package:gc_wizard/application/category_views/tabs.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/symbol_table.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';

class GCWToolList extends StatefulWidget {
  final Iterable<GCWTool> toolList;

  const GCWToolList({super.key, required this.toolList});

  @override
  _GCWToolListState createState() => _GCWToolListState();
}

class _GCWToolListState extends State<GCWToolList> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: _buildItems(),
    );
  }

  Widget _buildItems() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.toolList.length + 1,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int i) {
        return _buildRow(context, i);
      },
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    final model = context.watch<TabsModel>();

    // Vertical space after the list items
    if (index == widget.toolList.length) {
      return const ListTile();
    }

    var tool = widget.toolList.elementAt(index);

    Future<void> _navigateToSubPage(BuildContext context) async {
      Navigator.push(
        context,
        NoAnimationMaterialPageRoute<Object?>(
          settings: RouteSettings(name: Uri.encodeComponent(tool.toolName ?? '')),
          builder: (context) => tool
        )
      );
    }

    return ListTile(
      title: Row(
        children: [
          if (tool.isBeta)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
              margin: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
              color: themeColors().secondary(),
              child: Text(
                'BETA',
                style: gcwBetaStyle(),
              ),
            ),
          Expanded(
            child: Text(
              tool.toolName ?? UNKNOWN_ELEMENT,
              style: gcwTextStyle(),
            ),
          )
        ],
      ),
      subtitle: _buildDescription(context, tool),
      onLongPress: () {
        setState(() {
          model.addTab(tool);
          showSnackBar(i18n(context, 'tabs_tab_created', parameters: [tool.toolName]), context);
        });
      },
      onTap: () {
        setState(() {
          _navigateToSubPage(context);
          refreshToolLists();
          AppBuilder.of(context).rebuild();
        });
      },
      leading: tool.icon,
      trailing: IconButton(
        icon: tool.isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
        color: themeColors().mainFont(),
        onPressed: () {
          if (tool.isFavorite) {
            _showDeleteFavoriteAlertDialog(context, tool.toolName ?? UNKNOWN_ELEMENT, () {
              Favorites.update(tool.longId, FavoriteChangeStatus.REMOVE);

              setState(() {
                AppBuilder.of(context).rebuild();
              });
            });
          } else {
            setState(() {
              Favorites.update(tool.longId, FavoriteChangeStatus.ADD);

              AppBuilder.of(context).rebuild();
            });
          }
        },
      ),
    );
  }

  Widget? _buildDescription(BuildContext context, GCWTool tool) {
    IgnorePointer? descriptionText;
    if (Prefs.getBool(PREFERENCE_TOOLLIST_SHOW_DESCRIPTIONS) &&
        tool.description != null &&
        tool.description!.isNotEmpty) {
      descriptionText = IgnorePointer(
          child: GCWText(
        text: tool.description!,
        style: gcwDescriptionTextStyle(),
      ));
    }

    IgnorePointer? exampleText;
    if (Prefs.getBool(PREFERENCE_TOOLLIST_SHOW_EXAMPLES) && tool.example != null && tool.example!.isNotEmpty) {
      exampleText = IgnorePointer(child: GCWText(text: tool.example!, style: gcwDescriptionTextStyle()));
    }

    Widget content = Container();
    if (exampleText != null && descriptionText != null) {
      content = Column(
        children: [
          descriptionText,
          Container(padding: const EdgeInsets.only(top: DEFAULT_DESCRIPTION_MARGIN), child: exampleText)
        ],
      );
    } else if (exampleText != null) {
      content = exampleText;
    } else if (descriptionText != null) {
      content = descriptionText;
    }

    return (exampleText ?? descriptionText) != null
        ? Container(
            padding: const EdgeInsets.only(left: DEFAULT_DESCRIPTION_MARGIN),
            child: content,
          )
        : null;
  }
}

void _showDeleteFavoriteAlertDialog(BuildContext context, String deleteableText, void Function() onOKPressed) {
  showGCWAlertDialog(context, i18n(context, 'common_deletealtert_favorite_title'),
      i18n(context, 'common_deletealtert_favorite_text', parameters: [deleteableText]), onOKPressed);
}

Type _classType(Widget widget) {
  return widget.runtimeType;
}

bool ContainsType(Iterable<Type> types, Widget tool) {
  return types.contains(_classType(tool));
}

bool ContainsSymbolTableSymbolKey(Iterable<String> symbolKeys, Widget tool, {bool startsWith = false}) {
  if (_classType(tool) == SymbolTable) {
    if (startsWith) {
      return symbolKeys.firstWhere((symbolKey) =>
          (tool as SymbolTable).symbolKey.startsWith(symbolKey), orElse: () => '').isNotEmpty;
    } else {
      return symbolKeys.contains((tool as SymbolTable).symbolKey);
    }
  }
  return false;
}

Iterable<GCWTool> filterTools(Iterable<Type> toolTypes) {
  return registeredTools.where((element) {
    return ContainsType(toolTypes, element.tool);
  });
}

GCWTool filterFirstTool(Type toolType) {
  return registeredTools.firstWhere((tool) => ContainsType({toolType}, tool.tool));
}

Iterable<GCWTool> filterSymbolTableTools(
    Iterable<String> symbolTables, Iterable<Type> toolTypes, {bool startsWith = false}) {

  return registeredTools.where((element) {
    if (ContainsSymbolTableSymbolKey(symbolTables, element.tool, startsWith: startsWith)) {
      return true;
    }

    return ContainsType(toolTypes, element.tool);
  });
}

Iterable<GCWTool> filterSymbolTableTools2(
    Iterable<String> symbolTables, Iterable<Type> toolTypes, {bool startsWith = false,
      required Iterable<String> symbolTables2}) {

  return registeredTools.where((element) {
    if (ContainsSymbolTableSymbolKey(symbolTables, element.tool, startsWith: startsWith)) {
      return true;
    }
    if (ContainsSymbolTableSymbolKey(symbolTables2, element.tool)) {
      return true;
    }

    return ContainsType(toolTypes, element.tool);
  });
}

Iterable<GCWTool> filterCategory(ToolCategory category, {Iterable<String>? symbolTables}) {
  if (symbolTables == null) {
    return registeredTools.where((element) => element.categories.contains(category));
  } else {
    return registeredTools.where((element) =>
        element.categories.contains(category) ||
        ContainsSymbolTableSymbolKey(symbolTables, element.tool));
  }
}