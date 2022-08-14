// ignore_for_file: file_names

import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/mixins/english_like_ordinal.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Language: English (US)
/// Country: United States
class LocalizationEnUs extends MomentLocalization
    with
        MonthNames,
        EnglishLikeOrdinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration {
  LocalizationEnUs() : super();

  @override
  String get endonym => "English";

  @override
  String get languageCode => "en";

  @override
  String get countryCode => "US";

  @override
  String get languageNameInEnglish => "English (United States)";

  @override
  String relativePast(String unit) => "$unit ago";
  @override
  String relativeFuture(String unit) => "in $unit";

  @override
  Map<int, String> get monthNames => {
        1: "January",
        2: "February",
        3: "March",
        4: "April",
        5: "May",
        6: "June",
        7: "July",
        8: "August",
        9: "September",
        10: "October",
        11: "November",
        12: "December",
      };

  @override
  Map<int, String> get monthNamesShort =>
      monthNames.map((key, value) => MapEntry(key, value.substring(0, 3)));

  @override
  Map<int, String> get weekdayName => {
        1: "Monday",
        2: "Tuesday",
        3: "Wednesday",
        4: "Thursday",
        5: "Friday",
        6: "Saturday",
        7: "Sunday",
      };

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() {
    return {
      // From [EnglishLikeOrdinal] mixin
      ...formattersWithOrdinal,
      // From [MonthNames] mixin
      ...formattersForMonthNames,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "MM/DD/YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "M/D/YYYY"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "MMMM D YYYY"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "MMM D YYYY"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "MMMM D YYYY hh:mm A"),
      FormatterToken.lll: (dateTime) => reformat(dateTime, "MMM D YYYY h:mm A"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, MMMM D YYYY hh:mm A"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, MMM D YYYY h:mm A"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "h:mm A"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "h:mm:ss A"),
    };
  }

  @override
  List<String> get ordinalSuffixes => ["th", "st", "nd", "rd"];

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataEnUs;

  static String last(String weekday) => "Last $weekday";
  static String at(String date, String time) => "$date at $time";

  static const CalenderLocalizationData calenderLocalizationDataEnUs =
      CalenderLocalizationData(
    relativeDayNames: {
      -1: "Yesterday",
      0: "Today",
      1: "Tomorrow",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  int get weekStart => DateTime.sunday;

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.fewSeconds: UnitString(
          "a few seconds",
          "a few sec",
          "a few sec",
        ),
        DurationInterval.aSecond: UnitString(
          "a second",
          "1 sec",
          "1s",
        ),
        DurationInterval.seconds: UnitString(
          "$srDelta seconds",
          "$srDelta sec",
          "${srDelta}s",
        ),
        DurationInterval.aMinute: UnitString(
          "a minute",
          "1 min",
          "1m",
        ),
        DurationInterval.minutes: UnitString(
          "$srDelta minutes",
          "$srDelta min",
          "${srDelta}m",
        ),
        DurationInterval.anHour: UnitString(
          "an hour",
          "1 hour",
          "1h",
        ),
        DurationInterval.hours: UnitString(
          "$srDelta hours",
          "$srDelta hours",
          "${srDelta}h",
        ),
        DurationInterval.aDay: UnitString(
          "a day",
          "1 day",
          "1d",
        ),
        DurationInterval.days: UnitString(
          "$srDelta days",
          "$srDelta day",
          "${srDelta}d",
        ),
        DurationInterval.aWeek: UnitString(
          "a week",
          "1 week",
          "1w",
        ),
        DurationInterval.weeks: UnitString(
          "$srDelta weeks",
          "$srDelta week",
          "${srDelta}w",
        ),
        DurationInterval.aMonth: UnitString(
          "a month",
          "1 mo",
          "1mo",
        ),
        DurationInterval.months: UnitString(
          "$srDelta months",
          "$srDelta mo",
          "${srDelta}mo",
        ),
        DurationInterval.aYear: UnitString(
          "a year",
          "1 year",
          "1y",
        ),
        DurationInterval.years: UnitString(
          "$srDelta years",
          "$srDelta years",
          "${srDelta}y",
        ),
      };
}
