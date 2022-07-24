// ignore_for_file: file_names

import 'package:moment_dart/src/calendar.dart';
import 'package:moment_dart/src/formatters/token.dart';

import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/mixins/complex_calendar.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';

/// Language: Italian
/// Country: Italy
class LocalizationIt extends MomentLocalization
    with MonthNames, Ordinal, SimpleRelative, ComplexCalendar {
  LocalizationIt() : super();

  @override
  String get endonym => "Italy";

  @override
  String get languageCodeISO => "Italiano";

  @override
  String get locale => "it";

  @override
  String get languageNameInEnglish => "Italian";

  @override
  String relativePast(String unit) => "$unit fa";
  @override
  String relativeFuture(String unit) => "tra $unit";

  @override
  Map<int, String> get monthNames => {
        1: "gennaio",
        2: "febbraio",
        3: "marzo",
        4: "aprile",
        5: "maggio",
        6: "giugno",
        7: "luglio",
        8: "agosto",
        9: "settembre",
        10: "ottobre",
        11: "novembre",
        12: "dicembre",
      };

  @override
  Map<int, String> get monthNamesShort =>
      monthNames.map((key, value) => MapEntry(key, value.substring(0, 3)));

  @override
  Map<int, String> get weekdayName => {
        1: "lunedì",
        2: "martedì",
        3: "mercoledì",
        4: "giovedì",
        5: "venerdì",
        6: "sabato",
        7: "domenica",
      };

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() {
    return {
      // From [EnglishLikeOrdinal] mixin
      ...formattersWithOrdinal,
      // From [MonthNames] mixin
      ...formattersForMonthNames,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD/MM/YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D/M/YYYY"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "D MMMM YYYY"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "D MMM YYYY"),
      FormatterToken.LLL: (dateTime) => reformat(dateTime, "D MMMM YYYY HH:mm"),
      FormatterToken.lll: (dateTime) => reformat(dateTime, "D MMM YYYY HH:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd D MMMM YYYY HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd D MMM YYYY HH:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  static String last(String weekday) => "Last $weekday";
  static String at(String date, String time) => "$date a' $time";

  static const CalenderLocalizationData calenderLocalizationDataEnUs =
      CalenderLocalizationData(
    relativeDayNames: {
      -1: "Ieri",
      0: "Oggi",
      1: "Domani",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  int get weekStart => DateTime.monday;

  @override
  Map<RelativeInterval, String> get relativeUnits => {
        RelativeInterval.fewSeconds: "alcuni secondi",
        RelativeInterval.aSecond: "un secondo",
        RelativeInterval.seconds: "$srDelta secondi",
        RelativeInterval.aMinute: "un minuto",
        RelativeInterval.minutes: "$srDelta minuti",
        RelativeInterval.anHour: "un'ora",
        RelativeInterval.hours: "$srDelta ore",
        RelativeInterval.aDay: "un giorno",
        RelativeInterval.days: "$srDelta giorni",
        RelativeInterval.aMonth: "un mese",
        RelativeInterval.months: "$srDelta mesi",
        RelativeInterval.aYear: "un anno",
        RelativeInterval.years: "$srDelta anni",
      };

  @override
  String ordinalNumber(int n) => "$nº";

  @override
  ComplexCalenderLocalizationData get complexCalendarData =>
      ComplexCalenderLocalizationData(
        keywords: ComplexCalenderLocalizationKeywords(
          at: (DateTime dateTime, String dateString, String timeString) {
            late final String suffix;

            if (dateTime.hour > 1) {
              suffix = "lle ";
            } else {
              suffix = (dateTime.hour == 0) ? " " : "ll'";
            }

            return "$dateString a$suffix$timeString";
          },
          lastWeekday: (DateTime dateTime) {
            if (dateTime.weekday == DateTime.sunday) {
              return "La scorsa ${reformat(dateTime, "dddd")}";
            }

            return "Lo scorso ${reformat(dateTime, "dddd")}";
          },
          nextWeekday: (DateTime dateTime) => reformat(dateTime, "dddd"),
        ),
        relativeDayNames: {
          -1: "ieri",
          0: "oggi",
          1: "domani",
          // 2: "dopodomani",
        },
      );
}
