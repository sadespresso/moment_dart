// ignore_for_file: file_names

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/pl_PL/duration.dart';
import 'package:moment_dart/src/localizations/mixins/pl_PL/relative.dart';
import 'package:moment_dart/src/localizations/mixins/pl_PL/units.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/mixins/weekday_shortforms.dart';
import 'package:moment_dart/src/types.dart';

/// Language: Polish (Poland)
/// Country: Poland
class LocalizationPlPl extends MomentLocalization
    with
        MonthNames,
        Ordinal,
        SimpleUnits,
        PlPlUnits,
        PlPlRelative,
        PlPlDuration,
        SimpleRange,
        WeekdayShortForms {
  static LocalizationPlPl? _instance;

  LocalizationPlPl._internal() : super();

  factory LocalizationPlPl() {
    _instance ??= LocalizationPlPl._internal();
    return _instance!;
  }

  @override
  String get endonym => "Polski";

  @override
  String get languageCode => "pl";

  @override
  String get countryCode => "PL";

  @override
  String get languageNameInEnglish => "Polish (Poland)";

  @override
  Map<int, String> get monthNames => {
        1: "Styczeń",
        2: "Luty",
        3: "Marzec",
        4: "Kwiecień",
        5: "Maj",
        6: "Czerwiec",
        7: "Lipiec",
        8: "Sierpień",
        9: "Wrzesień",
        10: "Październik",
        11: "Listopad",
        12: "Grudzień",
      };

  /// Genitive forms used in date expressions like "5 marca"
  static const Map<int, String> _monthNamesGenitive = {
    1: "stycznia",
    2: "lutego",
    3: "marca",
    4: "kwietnia",
    5: "maja",
    6: "czerwca",
    7: "lipca",
    8: "sierpnia",
    9: "września",
    10: "października",
    11: "listopada",
    12: "grudnia",
  };

  @override
  Map<int, String> get monthNamesShort => {
        1: "Sty",
        2: "Lut",
        3: "Mar",
        4: "Kwi",
        5: "Maj",
        6: "Cze",
        7: "Lip",
        8: "Sie",
        9: "Wrz",
        10: "Paź",
        11: "Lis",
        12: "Gru",
      };

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Poniedziałek",
        DateTime.tuesday: "Wtorek",
        DateTime.wednesday: "Środa",
        DateTime.thursday: "Czwartek",
        DateTime.friday: "Piątek",
        DateTime.saturday: "Sobota",
        DateTime.sunday: "Niedziela",
      };

  @override
  Map<int, String> get weekdayNameShort => {
        DateTime.monday: "Pon",
        DateTime.tuesday: "Wt",
        DateTime.wednesday: "Śr",
        DateTime.thursday: "Czw",
        DateTime.friday: "Pt",
        DateTime.saturday: "Sob",
        DateTime.sunday: "Ndz",
      };

  @override
  Map<int, String> get weekdayNameMin => {
        DateTime.monday: "Pn",
        DateTime.tuesday: "Wt",
        DateTime.wednesday: "Śr",
        DateTime.thursday: "Cz",
        DateTime.friday: "Pt",
        DateTime.saturday: "So",
        DateTime.sunday: "Nd",
      };

  @override
  FormatSetOptional overrideFormatters() {
    return {
      // From [Ordinal] mixin
      ...formattersWithOrdinal,
      // From [MonthNames] mixin
      ...formattersForMonthNames,
      // From [WeekdayShortForms] mixin
      ...formattersForWeekdayShortForms,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "DD.MM.YYYY"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "D.M.YYYY"),
      FormatterToken.LL: (dateTime) =>
          "${dateTime.day} ${_monthNamesGenitive[dateTime.month]} ${dateTime.year}",
      FormatterToken.ll: (dateTime) =>
          "${dateTime.day} ${monthNamesShort[dateTime.month]} ${dateTime.year}",
      FormatterToken.LLL: (dateTime) =>
          "${dateTime.day} ${_monthNamesGenitive[dateTime.month]} ${dateTime.year} ${reformat(dateTime, "HH:mm")}",
      FormatterToken.lll: (dateTime) =>
          "${dateTime.day} ${monthNamesShort[dateTime.month]} ${dateTime.year} ${reformat(dateTime, "H:mm")}",
      FormatterToken.LLLL: (dateTime) =>
          "${weekdayName[dateTime.weekday]}, ${dateTime.day} ${_monthNamesGenitive[dateTime.month]} ${dateTime.year} ${reformat(dateTime, "HH:mm")}",
      FormatterToken.llll: (dateTime) =>
          "${weekdayNameShort[dateTime.weekday]}, ${dateTime.day} ${monthNamesShort[dateTime.month]} ${dateTime.year} ${reformat(dateTime, "H:mm")}",
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
    };
  }

  @override
  String ordinalNumber(int n) {
    return "$n.";
  }

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataPlPl;

  /// Returns "Ostatni/Ostatnia/Ostatnie" based on grammatical gender
  /// of the Polish weekday name.
  ///
  /// Masculine: Poniedziałek, Wtorek, Czwartek, Piątek
  /// Feminine: Środa, Sobota
  /// Neuter: (none in standard weekdays, but Niedziela is feminine)
  static String last(String weekday) {
    switch (weekday) {
      case "Środa":
      case "Sobota":
      case "Niedziela":
        return "Ostatnia ${weekday.toLowerCase()}";
      default:
        // Poniedziałek, Wtorek, Czwartek, Piątek
        return "Ostatni ${weekday.toLowerCase()}";
    }
  }

  static String at(String date, String time) => "$date o $time";

  static const CalenderLocalizationData calenderLocalizationDataPlPl =
      CalenderLocalizationData(
    relativeDayNames: {
      -2: "Przedwczoraj",
      -1: "Wczoraj",
      0: "Dzisiaj",
      1: "Jutro",
      2: "Pojutrze",
    },
    keywords: CalenderLocalizationKeywords(
      at: at,
      lastWeekday: last,
    ),
  );

  @override
  int get weekStart => DateTime.monday;

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Ten tydzień",
        year: (range, {anchor, useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "W tym roku";
          }

          return "${range.year} rok";
        },
        month: (range, {anchor, useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "W tym miesiącu";
            }

            return monthNames[range.month]!;
          }

          return "${monthNames[range.month]!} ${range.year}";
        },
        allAfter: (formattedDate) => "Po $formattedDate",
        allBefore: (formattedDate) => "Przed $formattedDate",
        customRangeAllTime: "Cały czas",
      );
}
