import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_language.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/main_menu/settings/settings_preferences.dart';
import 'package:gc_wizard/widgets/utils/AppBuilder.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralSettings extends StatefulWidget {
  @override
  GeneralSettingsState createState() => GeneralSettingsState();
}

class GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'settings_general_i18n_title')),
        Row(
          children: [
            Expanded(child: GCWText(text: i18n(context, 'settings_general_i18n_language'))),
            Expanded(
                child: FutureBuilder<Locale>(
                    future: appLanguage.fetchLocale(),
                    builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
                      if (!snapshot.hasData) {
                        // while data is loading:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // data loaded:
                        final currentLocale = snapshot.data;

                        return GCWStatefulDropDownButton(
                            items: SUPPORTED_LOCALES.entries.map((locale) {
                              String languageName = locale.value['name_native'];

                              var subtitle;
                              if (locale.value['percent_translated'] as int < 90) {
                                subtitle = i18n(context, 'settings_general_i18n_language_partlytranslated',
                                    parameters: [locale.value['percent_translated']]);
                              }

                              return GCWDropDownMenuItem(
                                  value: locale.key.languageCode, child: languageName, subtitle: subtitle);
                            }).toList(),
                            value: isLocaleSupported(currentLocale)
                                ? currentLocale.languageCode
                                : DEFAULT_LOCALE.languageCode,
                            onChanged: (newValue) {
                              appLanguage.changeLanguage(newValue);
                            });
                      }
                    })),
          ],
        ),
        Container(
          child: InkWell(
            child: Text(
              i18n(context, 'settings_general_i18n_language_contributetranslation'),
              style: gcwHyperlinkTextStyle(),
            ),
            onTap: () {
              launchUrl(Uri.parse(i18n(context, 'about_crowdin_url')));
            },
          ),
          padding: EdgeInsets.only(bottom: 10 * DEFAULT_MARGIN, top: 5 * DEFAULT_MARGIN),
        ),
        Row(children: [
          Expanded(child: GCWText(text: i18n(context, 'settings_general_i18n_defaultlengthunit'))),
          Expanded(
            child: GCWUnitDropDownButton(
                unitList: allLengths(),
                value: getUnitBySymbol(allLengths(), Prefs.get(PREFERENCE_DEFAULT_LENGTH_UNIT)),
                onChanged: (Length value) {
                  setState(() {
                    Prefs.setString(PREFERENCE_DEFAULT_LENGTH_UNIT, value.symbol);
                  });
                }),
          ),
        ]),
        GCWTextDivider(text: i18n(context, 'settings_general_theme')),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'settings_general_theme_color'),
          value: Prefs.getString(PREFERENCE_THEME_COLOR) == ThemeType.DARK.toString()
              ? GCWSwitchPosition.left
              : GCWSwitchPosition.right,
          leftValue: i18n(context, 'settings_general_theme_color_dark'),
          rightValue: i18n(context, 'settings_general_theme_color_light'),
          onChanged: (value) {
            setState(() {
              if (value == GCWSwitchPosition.left) {
                Prefs.setString(PREFERENCE_THEME_COLOR, ThemeType.DARK.toString());
                setThemeColors(ThemeType.DARK);
              } else {
                Prefs.setString(PREFERENCE_THEME_COLOR, ThemeType.LIGHT.toString());
                setThemeColors(ThemeType.LIGHT);
              }

              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_theme_font_size'),
          value: Prefs.getDouble(PREFERENCE_THEME_FONT_SIZE).floor(),
          min: 10,
          max: 30,
          onChanged: (value) {
            setState(() {
              Prefs.setDouble(PREFERENCE_THEME_FONT_SIZE, value.toDouble());

              // source: https://hillel.dev/2018/08/15/flutter-how-to-rebuild-the-entire-app-to-change-the-theme-or-locale/
              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'settings_general_toollist')),
        GCWOnOffSwitch(
          value: Prefs.getBool(PREFERENCE_TOOLLIST_SHOW_DESCRIPTIONS),
          title: i18n(context, 'settings_general_toollist_showdescriptions'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool(PREFERENCE_TOOLLIST_SHOW_DESCRIPTIONS, value);
              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWOnOffSwitch(
          value: Prefs.getBool(PREFERENCE_TOOLLIST_SHOW_EXAMPLES),
          title: i18n(context, 'settings_general_toollist_showexamples'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool(PREFERENCE_TOOLLIST_SHOW_EXAMPLES, value);
              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'settings_general_defaulttab')),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'settings_general_defaulttab_atstart'),
          value: Prefs.getBool(PREFERENCE_TABS_USE_DEFAULT_TAB) ? GCWSwitchPosition.right : GCWSwitchPosition.left,
          leftValue: i18n(context, 'settings_general_defaulttab_uselasttab'),
          rightValue: i18n(context, 'settings_general_defaulttab_usedefaulttab'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool(PREFERENCE_TABS_USE_DEFAULT_TAB, value == GCWSwitchPosition.right);
            });
          },
        ),
        Prefs.getBool(PREFERENCE_TABS_USE_DEFAULT_TAB)
            ? GCWDropDownButton(
                value: Prefs.get(PREFERENCE_TABS_DEFAULT_TAB),
                items: [
                  {
                    'index': 0,
                    'text': Row(children: [
                      Icon(Icons.category, color: themeColors().mainFont()),
                      Container(width: 10),
                      Text(i18n(context, 'common_tabs_categories'))
                    ])
                  },
                  {
                    'index': 1,
                    'text': Row(children: [
                      Icon(Icons.list, color: themeColors().mainFont()),
                      Container(width: 10),
                      Text(i18n(context, 'common_tabs_all'))
                    ])
                  },
                  {
                    'index': 2,
                    'text': Row(children: [
                      Icon(Icons.star, color: themeColors().mainFont()),
                      Container(width: 10),
                      Text(i18n(context, 'common_tabs_favorites'))
                    ])
                  }
                ].map((item) {
                  return GCWDropDownMenuItem(
                    value: item['index'],
                    child: item['text'],
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    Prefs.setInt(PREFERENCE_TABS_DEFAULT_TAB, value);
                  });
                },
              )
            : Container(),
        GCWTextDivider(text: i18n(context, 'settings_general_clipboard')),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_clipboard_maxitems'),
          value: Prefs.getInt(PREFERENCE_CLIPBOARD_MAX_ITEMS),
          min: 1,
          max: 100,
          onChanged: (value) {
            setState(() {
              Prefs.setInt(PREFERENCE_CLIPBOARD_MAX_ITEMS, value);
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_clipboard_keep.entries.in.days'),
          value: Prefs.getInt(PREFERENCE_CLIPBOARD_KEEP_ENTRIES_IN_DAYS),
          min: 1,
          max: 1000,
          onChanged: (value) {
            setState(() {
              Prefs.setInt(PREFERENCE_CLIPBOARD_KEEP_ENTRIES_IN_DAYS, value);
            });
          },
        ),


        // always on bottom
        Container(
          margin: EdgeInsets.only(top: 25.0),
          child: GCWDivider()
        ),
        InkWell(
          child: Icon(
            Icons.more_horiz,
            size: 20.0
          ),
          onTap: () {
            showGCWAlertDialog(
              context,
              i18n(context, 'settings_preferences_warning_title'),
              i18n(context, 'settings_preferences_warning_text'),
              () {
                Navigator.of(context).push(NoAnimationMaterialPageRoute(
                    builder: (context) => GCWTool(
                        tool: SettingsPreferences(),
                        i18nPrefix: 'settings_preferences'))).whenComplete(() {
                    setState(() {
                      AppBuilder.of(context).rebuild();
                    });

                    showGCWAlertDialog(
                      context,
                      i18n(context, 'settings_preferences_aftermath_title'),
                      i18n(context, 'settings_preferences_aftermath_text'),
                      () {},
                      cancelButton: false
                    );
                });
              },
            );
          },
        )
      ],
    );
  }
}
