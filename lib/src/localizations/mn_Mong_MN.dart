// ignore_for_file: file_names

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';

/// Language: Traditional Mongolian with Arabic numbers
/// Country: Mongolia
class LocalizationMnMongMn extends MomentLocalization with Ordinal {
  LocalizationMnMongMn() : super();

  @override
  String get endonym => "ᠮᠣᠩᠭᠤᠯ ᠬᠡᠯᠡ";

  @override
  String get languageCode => "mn";

  @override
  String get countryCode => "MN";

  @override
  String get locale => "mn_Mong_MN";

  @override
  String get languageNameInEnglish => "Mongolian (Traditional Script)";

  static String relativePast(String alpha) => "$alpha ᠡᠮᠦᠨ᠎ᠡ";
  static String relativeFuture(String alpha) => "$alpha ᠳᠠᠷᠠᠭ᠎ᠠ";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration,
      {bool dropPrefixOrSuffix = false,
      UnitStringForm form = UnitStringForm.full}) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    DurationInterval interval = MomentLocalization.relativeThreshold(duration);

    late final String unit;

    if (interval == DurationInterval.fewSeconds) {
      unit = "ᠬᠡᠳᠦᠨ";
    } else if (interval.singular) {
      unit = "1";
    } else {
      unit = DurationUnit.relativeDuration(duration, interval.unit).toString();
    }

    late final String unitName;
    late final bool useFeminineSuffix;

    switch (interval.unit) {
      case DurationUnit.second:
        unitName = "ᠬᠣᠷᠤᠮ";
        useFeminineSuffix = false;
        break;
      case DurationUnit.minute:
        unitName = "ᠮᠢᠨᠦ᠋ᠲ᠋";
        useFeminineSuffix = true;
        break;
      case DurationUnit.hour:
        unitName = "ᠴᠠᠭ";
        useFeminineSuffix = false;
        break;
      case DurationUnit.day:
        unitName = "ᠡᠳᠦᠷ";
        useFeminineSuffix = true;
        break;
      case DurationUnit.week:
        unitName = "ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ";
        useFeminineSuffix = false;
        break;
      case DurationUnit.month:
        unitName = "ᠰᠠᠷ᠎ᠠ";
        useFeminineSuffix = false; // doesn't matter
        break;
      case DurationUnit.year:
        unitName = "ᠵᠢᠯ";
        useFeminineSuffix = false;
        break;
      case DurationUnit.microsecond:
        break;
      case DurationUnit.millisecond:
        break;
    }

    final String value = "$unit $unitName";

    if (dropPrefixOrSuffix) return value;

    late final String suffix; // Language specific stuff

    if (interval.unit == DurationUnit.month) {
      suffix = " ᠶᠢᠨ";
    } else {
      suffix = (useFeminineSuffix ? " ᠦᠨ" : " ᠤᠨ");
    }

    return past ? relativePast(value + suffix) : relativeFuture(value + suffix);
  }

  static bool isFeminine(int i) {
    late final bool feminine;

    if ([10, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9, 1e10].contains(i)) {
      feminine = false;
    } else {
      int moduloTen = i % 10;

      // Dealing with 10s. e.g. 40, 90 is feminine.
      if (moduloTen == 0) {
        moduloTen = i ~/ 10;
        moduloTen %= 10;

        const List<int> feminineUnits = [4, 9];

        feminine = feminineUnits.contains(moduloTen);
      } else {
        const List<int> feminineUnits = [1, 4, 9];

        feminine = feminineUnits.contains(moduloTen);
      }
    }

    return feminine;
  }

  String monthName(int i) => "${ordinalNumber(i)} ᠰᠠᠷ᠎ᠠ";

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() {
    return {
      // From [Ordinal] mixin
      ...formattersWithOrdinal,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY/M/D"),
      FormatterToken.LL: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ ᠤ MMMM ᠶᠢᠨ D"),
      FormatterToken.ll: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ ᠤ MMM ᠶᠢᠨ D"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ ᠤ MMMM ᠶᠢᠨ D᠂ HH:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ ᠤ MMM ᠶᠢᠨ D᠂ HH:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, YYYY ᠣᠨ ᠤ MMMM ᠶᠢᠨ D᠂ H:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, YYYY ᠣᠨ ᠤ MMM ᠶᠢᠨ D᠂ H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "H:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "H:mm:ss"),
      // Missings
      FormatterToken.MMM: (dateTime) => "${dateTime.month} ᠰᠠᠷ᠎ᠠ",
      FormatterToken.MMMM: (dateTime) => monthName(dateTime.month),
      FormatterToken.A: (dateTime) =>
          dateTime.hour < 12 ? "ᠦᠳᠡ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ" : "ᠦᠳᠡ ᠡᠴᠡ ᠡᠮᠦᠨ᠎ᠡ",
      FormatterToken.a: (dateTime) =>
          dateTime.hour < 12 ? "ᠦᠳᠡ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ" : "ᠦᠳᠡ ᠡᠴᠡ ᠡᠮᠦᠨ᠎ᠡ",

      FormatterToken.dd: (dateTime) => weekdayNameShort[dateTime.weekday]!,
      FormatterToken.ddd: (dateTime) => weekdayName[dateTime.weekday]!,
      FormatterToken.dddd: (dateTime) =>
          "${weekdayName[dateTime.weekday]!} ᠡᠳᠦᠷ",
    };
  }

  @override
  Map<int, String> get weekdayName => {
        1: "ᠰᠠᠷᠠᠨ",
        2: "ᠤᠯᠠᠭᠠᠨ",
        3: "ᠥᠯᠡᠮᠵᠢ",
        4: "ᠭᠠᠳᠠᠰᠤ",
        5: "ᠴᠣᠯᠮᠤᠨ",
        6: "ᠬᠡᠰᠢᠭ",
        7: "ᠨᠠᠷᠠᠨ",
      };
  Map<int, String> get weekdayNameShort => {
        1: "ᠰᠠ᠊",
        2: "ᠤᠯ᠊",
        3: "ᠥᠯ᠊",
        4: "ᠭᠠ᠊",
        5: "ᠴᠣ᠊",
        6: "ᠬᠡ᠊",
        7: "ᠨᠠ᠊",
      };

  @override
  String ordinalNumber(int n) {
    return n.toString() +
        (LocalizationMnMongMn.isFeminine(n) ? " ᠳᠦᠭᠡᠷ" : " ᠳᠤᠭᠠᠷ");
  }

  @override
  CalenderLocalizationData get calendarData =>
      calenderLocalizationDataMnTraditional;

  static String last(String weekday) => "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ $weekday";

  static const CalenderLocalizationData calenderLocalizationDataMnTraditional =
      CalenderLocalizationData(
    relativeDayNames: {
      -2: "ᠤᠷᠵᠢᠳᠤᠷ",
      -1: "ᠦᠴᠦᠭᠡᠳᠦᠷ",
      0: "ᠥᠨᠦᠳᠦᠷ",
      1: "ᠮᠠᠷᠭᠠᠰᠢ",
      2: "ᠨᠥᠭᠦᠭᠡᠳᠦᠷ",
    },
    keywords: CalenderLocalizationKeywords(
      lastWeekday: last,
    ),
  );

  @override
  String duration(
    Duration duration, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    UnitStringForm form = UnitStringForm.full,
    String delimiter = " ",
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) {
    // TODO: implement duration
    throw UnimplementedError();
  }
}