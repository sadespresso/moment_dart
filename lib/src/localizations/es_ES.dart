// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/moment_dart.dart';

import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Language: Spanish
/// Country: Spain
class LocalizationEsEs extends MomentLocalization
    with
        MonthNames,
        Ordinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange {
  static LocalizationEsEs? _instance;

  LocalizationEsEs._internal() : super();

  factory LocalizationEsEs() {
    _instance ??= LocalizationEsEs._internal();

    return _instance!;
  }

  @override
  String get endonym => "Español";

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
        DateTime.monday: "lunes",
        DateTime.tuesday: "martes",
        DateTime.wednesday: "miércoles",
        DateTime.thursday: "jueves",
        DateTime.friday: "viernes",
        DateTime.saturday: "sábado",
        DateTime.sunday: "domingo",
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

  static String last(String weekday) => "el $weekday pasado";
  static String at(String date, String time) => "$date a $time";

  @override
  CalendarLocalizationData get calendarData => calendarLocalizationDataEs;

  static const CalendarLocalizationData calendarLocalizationDataEs =
      CalendarLocalizationData(
    relativeDayNames: {
      // -2: "anteayer",
      -1: "ayer",
      0: "hoy",
      1: "mañana",
      // 2: "pasado mañana",
    },
    keywords: CalendarLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  String ordinalNumber(int n) => "$nº";

  @override
  String get delimeterConnector => "y";

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "unos segundos",
          "unos seg.",
          "unos s",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "un segundo",
          "1 seg.",
          "1 s",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta segundos",
          "$srDelta seg.",
          "$srDelta s",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "un minuto",
          "1 min.",
          "1 min.",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta minutos",
          "$srDelta min.",
          "$srDelta min",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "una hora",
          "1 hora",
          "1 h",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta horas",
          "$srDelta horas",
          "$srDelta h",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "un día",
          "1 día",
          "1 d",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta días",
          "$srDelta días",
          "$srDelta d",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "una semana",
          "1 semana",
          "1 sem.",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta semanas",
          "$srDelta semanas",
          "$srDelta sem.",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "un mes",
          "1 mes",
          "1 ms.",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta meses",
          "$srDelta meses",
          "$srDelta ms.",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "un año",
          "1 año",
          "1 año",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta años",
          "$srDelta años",
          "$srDelta años",
        ),
      };

  @override
  Map<DurationInterval, UnitString> get durationUnits => {
        ...units,
        DurationInterval.aSecond: UnitString.withForm(
          "1 segundo",
          "1 seg.",
          "1 s",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "1 minuto",
          "1 min.",
          "1 min.",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "1 hora",
          "1 hora",
          "1 h",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "1 día",
          "1 día",
          "1 d",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "1 semana",
          "1 semana",
          "1 sem.",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "1 mes",
          "1 mes",
          "1 ms.",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "1 año",
          "1 año",
          "1 año",
        ),
      };

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Esta semana",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "Este año";
          }

          return "Año ${range.year}";
        },
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "Este mes";
            }

            return monthNames[range.month]!;
          }

          return "${monthNames[range.month]!} ${range.year}";
        },
        allAfter: (formattedDate) => "Desde ${_withArticle(formattedDate)}",
        allBefore: (formattedDate) => "Hasta ${_withArticle(formattedDate)}",
        customRangeAllTime: "Todo el tiempo",
      );

  // "Desde el 1/3/2024", "Desde el viernes", but "Desde ayer" and
  // "Desde el jueves pasado" (already has its article).
  String _withArticle(String formattedDate) {
    if (formattedDate.startsWith("el ")) return formattedDate;

    for (final String dayName
        in calendarLocalizationDataEs.relativeDayNames.values) {
      if (formattedDate.startsWith(dayName)) return formattedDate;
    }

    return "el $formattedDate";
  }
}
