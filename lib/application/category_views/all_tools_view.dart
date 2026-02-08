import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/_common/gcw_package_info.dart';
import 'package:gc_wizard/application/category_views/favorites.dart';
import 'package:gc_wizard/application/category_views/hyperlinks.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/main_menu/changelog.dart';
import 'package:gc_wizard/application/main_menu/main_menu.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/searchstrings/logic/search_strings.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/application/webapi/deeplinks/deeplinks.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/string_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/text_widget_utils.dart';
import 'package:prefs/prefs.dart';

class MainView extends GCWWebStatefulWidget {
  MainView({Key? key, Map<String, String>? webParameter})
      : super(key: key, webParameter: webParameter, apiSpecification: null);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _searchController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _searchText = '';
  final _SHOW_SUPPORT_HINT_EVERY_N = 50;

  @override
  void initState() {
    super.initState();
    Prefs.init();

    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isEmpty) {
          _searchText = '';
        } else if (_searchText != _searchController.text) {
          _searchText = _searchController.text;
        }
      });
    });

    _showWhatsNewDialog() {
      const _MAX_ENTRIES = 10;

      var mostRecentChangelogVersion = CHANGELOG.keys.first;
      var entries = i18n(context, 'changelog_' + mostRecentChangelogVersion)
          .split('\n')
          .map((entry) => entry.split('(')[0])
          .toList();
      if (entries.length > _MAX_ENTRIES) {
        entries = entries.sublist(0, _MAX_ENTRIES);
        entries.add('...');
      }

      showGCWDialog(
          context,
          i18n(context, 'common_newversion_title',
              parameters: [mostRecentChangelogVersion]),
          Text(entries.join('\n')),
          [
            GCWDialogButton(
                text: i18n(context, 'common_newversion_showchangelog'),
                onPressed: () {
                  Navigator.push(
                      context,
                      NoAnimationMaterialPageRoute<GCWTool>(
                          builder: (context) => registeredTools.firstWhere(
                              (tool) =>
                                  className(tool.tool) ==
                                  className(const Changelog()))));
                }),
            GCWDialogButton(text: i18n(context, 'common_ok'))
          ],
          cancelButton: false);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var countAppOpened = Prefs.getInt(PREFERENCE_APP_COUNT_OPENED);

      if (countAppOpened > 1 &&
          Prefs.getString(PREFERENCE_CHANGELOG_DISPLAYED) !=
              CHANGELOG.keys.first) {
        _showWhatsNewDialog();
        Prefs.setString(PREFERENCE_CHANGELOG_DISPLAYED, CHANGELOG.keys.first);
        return;
      }

      if (countAppOpened > 0 &&
          (countAppOpened == 10 ||
              countAppOpened % _SHOW_SUPPORT_HINT_EVERY_N == 0)) {
        _checkForGoldVersion().then((value) {
          if (!value && !kIsWeb) {
            showGCWAlertDialog(
              context,
              i18n(context, 'common_support_title'),
              i18n(context, 'common_support_text',
                  parameters: [Prefs.getInt(PREFERENCE_APP_COUNT_OPENED)]),
              () => launchUrl(Uri.parse(i18n(context, 'common_support_link'))),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    Prefs.dispose();
    _searchController.dispose();

    super.dispose();
  }

  Future<bool> _checkForGoldVersion() async {
    await GCWPackageInfo.init();
    return GCWPackageInfo.getInstance().appName.toLowerCase().contains('gold');
  }

  @override
  Widget build(BuildContext context) {
    if (registeredTools.isEmpty) {
      initializeRegistry(context);

      var deepLink = _checkDeepLink();
      if (deepLink != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context, deepLink);
        });
        widget.webParameter = null;
      }
    }

    Favorites.initialize();

    var toolList = (_searchText.isNotEmpty) ? _getSearchedList() : null;

    return DefaultTabController(
      length: 3,
      initialIndex: Prefs.getBool(PREFERENCE_TABS_USE_DEFAULT_TAB)
          ? Prefs.getInt(PREFERENCE_TABS_DEFAULT_TAB)
          : Prefs.getInt(PREFERENCE_TABS_LAST_VIEWED_TAB),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: 120,
          bottom: TabBar(
            onTap: (value) {
              Prefs.setInt(PREFERENCE_TABS_LAST_VIEWED_TAB, value);
            },
            tabs: const [
              Tab(icon: Icon(Icons.category)),
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.star)),
            ],
          ),
          leading: _buildIcon(),
          title: _buildTitleAndSearchTextField(),
        ),
        drawer: buildMainMenu(context),
        body: TabBarView(
          children: [
            GCWToolList(toolList: toolList ?? _categoryList),
            MainURLList(context),
            GCWToolList(toolList: toolList ?? Favorites.favoritedGCWTools()),
          ],
        ),
      ),
    );
  }

  NoAnimationMaterialPageRoute<GCWTool>? _checkDeepLink() {
    if (widget.hasWebParameter()) {
      return createStartDeepLinkRoute(context, widget.webParameter!);
    }
    return null;
  }

  Widget _buildTitleAndSearchTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(i18n(context, 'common_app_title')),
        GCWTextField(
            autofocus: true,
            controller: _searchController,
            icon: Icon(Icons.search, color: themeColors().mainFont()),
            hintText: i18n(context, 'common_search') + '...')
      ],
    );
  }

  Widget _buildIcon() {
    return IconButton(
        alignment: Alignment(1.0, 0.0),
        icon: Image.asset(
          applogoFilename(),
        ),
        onPressed: () => _scaffoldKey.currentState?.openDrawer());
  }

  List<GCWTool> _getSearchedList() {
    var _sanitizedSearchText = removeAccents(_searchText.toLowerCase())
        .replaceAll(NOT_ALLOWED_SEARCH_CHARACTERS, '');

    if (_sanitizedSearchText.isEmpty) return <GCWTool>[];

    Set<String> _queryTexts =
        _sanitizedSearchText.split(REGEXP_SPLIT_STRINGLIST).toSet();

    return registeredTools.where((tool) {
      if (tool.indexedSearchStrings.isEmpty) return false;

      //Search result as AND result of separated words
      for (final q in _queryTexts) {
        if (!tool.indexedSearchStrings.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Container _buildUrl(String key, String value) {
    return Container(
        padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN, top: 5, bottom: 5),
        margin: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN, top: 5, bottom: 5),
        child: Row(children: <Widget>[
          Expanded(
              flex: 2, child: GCWText(text: i18n(context, 'linklist_$key'), style: TextStyle(fontWeight: FontWeight.normal))),
          Expanded(
              flex: 3,
              child: buildUrl(value, value))
        ]));
  }
}

List<GCWTool> _categoryList = [];

void refreshToolLists() {
  _categoryList = [];
}


