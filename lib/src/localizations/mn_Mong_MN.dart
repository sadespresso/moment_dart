// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/mn_Mong_MN/duration.dart';
import 'package:moment_dart/src/localizations/mixins/mn_Mong_MN/units.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

/// Language: Traditional Mongolian with Arabic numbers
/// Country: Mongolia
class LocalizationMnMongMn extends MomentLocalization
    with Ordinal, SimpleUnits, MnMongMnUnits, MnMongMnDuration, SimpleRange {
  static LocalizationMnMongMn? _instance;

  LocalizationMnMongMn._internal() : super();

  factory LocalizationMnMongMn() {
    _instance ??= LocalizationMnMongMn._internal();

    return _instance!;
  }

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

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration,
      {bool dropPrefixOrSuffix = false,
      Abbreviation form = Abbreviation.none}) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    DurationInterval interval = MomentLocalization.relativeThreshold(duration);

    String value =
        getUnit(interval, form, dropPrefixOrSuffix: dropPrefixOrSuffix);

    if (!interval.singular) {
      value = value.replaceAll(
        srDelta,
        DurationUnit.relativeDuration(duration, interval.unit).toString(),
      );
    }

    if (dropPrefixOrSuffix) {
      return value;
    }

    return past ? relativePast(value) : relativeFuture(value);
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

  String monthName(int i) => "${ordinalNumber(i)} ᠰᠠᠷ\u180Eᠠ";

  @override
  FormatSetOptional overrideFormatters() {
    return {
      // From [Ordinal] mixin
      ...formattersWithOrdinal,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY/M/D"),
      FormatterToken.LL: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ\u180Eᠤ MMMM\u180Eᠶᠢᠨ D"),
      FormatterToken.ll: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ\u180Eᠤ MMM\u180Eᠶᠢᠨ D"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ\u180Eᠤ MMMM\u180Eᠶᠢᠨ D᠂ HH:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "YYYY ᠣᠨ\u180Eᠤ MMM\u180Eᠶᠢᠨ D᠂ H:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd᠂ YYYY ᠣᠨ\u180Eᠤ MMMM\u180Eᠶᠢᠨ D᠂ HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd᠂ YYYY ᠣᠨ\u180Eᠤ MMM\u180Eᠶᠢᠨ D᠂ H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
      // Missings
      FormatterToken.MMM: (dateTime) => "${dateTime.month} ᠰᠠᠷ\u180Eᠠ",
      FormatterToken.MMMM: (dateTime) => monthName(dateTime.month),
      FormatterToken.A: (dateTime) => dateTime.hour < 12
          ? "ᠦᠳᠡ\u180Eᠡᠴᠡ ᠡᠮᠦᠨ\u180Eᠡ"
          : "ᠦᠳᠡ\u180Eᠡᠴᠡ ᠬᠣᠢᠰᠢ",
      FormatterToken.a: (dateTime) => dateTime.hour < 12
          ? "ᠦᠳᠡ\u180Eᠡᠴᠡ ᠡᠮᠦᠨ\u180Eᠡ"
          : "ᠦᠳᠡ\u180Eᠡᠴᠡ ᠬᠣᠢᠰᠢ",

      FormatterToken.dd: (dateTime) => weekdayNameShort[dateTime.weekday]!,
      FormatterToken.ddd: (dateTime) => weekdayName[dateTime.weekday]!,
      FormatterToken.dddd: (dateTime) =>
          "${weekdayName[dateTime.weekday]!} ᠡᠳᠦᠷ",
    };
  }

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "ᠰᠠᠷᠠᠨ",
        DateTime.tuesday: "ᠤᠯᠠᠭᠠᠨ",
        DateTime.wednesday: "ᠦᠯᠡᠮᠵᠢ",
        DateTime.thursday: "ᠭᠠᠳᠠᠰᠤ",
        DateTime.friday: "ᠴᠣᠯᠮᠤᠨ",
        DateTime.saturday: "ᠬᠡᠰᠢᠭ",
        DateTime.sunday: "ᠨᠠᠷᠠᠨ",
      };
  Map<int, String> get weekdayNameShort => {
        1: "ᠰᠠ᠊",
        2: "ᠤᠯ᠊",
        3: "ᠦᠯ᠊",
        4: "ᠭᠠ᠊",
        5: "ᠴᠣ᠊",
        6: "ᠬᠡ᠊",
        7: "ᠨᠠ᠊",
      };

  @override
  String ordinalNumber(int n) {
    return n.toString() +
        (LocalizationMnMongMn.isFeminine(n) ? "\u180Eᠳᠦᠭᠡᠷ" : "\u180Eᠳᠤᠭᠠᠷ");
  }

  @override
  CalendarLocalizationData get calendarData =>
      calendarLocalizationDataMnTraditional;

  static String last(String weekday) => "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ $weekday";

  static const CalendarLocalizationData calendarLocalizationDataMnTraditional =
      CalendarLocalizationData(
    relativeDayNames: {
      -2: "ᠤᠷᠵᠢᠳᠤᠷ",
      -1: "ᠥᠴᠦᠭᠡᠳᠦᠷ",
      0: "ᠥᠨᠦᠳᠦᠷ",
      1: "ᠮᠠᠷᠭᠠᠰᠢ",
      2: "ᠨᠥᠭᠦᠭᠡᠳᠦᠷ",
    },
    keywords: CalendarLocalizationKeywords(
      lastWeekday: last,
    ),
  );

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "ᠡᠨᠡ ᠳᠣᠯᠤᠭ\u180Eᠠ ᠬᠣᠨᠤᠭ",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "ᠡᠨᠡ ᠵᠢᠯ";
          }

          return "${range.year} ᠣᠨ";
        },
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "ᠡᠨᠡ ᠰᠠᠷ\u180Eᠠ";
            }

            return monthName(range.month);
          }

          return "${range.year} ᠣᠨ\u180Eᠤ ${monthName(range.month)}";
        },
        allAfter: (formattedDate) => "$formattedDate\u180Eᠡᠴᠡ ᠬᠣᠢᠰᠢ",
        allBefore: (formattedDate) => "$formattedDate\u180Eᠡᠴᠡ ᠡᠮᠦᠨ\u180Eᠡ",
        customRangeAllTime: "ᠪᠦᠬᠦ ᠴᠠᠭ ᠦᠶ\u180Eᠡ",
      );
}

/// Language: Traditional Mongolian with Traditional Numbers
/// Country: Mongolia
class LocalizationMnQaaqMn extends LocalizationMnMongMn {
  static LocalizationMnQaaqMn? _instance;

  LocalizationMnQaaqMn._internal() : super._internal();

  factory LocalizationMnQaaqMn() {
    _instance ??= LocalizationMnQaaqMn._internal();

    return _instance!;
  }

  @override
  String get languageNameInEnglish =>
      "Mongolian (Traditional Script with traditional numbers)";

  @override
  String get locale =>
      "mn_Qaaq_MN"; // Here, 'Qaaq' is reserved private use script code

  static const Map<String, String> mongolianNumbers = {
    "0": "᠐",
    "1": "᠑",
    "2": "᠒",
    "3": "᠓",
    "4": "᠔",
    "5": "᠕",
    "6": "᠖",
    "7": "᠗",
    "8": "᠘",
    "9": "᠙",
  };

  @override
  String duration(
    Duration duration, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    Abbreviation form = Abbreviation.none,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) {
    return toTraditionalNumber(super.duration(
      duration,
      round: round,
      omitZeros: omitZeros,
      includeWeeks: includeWeeks,
      form: form,
      delimiter: delimiter,
      format: format,
      dropPrefixOrSuffix: dropPrefixOrSuffix,
    ));
  }

  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) {
    return toTraditionalNumber(super.relative(
      duration,
      dropPrefixOrSuffix: dropPrefixOrSuffix,
      form: form,
    ));
  }

  String toTraditionalNumber(String input) {
    mongolianNumbers.forEach((key, value) {
      input = input.replaceAll(key, value);
    });

    return input;
  }

  @override
  String ordinalNumber(int n) => toTraditionalNumber(super.ordinalNumber(n));

  @override
  FormatSetOptional get formatters => super.formatters.map(
        (key, value) => MapEntry(
          key,
          value == null
              ? null
              : (DateTime dateTime) => toTraditionalNumber(
                    value(dateTime),
                  ),
        ),
      );

  @override
  SimpleRangeData get simpleRangeData {
    final SimpleRangeData base = super.simpleRangeData;

    return SimpleRangeData(
      thisWeek: base.thisWeek,
      year: (range, {DateTime? anchor, bool useRelative = true}) =>
          toTraditionalNumber(
              base.year(range, anchor: anchor, useRelative: useRelative)),
      month: (range, {DateTime? anchor, bool useRelative = true}) =>
          toTraditionalNumber(
              base.month(range, anchor: anchor, useRelative: useRelative)),
      allAfter: base.allAfter,
      allBefore: base.allBefore,
      customRangeAllTime: base.customRangeAllTime,
      customRangeDelimiter: base.customRangeDelimiter,
      reverseRangeDates: base.reverseRangeDates,
    );
  }
}
