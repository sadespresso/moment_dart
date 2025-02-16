// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/moment_dart.dart';

import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/types.dart';

/// Language: French
/// Country: France
class LocalizationFrFr extends MomentLocalization
    with
        MonthNames,
        Ordinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange {
  static LocalizationFrFr? _instance;

  LocalizationFrFr._internal() : super();

  factory LocalizationFrFr() {
    _instance ??= LocalizationFrFr._internal();

    return _instance!;
  }

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
        DateTime.monday: "lundi",
        DateTime.tuesday: "mardi",
        DateTime.wednesday: "mercredi",
        DateTime.thursday: "jeudi",
        DateTime.friday: "vendredi",
        DateTime.saturday: "samedi",
        DateTime.sunday: "dimanche",
      };

  @override
  FormatSetOptional overrideFormatters() {
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
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "quelques secondes",
          "quelques sec.",
          "quelques sec.",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "une seconde",
          "1 sec.",
          "1 s",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta secondes",
          "$srDelta sec.",
          "$srDelta s",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "une minute",
          "1 min",
          "1 min",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta minutes",
          "$srDelta min",
          "$srDelta min",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "une heure",
          "1 heure",
          "1 h",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta heures",
          "$srDelta heures",
          "$srDelta h",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "un jour",
          "1 jour",
          "1 j",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta jours",
          "$srDelta jours",
          "$srDelta j",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "une semaine",
          "1 sem.",
          "1 sem.",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta semaines",
          "$srDelta sem.",
          "$srDelta sem.",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "un mois",
          "1 mois",
          "1 mois",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta mois",
          "$srDelta mois",
          "$srDelta mois",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "un an",
          "1 an",
          "1 an",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta ans",
          "$srDelta ans",
          "$srDelta ans",
        ),
      };

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Cette semaine",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "Cette année";
          }

          return "Année ${range.year}";
        },
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "Ce mois-ci";
            }

            return monthNames[range.month]!;
          }

          return "${monthNames[range.month]!} ${range.year}";
        },
        allAfter: (formattedDate) => "Après $formattedDate",
        allBefore: (formattedDate) => "Avant $formattedDate",
        customRangeAllTime: "Tout le temps",
      );
}
