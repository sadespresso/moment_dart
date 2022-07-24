// ignore_for_file: file_names

import 'package:moment_dart/src/calendar.dart';
import 'package:moment_dart/src/formatters/token.dart';

import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/mixins/english_like_ordinal.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';

/// Language: English (US)
/// Country: United States
class LocalizationEnUs extends MomentLocalization
    with MonthNames, EnglishLikeOrdinal, SimpleRelative {
  LocalizationEnUs() : super();

  @override
  String get endonym => "English";

  @override
  String get languageCodeISO => "en";

  @override
  String get locale => "en_US";

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
  Map<RelativeInterval, String> get relativeUnits => {
        RelativeInterval.fewSeconds: "a few seconds",
        RelativeInterval.aSecond: "a second",
        RelativeInterval.seconds: "$srDelta seconds",
        RelativeInterval.aMinute: "a minute",
        RelativeInterval.minutes: "$srDelta minutes",
        RelativeInterval.anHour: "an hour",
        RelativeInterval.hours: "$srDelta hours",
        RelativeInterval.aDay: "a day",
        RelativeInterval.days: "$srDelta days",
        RelativeInterval.aMonth: "a month",
        RelativeInterval.months: "$srDelta months",
        RelativeInterval.aYear: "a year",
        RelativeInterval.years: "$srDelta years",
      };
}
