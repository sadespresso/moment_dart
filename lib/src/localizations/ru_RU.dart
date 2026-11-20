// ignore_for_file: file_names

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/duration.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/relative.dart';
import 'package:moment_dart/src/localizations/mixins/ru_RU/units.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/mixins/weekday_shortforms.dart';

/// Language: Russian (Russia)
/// Country: Russia
class LocalizationRuRu extends MomentLocalization
    with
        MonthNames,
        Ordinal,
        SimpleUnits,
        RuRuUnits,
        RuRuRelative,
        RuRuDuration,
        SimpleRange,
        WeekdayShortForms {
  static LocalizationRuRu? _instance;

  LocalizationRuRu._internal() : super();

  factory LocalizationRuRu() {
    _instance ??= LocalizationRuRu._internal();
    return _instance!;
  }

  @override
  String get endonym => "Русский";

  @override
  String get languageCode => "ru";

  @override
  String get countryCode => "RU";

  @override
  String get languageNameInEnglish => "Russian (Russia)";

  @override
  Map<int, String> get monthNames => {
        1: "Январь",
        2: "Февраль",
        3: "Март",
        4: "Апрель",
        5: "Май",
        6: "Июнь",
        7: "Июль",
        8: "Август",
        9: "Сентябрь",
        10: "Октябрь",
        11: "Ноябрь",
        12: "Декабрь",
      };

  static const Map<int, String> _monthNamesGenitive = {
    1: "января",
    2: "февраля",
    3: "марта",
    4: "апреля",
    5: "мая",
    6: "июня",
    7: "июля",
    8: "августа",
    9: "сентября",
    10: "октября",
    11: "ноября",
    12: "декабря",
  };

  @override
  Map<int, String> get monthNamesShort => {
        1: "Янв.",
        2: "Февр.",
        3: "Март",
        4: "Апр.",
        5: "Май",
        6: "Июнь",
        7: "Июль",
        8: "Авг.",
        9: "Сент.",
        10: "Окт.",
        11: "Нояб.",
        12: "Дек.",
      };

  static const Map<int, String> _monthNamesShortGenitive = {
    1: "янв.",
    2: "февр.",
    3: "мар.",
    4: "апр.",
    5: "мая",
    6: "июн.",
    7: "июл.",
    8: "авг.",
    9: "сент.",
    10: "окт.",
    11: "нояб.",
    12: "дек.",
  };

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Понедельник",
        DateTime.tuesday: "Вторник",
        DateTime.wednesday: "Среда",
        DateTime.thursday: "Четверг",
        DateTime.friday: "Пятница",
        DateTime.saturday: "Суббота",
        DateTime.sunday: "Воскресенье",
      };

  @override
  Map<int, String> get weekdayNameShort => {
        DateTime.monday: "Пн",
        DateTime.tuesday: "Вт",
        DateTime.wednesday: "Ср",
        DateTime.thursday: "Чт",
        DateTime.friday: "Пт",
        DateTime.saturday: "Сб",
        DateTime.sunday: "Вс",
      };

  @override
  Map<int, String> get weekdayNameMin => weekdayNameShort;

  @override
  FormatSetOptional overrideFormatters() {
    return {
      // From [EnglishLikeOrdinal] mixin
      ...formattersWithOrdinal,
      // From [MonthNames] mixin
      ...formattersForMonthNames,
      // From [WeekdayShortForms] mixin
      ...formattersForWeekdayShortForms,
      // The name maps are capitalized for standalone labels (calendar, range);
      // inside a date Russian writes month and weekday names in lowercase.
      FormatterToken.MMMM: (dateTime) =>
          monthNames[dateTime.month]!.toLowerCase(),
      FormatterToken.MMM: (dateTime) =>
          monthNamesShort[dateTime.month]!.toLowerCase(),
      FormatterToken.dddd: (dateTime) =>
          weekdayName[dateTime.weekday]!.toLowerCase(),
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD.MM.YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D.M.YYYY"),
      FormatterToken.LL: (dateTime) => _dayMonthYear(dateTime),
      FormatterToken.ll: (dateTime) => _dayMonthYear(dateTime, short: true),
      FormatterToken.LLL: (dateTime) =>
          "${_dayMonthYear(dateTime)} ${reformat(dateTime, "HH:mm")}",
      FormatterToken.lll: (dateTime) =>
          "${_dayMonthYear(dateTime, short: true)} ${reformat(dateTime, "H:mm")}",
      FormatterToken.LLLL: (dateTime) =>
          "${reformat(dateTime, "dddd")}, ${_dayMonthYear(dateTime)} ${reformat(dateTime, "HH:mm")}",
      FormatterToken.llll: (dateTime) =>
          "${weekdayNameShort[dateTime.weekday]}, ${_dayMonthYear(dateTime, short: true)} ${reformat(dateTime, "H:mm")}",
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  String _dayMonthYear(DateTime dateTime, {bool short = false}) {
    final String month = short
        ? _monthNamesShortGenitive[dateTime.month]!
        : _monthNamesGenitive[dateTime.month]!;

    return "${dateTime.day} $month ${dateTime.year}";
  }

  @override
  String ordinalNumber(int n) {
    return "$n-й";
  }

  @override
  CalendarLocalizationData get calendarData => calendarLocalizationDataRuRu;

  static String last(String weekday) {
    switch (weekday) {
      case "Понедельник":
      case "Вторник":
      case "Четверг":
        return "Прошлый ${weekday.toLowerCase()}";
      case "Среда":
      case "Пятница":
      case "Суббота":
        return "Прошлая ${weekday.toLowerCase()}";
      case "Воскресенье":
        return "Прошлое ${weekday.toLowerCase()}";
      default:
        return "Прошлый ${weekday.toLowerCase()}";
    }
  }

  // The base calendar hands `at` only the label it built ("Прошлая пятница",
  // "Пятница"); with a time attached Russian needs the accusative phrase.
  static const Map<String, String> _weekdayPhrases = {
    "Прошлый понедельник": "В прошлый понедельник",
    "Прошлый вторник": "В прошлый вторник",
    "Прошлая среда": "В прошлую среду",
    "Прошлый четверг": "В прошлый четверг",
    "Прошлая пятница": "В прошлую пятницу",
    "Прошлая суббота": "В прошлую субботу",
    "Прошлое воскресенье": "В прошлое воскресенье",
    "Понедельник": "В понедельник",
    "Вторник": "Во вторник",
    "Среда": "В среду",
    "Четверг": "В четверг",
    "Пятница": "В пятницу",
    "Суббота": "В субботу",
    "Воскресенье": "В воскресенье",
  };

  static String at(String date, String time) =>
      "${_weekdayPhrases[date] ?? date} в $time";

  static const CalendarLocalizationData calendarLocalizationDataRuRu =
      CalendarLocalizationData(
    relativeDayNames: {
      -2: "Позавчера",
      -1: "Вчера",
      0: "Сегодня",
      1: "Завтра",
      2: "Послезавтра",
    },
    keywords: CalendarLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  int get weekStart => DateTime.monday;

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Эта неделя",
        year: (range, {anchor, useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "Этот год";
          }

          return "${range.year} год";
        },
        month: (range, {anchor, useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "Этот месяц";
            }

            return monthNames[range.month]!;
          }

          return "${monthNames[range.month]!} ${range.year}";
        },
        allAfter: (formattedDate) => "После $formattedDate",
        allBefore: (formattedDate) => "До $formattedDate",
        customRangeAllTime: "За все время",
      );
}
