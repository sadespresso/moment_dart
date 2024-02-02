// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/src/localizations/mixins/de_DE/units.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/types.dart';

/// Language: German
/// Country: Germany
class LocalizationDeDe extends MomentLocalization
    with Ordinal, MonthNames, SimpleUnits, SimpleRelative, SimpleDuration {
  static LocalizationDeDe? _instance;

  LocalizationDeDe._internal() : super();

  factory LocalizationDeDe() {
    _instance ??= LocalizationDeDe._internal();

    return _instance!;
  }

  @override
  String get endonym => "Deutsch";

  @override
  String get languageCode => "de";

  @override
  String get countryCode => "DE";

  @override
  String get languageNameInEnglish => "German (Standard)";

  @override
  String relativePast(String unit) => "vor $unit";
  @override
  String relativeFuture(String unit) => "in $unit";

  @override
  String ordinalNumber(int n) => "$n.";

  @override
  FormatSetOptional overrideFormatters() {
    return {
      // From [Ordinal] mixin
      ...formattersWithOrdinal,
      // From [MonthNames] mixin
      ...formattersForMonthNames,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD.MM.YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D.M.YYYY"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "D. MMMM YYYY"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "D. MMM YYYY"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "D. MMMM YYYY HH:mm"),
      FormatterToken.lll: (dateTime) => reformat(dateTime, "D. MMM YYYY H:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, D. MMMM YYYY HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, D. MMM YYYY H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "H:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "H:mm:ss"),
      // Missing formatters
      FormatterToken.A: (dateTime) => dateTime.hour < 12 ? "AM" : "PM",
      FormatterToken.a: (dateTime) => dateTime.hour < 12 ? "am" : "pm",
      // Overrides
      FormatterToken.dd: (dateTime) =>
          weekdayName[dateTime.weekday]!.substring(0, 2),
      FormatterToken.ddd: (dateTime) =>
          "${weekdayName[dateTime.weekday]!.substring(0, 2)}.",
    };
  }

  @override
  Map<int, String> get monthNames => {
        1: "Januar",
        2: "Februar",
        3: "März",
        4: "April",
        5: "Mai",
        6: "Juni",
        7: "Juli",
        8: "August",
        9: "September",
        10: "Oktober",
        11: "November",
        12: "Dezember",
      };

  @override
  Map<int, String> get monthNamesShort => {
        1: "Jan.",
        2: "Feb.",
        3: "März",
        4: "Apr.",
        5: "Mai",
        6: "Juni",
        7: "Juli",
        8: "Aug.",
        9: "Sep.",
        10: "Okt.",
        11: "Nov.",
        12: "Dez.",
      };

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Montag",
        DateTime.tuesday: "Dienstag",
        DateTime.wednesday: "Mittwoch",
        DateTime.thursday: "Donnerstag",
        DateTime.friday: "Freitag",
        DateTime.saturday: "Samstag",
        DateTime.sunday: "Sonntag",
      };

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataDeDe;

  static String last(String weekday) => "letzten $weekday";
  static String at(String date, String time) => "$date um $time";

  static const CalenderLocalizationData calenderLocalizationDataDeDe =
      CalenderLocalizationData(
    relativeDayNames: {
      -2: "vorgestern",
      -1: "gestern",
      0: "heute",
      1: "morgen",
      2: "übermorgen",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  Map<DurationInterval, UnitStringDeDe> get units => {
        DurationInterval.lessThanASecond: UnitStringDeDe(
          "ein paar Sekunden",
          "ein paar Sek.",
          "ein paar Sek.",
        ),
        DurationInterval.aSecond: UnitStringDeDe(
          "einer Sekunde",
          "1 Sek.",
          "1s",
          standalone: "eine Sekunde",
        ),
        DurationInterval.seconds: UnitStringDeDe(
          "$srDelta Sekunden",
          "$srDelta Sek.",
          "${srDelta}s",
        ),
        DurationInterval.aMinute: UnitStringDeDe(
          "einer Minute",
          "1 Min.",
          "1m",
          standalone: "eine Minute",
        ),
        DurationInterval.minutes: UnitStringDeDe(
          "$srDelta Minuten",
          "$srDelta Min.",
          "${srDelta}m",
        ),
        DurationInterval.anHour: UnitStringDeDe(
          "einer Stunde",
          "1 Std.",
          "1h",
          standalone: "eine Stunde",
        ),
        DurationInterval.hours: UnitStringDeDe(
          "$srDelta Stunden",
          "$srDelta Std.",
          "${srDelta}h",
        ),
        DurationInterval.aDay: UnitStringDeDe(
          "einem Tag",
          "einem Tg.",
          "1d",
          standalone: "ein Tag",
        ),
        DurationInterval.days: UnitStringDeDe(
          "$srDelta Tagen",
          "$srDelta Tg.",
          "${srDelta}d",
          standalone: "$srDelta Tage",
        ),
        DurationInterval.aWeek: UnitStringDeDe(
          "einer Woche",
          "1 Woche",
          "1w",
          standalone: "eine Woche",
        ),
        DurationInterval.weeks: UnitStringDeDe(
          "$srDelta Wochen",
          "$srDelta Wochen",
          "${srDelta}w",
        ),
        DurationInterval.aMonth: UnitStringDeDe(
          "einem Monat",
          "1 Mo.",
          "1mo",
          standalone: "ein Monat",
        ),
        DurationInterval.months: UnitStringDeDe(
          "$srDelta Monaten",
          "$srDelta Mo.",
          "${srDelta}mo",
          standalone: "$srDelta Monate",
        ),
        DurationInterval.aYear: UnitStringDeDe(
          "einem Jahr",
          "1 Jr.",
          "1y",
          standalone: "ein Jahr",
        ),
        DurationInterval.years: UnitStringDeDe(
          "$srDelta Jahren",
          "$srDelta Jr.",
          "${srDelta}y",
          standalone: "$srDelta Jahre",
        ),
      };
}
