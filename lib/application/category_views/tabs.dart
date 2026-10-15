import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:provider/provider.dart';

const DEFAULT_TAB_ID = 0;
const _MAX_DISPLAYNAME_LENGTH = 20;
const _HOMETAB_TITLE = 'Home';

int _currentMaxTabIndex = 0;
int _nextUniqueTabIndex() {
  _currentMaxTabIndex++;
  return _currentMaxTabIndex;
}

class TabsModel extends ChangeNotifier {
  List<TabInfo> tabs = [
    TabInfo(id: DEFAULT_TAB_ID, tool: Container(), navKey: GlobalKey<NavigatorState>())
  ];

  int currentTabIndex = DEFAULT_TAB_ID;

  void addTab(GCWTool tool) {
    var newIndex = _nextUniqueTabIndex();
    tabs.add(TabInfo(
      id: newIndex,
      tool: tool.clone(),
      navKey: GlobalKey<NavigatorState>(),
    ));
    currentTabIndex = tabs.length - 1;
    notifyListeners();
  }

  void switchTab(int index) {
    if (currentTabIndex != index && index >= 0 && index < tabs.length) {
      currentTabIndex = index;
      notifyListeners();
    }
  }

  void removeTab(int id) {
    if (id == DEFAULT_TAB_ID) return;

    final indexToRemove = tabs.indexWhere((t) => t.id == id);
    if (indexToRemove == -1) return;

    tabs.removeAt(indexToRemove);

    if (currentTabIndex == indexToRemove) {
      currentTabIndex = 0;
    } else if (currentTabIndex > indexToRemove) {
      currentTabIndex--;
    }

    notifyListeners();
  }

  void setDefaultTab(Widget tool) {
    tabs.first.tool = tool;
  }

  bool isTabbed(GCWTool tool) {
    var index = tabs.indexWhere((t) => t.tool == tool);
    return index != -1;
  }
}

class TabInfo {
  final int id;
  Widget tool;
  final GlobalKey<NavigatorState> navKey;

  TabInfo({
    required this.id,
    required this.tool,
    required this.navKey,
  });
}

class TabNavigator extends StatelessWidget {
  final TabInfo tabInfo;

  const TabNavigator({super.key, required this.tabInfo});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: tabInfo.navKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => tabInfo.tool,
        );
      },
    );
  }
}

class GCWTabMenu extends StatelessWidget {
  const GCWTabMenu({super.key});

  String _getDynamicName(GlobalKey<NavigatorState> navKey, String defaultName) {
    String? currentRouteName;
    navKey.currentState?.popUntil((route) {
      currentRouteName = route.settings.name;
      return true;
    });

    if (currentRouteName == null || currentRouteName == _HOMETAB_TITLE) {
      return defaultName;
    }
    return currentRouteName!;
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TabsModel>();
    if (model.tabs.length <= 1) {
      return Container();
    }

    return GCWPopupMenu(
      customIcon: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.crop_square_rounded,
            color: themeColors().mainFont(),
          ),
          Text(
              model.tabs.length.toString(),
              style: TextStyle(
                  fontSize: defaultFontSize() - 5,
                  color: themeColors().mainFont()
              )
          )
        ],
      ),
      buttonNoBorder: true,
      menuItemBuilder: (context) => List.generate(
        model.tabs.length,
            (i) {
          final tab = model.tabs[i];

          String displayName = _getDynamicName(
              tab.navKey, i == 0
              ? _HOMETAB_TITLE
              : (tab.tool as GCWTool).toolName!
          );

          if (displayName.length > _MAX_DISPLAYNAME_LENGTH) {
            displayName = displayName.substring(0, _MAX_DISPLAYNAME_LENGTH) + '...';
          }

          String name;
          try {
            name = Uri.decodeComponent(displayName);
          } catch (e) {
            name = displayName;
          }

          return GCWPopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: themeColors().dialogText(),
                      ),
                    ),
                    i == 0 && displayName != _HOMETAB_TITLE ? Text(
                      '(Home Tab)',
                      style: gcwDescriptionTextStyle().copyWith(color: themeColors().dialogText()),
                    ) : Container(),
                  ],
                ),
                i == 0 ? Container() :
                GCWIconButton(
                  icon: Icons.close,
                  iconColor: themeColors().dialogText(),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<TabsModel>().removeTab(tab.id);
                  },
                ),
              ],
            ), action: (int index) => context.read<TabsModel>().switchTab(index),
          );
        },
      ),
    );
  }
}