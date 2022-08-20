// ignore_for_file: file_names

import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/moment_localization.dart';

/// Language: German
/// Country: Germany
class LocalizationDeDe extends MomentLocalization
    with Ordinal, MonthNames, SimpleUnits, SimpleRelative, SimpleDuration {
  LocalizationDeDe() : super();

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
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() {
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
  Map<int, String> get monthNamesShort =>
      monthNames.map((key, value) => MapEntry(key, value.substring(0, 3)));

  @override
  Map<int, String> get weekdayName => {
        1: "Montag",
        2: "Dienstag",
        3: "Mittwoch",
        4: "Donnerstag",
        5: "Freitag",
        6: "Samstag",
        7: "Sonntag",
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
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.fewSeconds: UnitString.withForm(
          "wenigen Sekunden",
          "wenigen Sekunden",
          "wenigen Sekunden",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "eine Sekunde",
          "eine Sekunde",
          "eine Sekunde",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta Sekunden",
          "$srDelta Sekunden",
          "$srDelta Sekunden",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "einer Minute",
          "einer Minute",
          "einer Minute",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta Minuten",
          "$srDelta Minuten",
          "$srDelta Minuten",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "einer Stunde",
          "einer Stunde",
          "einer Stunde",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta Stunden",
          "$srDelta Stunden",
          "$srDelta Stunden",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "einem Tag",
          "einem Tag",
          "einem Tag",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta Tagen",
          "$srDelta Tagen",
          "$srDelta Tagen",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "eine Woche",
          "eine Woche",
          "eine Woche",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta Wochen",
          "$srDelta Wochen",
          "$srDelta Wochen",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "einem Monat",
          "einem Monat",
          "einem Monat",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta Monaten",
          "$srDelta Monaten",
          "$srDelta Monaten",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "einem Jahr",
          "einem Jahr",
          "einem Jahr",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta Jahren",
          "$srDelta Jahren",
          "$srDelta Jahren",
        ),
      };
}
