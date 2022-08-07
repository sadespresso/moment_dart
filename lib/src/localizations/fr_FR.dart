// ignore_for_file: file_names

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/calendar.dart';

import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';

/// Language: French
/// Country: France
class LocalizationFrFr extends MomentLocalization
    with MonthNames, Ordinal, SimpleRelative {
  LocalizationFrFr() : super();

  @override
  String get endonym => "Français";

  @override
  String get languageCode => "fr";

  @override
  String get countryCode => "FR";

  @override
  String get languageNameInEnglish => "French (France)";

  @override
  String relativePast(String unit) => "il y a $unit";
  @override
  String relativeFuture(String unit) => "dans $unit";

  @override
  Map<int, String> get monthNames => {
        1: "janvier",
        2: "février",
        3: "mars",
        4: "avril",
        5: "mai",
        6: "juin",
        7: "juillet",
        8: "août",
        9: "septembre",
        10: "octobre",
        11: "novembre",
        12: "décembre",
      };

  @override
  Map<int, String> get monthNamesShort => {
        1: "janv.",
        2: "févr.",
        3: "mars",
        4: "avril",
        5: "mai",
        6: "juin",
        7: "juil.",
        8: "août",
        9: "sept.",
        10: "oct.",
        11: "nov.",
        12: "déc.",
      };

  @override
  Map<int, String> get weekdayName => {
        1: "lundi",
        2: "mardi",
        3: "mercredi",
        4: "jeudi",
        5: "vendredi",
        6: "samedi",
        7: "dimanche",
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

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataEs;

  /// Tryna keep everything constant

  static String last(String weekday) => "$weekday dernier";
  static String at(String date, String time) => "$date à $time";

  static const CalenderLocalizationData calenderLocalizationDataEs =
      CalenderLocalizationData(
    relativeDayNames: {
      -1: "Hier",
      0: "Aujourd'hui",
      1: "Demain",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  String ordinalNumber(int n) {
    if (n == 1) {
      return "${n}er";
    }

    return "${n}e";
  }

  @override
  Map<RelativeInterval, String> get relativeUnits => {
        RelativeInterval.fewSeconds: "quelques secondes",
        RelativeInterval.aSecond: "une seconde",
        RelativeInterval.seconds: "$srDelta secondes",
        RelativeInterval.aMinute: "une minute",
        RelativeInterval.minutes: "$srDelta minutes",
        RelativeInterval.anHour: "une heure",
        RelativeInterval.hours: "$srDelta heures",
        RelativeInterval.aDay: "un jour",
        RelativeInterval.days: "$srDelta jours",
        RelativeInterval.aMonth: "un mois",
        RelativeInterval.months: "$srDelta mois",
        RelativeInterval.aYear: "un an",
        RelativeInterval.years: "$srDelta ans",
      };
}
