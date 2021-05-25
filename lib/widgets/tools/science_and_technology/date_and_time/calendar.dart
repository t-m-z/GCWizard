
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/calendar.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/maya_calendar.dart';
import 'package:gc_wizard/logic/common/date_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_date_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  CalendarSystem _currentCalendarSystem = CalendarSystem.JULIANDATE;
  double _currentJulianDate = 0.0;
  DateTime _currentDate;
  
  var _currentMayaMode = GCWSwitchPosition.left;
  int _currentMayaDayCount = 0;
  String _currentMayaLongCount = '';
  TextEditingController _MayaLongCountController;

  final MASKINPUTFORMATTER_MAYALONGCOUNT = MaskTextInputFormatter(mask: "##.##.##.##.##.##.##.##.##", filter: {"#": RegExp(r'[0-9?]')});

  @override
  void initState() {
    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);
    _currentJulianDate = GregorianCalendarToJulianDate(_currentDate);
    _currentMayaDayCount = JulianDate2MayaDayCount((_currentJulianDate + 0.5).floor());  //(jd + 0.5).floor();
    _currentMayaLongCount = MayaLongCount(MayaDayCountToMayaLongCount(JulianDate2MayaDayCount((_currentJulianDate + 0.5).floor())));
    _MayaLongCountController = TextEditingController(text: _currentMayaLongCount);
    super.initState();
  }

  @override
  void dispose() {
    _MayaLongCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentCalendarSystem,
          onChanged: (value) {
            setState(() {
              _currentCalendarSystem = value;
            });
          },
          items: CALENDAR_SYSTEM.entries.map((system) {
            return GCWDropDownMenuItem(
              value: system.key,
              child: i18n(context, system.value),
            );
          }).toList(),
        ),
        if (_currentCalendarSystem == CalendarSystem.JULIANDATE || _currentCalendarSystem == CalendarSystem.MODIFIEDJULIANDATE)
          GCWDoubleSpinner(
              value: _currentJulianDate,
              numberDecimalDigits: 2,
              onChanged: (value) {
                setState(() {
                  _currentJulianDate = value;
                });
              }),
        if (_currentCalendarSystem == CalendarSystem.JULIANCALENDAR || _currentCalendarSystem == CalendarSystem.GREGORIANCALENDAR ||
            _currentCalendarSystem == CalendarSystem.ISLAMICCALENDAR || _currentCalendarSystem == CalendarSystem.COPTICCALENDAR ||
            _currentCalendarSystem == CalendarSystem.PERSIANYAZDEGARDCALENDAR || _currentCalendarSystem == CalendarSystem.HEBREWCALENDAR)
          GCWDatePicker(
            date: _currentDate,
            type: _currentCalendarSystem,
            onChanged: (value) {
              setState(() {
                _currentDate = value;
              });
            },
          ),
        if (_currentCalendarSystem == CalendarSystem.MAYACALENDAR)
          Column(
            children: <Widget>[
              GCWTwoOptionsSwitch(
                leftValue: i18n(context, 'mayacalendar_system_longcount'),
                rightValue: i18n(context, 'mayacalendar_daycount'),
                value: _currentMayaMode,
                onChanged: (value) {
                  setState(() {
                    _currentMayaMode = value;
                  });
                }
              ),
              _currentMayaMode == GCWSwitchPosition.left
              ? GCWTextField(
                  controller: _MayaLongCountController,
                  inputFormatters: [MASKINPUTFORMATTER_MAYALONGCOUNT],
                  onChanged: (text) {
                    setState(() {
                      _currentMayaLongCount = text;
                    });
                  },
              )
              : GCWIntegerSpinner(
                  value: _currentMayaDayCount,
                  onChanged: (value) {
                    setState(() {
                      _currentMayaDayCount = value;
                    });
                  }                
              )    
            ],
          ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    double jd = 0.0;
    Map output = new Map();
    switch (_currentCalendarSystem) {
      case CalendarSystem.MODIFIEDJULIANDATE :
        jd = ModifedJulianDateToJulianDate(_currentJulianDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.JULIANDATE :
        jd = _currentJulianDate;
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.GREGORIANCALENDAR :
        jd = GregorianCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.JULIANCALENDAR :
        jd = JulianCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.ISLAMICCALENDAR :
        jd = IslamicCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = WEEKDAY_ISLAMIC[Weekday(jd)];
        break;
      case CalendarSystem.PERSIANYAZDEGARDCALENDAR :
        jd = PersianYazdegardCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = WEEKDAY_PERSIAN[Weekday(jd)];
        break;
      case CalendarSystem.HEBREWCALENDAR :
        jd = HebrewCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = WEEKDAY_HEBREW[Weekday(jd)];
        break;
      case CalendarSystem.COPTICCALENDAR :
        jd = CopticCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.MAYACALENDAR:
        if (_currentMayaMode == GCWSwitchPosition.left) {
          List<int> _lc = <int>[];
          if (_currentMayaLongCount == null || _currentMayaLongCount == '')
            _currentMayaLongCount = '0';
          for (var value in _currentMayaLongCount.split('.')) {
            _lc.add(int.parse(value));
          }
          jd = MayaDayCountToJulianDate(MayaLongCountToMayaDayCount(_lc)).toDouble();
        }else
          jd = MayaDayCountToJulianDate(_currentMayaDayCount).toDouble();
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
    }
    output['dates_calendar_system_juliandate'] = (jd + 0.5).floor();
    output['dates_calendar_system_juliancalendar'] = _DateOutputToString(context, JulianDateToJulianCalendar(jd, true), CalendarSystem.JULIANCALENDAR);
    output['dates_calendar_system_modifiedjuliandate'] = JulianDateToModifedJulianDate(jd);
    output['dates_calendar_system_gregoriancalendar'] = _DateOutputToString(context, JulianDateToGregorianCalendar(jd, true), CalendarSystem.GREGORIANCALENDAR);
    output['dates_calendar_system_islamiccalendar'] = _DateOutputToString(context, JulianDateToIslamicCalendar(jd), CalendarSystem.ISLAMICCALENDAR);
    output['dates_calendar_system_hebrewcalendar'] = _HebrewDateToString(JulianDateToHebrewCalendar(jd), jd);
    output['dates_calendar_system_persiancalendar'] = _DateOutputToString(context, JulianDateToPersianYazdegardCalendar(jd), CalendarSystem.PERSIANYAZDEGARDCALENDAR);
    output['dates_calendar_system_copticcalendar'] = _DateOutputToString(context, JulianDateToCopticCalendar(jd), CalendarSystem.COPTICCALENDAR);
    output['mayacalendar_title'] = MayaLongCount(MayaDayCountToMayaLongCount(JulianDate2MayaDayCount(jd.toInt()))) + '\n' +
                                   MayaLongCountToTzolkin(MayaDayCountToMayaLongCount(JulianDate2MayaDayCount(jd.toInt()))) + '     ' + MayaLongCountToHaab(MayaDayCountToMayaLongCount(JulianDate2MayaDayCount(jd.toInt())))  + '\n' +
                                   JulianDate2MayaDayCount(jd.toInt()).toString();
    return GCWDefaultOutput(
        child: Column(
          children: columnedMultiLineOutput(
              context,
              output.entries.map((entry) {
                return [i18n(context, entry.key), entry.value];
              }).toList(),
              flexValues: [1, 1]),
        ));
  }

  String _HebrewDateToString(DateOutput HebrewDate, double jd){
    if (typeOfJewYear(JewishYearLength(jd)).contains('embolistic'))
      return HebrewDate.day + '. ' + MONTH_NAMES[CalendarSystem.HEBREWCALENDAR][int.parse(HebrewDate.month)].toString() + ' ' + HebrewDate.year;
    else {
      int month = int.parse(HebrewDate.month);
      if (month > 6)
        month = 1 + int.parse(HebrewDate.month);
      return HebrewDate.day + ' ' + MONTH_NAMES[CalendarSystem.HEBREWCALENDAR][month] + ' ' + HebrewDate.year;
    }
  }

  String _DateOutputToString(context, DateOutput date, CalendarSystem calendar){
    final Locale appLocale = Localizations.localeOf(context);
    switch (calendar) {
      case CalendarSystem.ISLAMICCALENDAR:
      case CalendarSystem.PERSIANYAZDEGARDCALENDAR:
      case CalendarSystem.COPTICCALENDAR:
          return date.day + '. ' + MONTH_NAMES[calendar][int.parse(date.month)].toString() + ' ' + date.year;
      case CalendarSystem.GREGORIANCALENDAR :
      case CalendarSystem.JULIANCALENDAR :
          switch (appLocale.languageCode) {
            case 'de' :
                return date.day + '. ' + i18n(context, MONTH[int.parse(date.month)]) + ' ' + date.year;
            case 'fr' :
              return date.day + ' ' + i18n(context, MONTH[int.parse(date.month)]).toLowerCase() + ' ' + date.year;
            default :
              return date.year + ' ' + i18n(context, MONTH[int.parse(date.month)]) + ' ' + date.day;
          }
    };
  }

}


