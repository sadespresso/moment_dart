// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/localizations/mixins/complex_calendar.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/types.dart';

/// Language: Portuguese
/// Country: Portuguese Republic
class LocalizationPtPt extends MomentLocalization
    with
        MonthNames,
        Ordinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        ComplexCalendar,
        SimpleRange {
  static LocalizationPtPt? _instance;

  LocalizationPtPt._internal() : super();

  factory LocalizationPtPt() {
    _instance ??= LocalizationPtPt._internal();

    return _instance!;
  }

  @override
  String get endonym => "República Portuguesa";

  @override
  String get languageCode => "pt";

  @override
  String get countryCode => "PT";

  @override
  String get languageNameInEnglish => "Portuguese";

  @override
  String relativePast(String unit) => "há $unit";
  @override
  String relativeFuture(String unit) => "em $unit";

  @override
  Map<int, String> get monthNames => {
        1: "janeiro",
        2: "fevereiro",
        3: "março",
        4: "abril",
        5: "maio",
        6: "junho",
        7: "julho",
        8: "agosto",
        9: "setembro",
        10: "outubro",
        11: "novembro",
        12: "dezembro",
      };

  @override
  Map<int, String> get monthNamesShort =>
      monthNames.map((key, value) => MapEntry(key, value.substring(0, 3)));

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Segunda-feira",
        DateTime.tuesday: "Terça-feira",
        DateTime.wednesday: "Quarta-feira",
        DateTime.thursday: "Quinta-feira",
        DateTime.friday: "Sexta-feira",
        DateTime.saturday: "Sábado",
        DateTime.sunday: "Domingo",
      };

  Map<int, String> get weekdayNameMin => {
        DateTime.monday: "2ª",
        DateTime.tuesday: "3ª",
        DateTime.wednesday: "4ª",
        DateTime.thursday: "5ª",
        DateTime.friday: "6ª",
        DateTime.saturday: "Sá",
        DateTime.sunday: "Do",
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
          reformat(dateTime, "Do [de] MMMM [de] YYYY"),
      FormatterToken.ll: (dateTime) =>
          reformat(dateTime, "Do [de] MMM [de] YYYY"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "Do [de] MMMM [de] YYYY HH:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "Do [de] MMM [de] YYYY HH:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, Do [de] MMMM [de] YYYY HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, Do [de] MMM [de] YYYY HH:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  @override
  int get weekStart => DateTime.sunday;

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "alguns segundos",
          "alguns segundos",
          "alguns seg",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "um segundo",
          "1 seg",
          "1 s",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta segundos",
          "$srDelta seg",
          "$srDelta s",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "um minuto",
          "1 min",
          "1 m",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta minutos",
          "$srDelta min",
          "$srDelta m",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "uma hora",
          "1 hora",
          "1 h",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta horas",
          "$srDelta horas",
          "$srDelta h",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "um dia",
          "1 dia",
          "1 d",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta dias",
          "$srDelta dias",
          "$srDelta d",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "uma semana",
          "1 sem",
          "1 sem",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta semanas",
          "$srDelta sem",
          "$srDelta sem",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "um mês",
          "1 mês",
          "1 mê",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta mêses",
          "$srDelta mêses",
          "$srDelta mê",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "um ano",
          "1 ano",
          "1 a",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta anos",
          "$srDelta anos",
          "$srDelta a",
        ),
      };

  @override
  String ordinalNumber(int n) => "$nº";

  @override
  ComplexCalenderLocalizationData get complexCalendarData =>
      ComplexCalenderLocalizationData(
        keywords: ComplexCalenderLocalizationKeywords(
          at: (
            DateTime dateTime,
            String dateString,
            String timeString, {
            reference,
          }) =>
              "$dateString às $timeString",
          lastWeekday: (dateTime, {reference}) {
            switch (dateTime.weekday) {
              case DateTime.saturday:
              case DateTime.sunday:
                return "Último ${reformat(dateTime, "dddd")}";
              default:
                return "Última ${reformat(dateTime, "dddd")}";
            }
          },
          nextWeekday: (DateTime dateTime, {reference}) =>
              reformat(dateTime, "dddd"),
        ),
        relativeDayNames: {
          -1: "Ontem",
          0: "Hoje",
          1: "Amanhã",
        },
      );

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Esta semana",
        thisMonth: "Este mês",
        thisYear: "Este ano",
        year: (range) => "Ano ${range.year}",
        month: (range) => monthNames[range.month]!,
        customRangeAfter: (formattedDate) => "Após $formattedDate",
        customRangeBefore: (formattedDate) => "Antes de $formattedDate",
        customRangeAllTime: "Todo o tempo",
      );
}
