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
import 'package:moment_dart/src/types.dart';

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

  @override
  Map<int, String> get monthNamesShort => monthNames.map(
        (key, value) => MapEntry(
          key,
          value.substring(0, 3),
        ),
      );

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
        DateTime.monday: "Пон",
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
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD.MM.YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D.M.YYYY"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "D MMMM YYYY"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "D MMM YYYY"),
      FormatterToken.LLL: (dateTime) => reformat(dateTime, "D MMMM YYYY HH:mm"),
      FormatterToken.lll: (dateTime) => reformat(dateTime, "D MMM YYYY H:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, D MMMM YYYY HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, D MMM YYYY H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  @override
  String ordinalNumber(int n) {
    return "$n-й";
  }

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataRuRu;

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

  static String at(String date, String time) => "$date в $time";

  static const CalenderLocalizationData calenderLocalizationDataRuRu =
      CalenderLocalizationData(
    relativeDayNames: {
      -2: "Позавчера",
      -1: "Вчера",
      0: "Сегодня",
      1: "Завтра",
      2: "Послезавтра",
    },
    keywords: CalenderLocalizationKeywords(
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
            return "В этом году";
          }

          return "${range.year} год";
        },
        month: (range, {anchor, useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "В этом месяце";
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
