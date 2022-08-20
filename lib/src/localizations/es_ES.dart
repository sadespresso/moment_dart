// ignore_for_file: file_names

import 'package:moment_dart/moment_dart.dart';

import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Language: Spanish
/// Country: Spain
class LocalizationEsEs extends MomentLocalization
    with MonthNames, Ordinal, SimpleUnits, SimpleRelative, SimpleDuration {
  LocalizationEsEs() : super();

  @override
  String get endonym => "Espanol (Espana)";

  @override
  String get languageCode => "es";

  @override
  String get countryCode => "ES";

  @override
  String get languageNameInEnglish => "Spanish (Spain)";

  @override
  String relativePast(String unit) => "hace $unit";
  @override
  String relativeFuture(String unit) => "en $unit";

  @override
  String calendarTime(Moment moment) =>
      "la${moment.hour == 1 ? '' : 's'} ${moment.format(MomentLocalization.localizationDefaultHourFormat)}";

  @override
  Map<int, String> get monthNames => {
        1: "enero",
        2: "febrero",
        3: "marzo",
        4: "abril",
        5: "mayo",
        6: "junio",
        7: "julio",
        8: "agosto",
        9: "septiembre",
        10: "octubre",
        11: "noviembre",
        12: "diciembre",
      };

  @override
  Map<int, String> get monthNamesShort =>
      monthNames.map((key, value) => MapEntry(key, value.substring(0, 3)));

  @override
  Map<int, String> get weekdayName => {
        1: "lunes",
        2: "martes",
        3: "miércoles",
        4: "jueves",
        5: "viernes",
        6: "sábado",
        7: "domingo",
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
      FormatterToken.LL: (dateTime) =>
          reformat(dateTime, "D [de] MMMM [de] YYYY"),
      FormatterToken.ll: (dateTime) =>
          reformat(dateTime, "D [de] MMM [de] YYYY"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "D [de] MMMM [de] YYYY H:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "D [de] MMM [de] YYYY H:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, D [de] MMMM [de] YYYY H:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, D [de] MMM [de] YYYY H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "H:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "H:mm:ss"),
    };
  }

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataEs;

  static String last(String weekday) => "el $weekday";
  static String at(String date, String time) => "$date a $time";

  static const CalenderLocalizationData calenderLocalizationDataEs =
      CalenderLocalizationData(
    relativeDayNames: {
      // -2: "anteayer",
      -1: "ayer",
      0: "hoy",
      1: "mañana",
      // 2: "pasado mañana",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  String ordinalNumber(int n) {
    return "$nº";
  }

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.fewSeconds: UnitString.withForm(
          "unos segundos",
          "unos segundos",
          "unos segundos",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "un segundo",
          "un segundo",
          "un segundo",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta segundos",
          "$srDelta segundos",
          "$srDelta segundos",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "un minuto",
          "un minuto",
          "un minuto",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta minutos",
          "$srDelta minutos",
          "$srDelta minutos",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "un hora",
          "un hora",
          "un hora",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta horas",
          "$srDelta horas",
          "$srDelta horas",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "un día",
          "un día",
          "un día",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta días",
          "$srDelta días",
          "$srDelta días",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "una semana",
          "una semana",
          "una semana",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta semanas",
          "$srDelta semanas",
          "$srDelta semanas",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "un mes",
          "un mes",
          "un mes",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta meses",
          "$srDelta meses",
          "$srDelta meses",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "un año",
          "un año",
          "un año",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta años",
          "$srDelta años",
          "$srDelta años",
        ),
      };
}
