// ignore_for_file: file_names

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/calendar.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';

/// Language: Cyrillic Mongolian
/// Country: Mongolia
class LocalizationMongolianCyrillic extends MomentLocalization with Ordinal {
  LocalizationMongolianCyrillic() : super();

  @override
  String get endonym => "Монгол хэл";

  @override
  String get languageCodeISO => "mn";

  @override
  String get locale => "mn";

  @override
  String get languageNameInEnglish => "Mongolian (Cyrillic)";

  static String relativePast(String alpha) => "$alpha өмнө";
  static String relativeFuture(String alpha) => "$alpha дараа";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;
    late final bool isSuffixMasculine;

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        isSuffixMasculine = true;
        value = "хэдэн ${dropPrefixOrSuffix ? "хором" : "хорм"}";
        break;
      case RelativeInterval.aMinute:
        isSuffixMasculine = true;
        value = "1 минут";
        break;
      case RelativeInterval.minutes:
        isSuffixMasculine = true;
        value = "${(duration.inSeconds / 60).round()} минут";
        break;
      case RelativeInterval.anHour:
        isSuffixMasculine = false;
        value = "1 цаг";
        break;
      case RelativeInterval.hours:
        isSuffixMasculine = false;
        value = "${(duration.inMinutes / 60).round()} цаг";
        break;
      case RelativeInterval.aDay:
        isSuffixMasculine = false;
        value =
            "1 ${dropPrefixOrSuffix ? "өдөр" : "өдр"}"; // Here the letter "ө" will be omitted when
        break;
      case RelativeInterval.days:
        isSuffixMasculine = false;
        value =
            "${(duration.inHours / 24).round()} ${dropPrefixOrSuffix ? "өдөр" : "өдр"}";
        break;
      case RelativeInterval.aMonth:
        isSuffixMasculine = true;
        value = "1 сар";
        break;
      case RelativeInterval.months:
        isSuffixMasculine = true;
        value = "${(duration.inDays / 30).round()} сар";
        break;
      case RelativeInterval.aYear:
        isSuffixMasculine = false;
        value = "1 жил";
        break;
      case RelativeInterval.years:
        isSuffixMasculine = false;
        value = "${(duration.inDays / 365).round()} жил";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    final String suffix = (isSuffixMasculine ? "ын" : "ийн");

    return past ? relativePast(value + suffix) : relativeFuture(value + suffix);
  }

  String monthName(int i) => "${ordinalNumber(i)} сар";

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() {
    return {
      // From [Ordinal] mixin
      ...formattersWithOrdinal,
      // Localization aware formats
      FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
      FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY/M/D"),
      FormatterToken.LL: (dateTime) => reformat(dateTime, "YYYY оны MMMMын D"),
      FormatterToken.ll: (dateTime) => reformat(dateTime, "YYYY оны MMMын D"),
      FormatterToken.LLL: (dateTime) =>
          reformat(dateTime, "YYYY оны MMMMын D, HH:mm"),
      FormatterToken.lll: (dateTime) =>
          reformat(dateTime, "YYYY оны MMMын D, H:mm"),
      FormatterToken.LLLL: (dateTime) =>
          reformat(dateTime, "dddd, YYYY оны MMMMын D, HH:mm"),
      FormatterToken.llll: (dateTime) =>
          reformat(dateTime, "ddd, YYYY оны MMMын D, H:mm"),
      FormatterToken.LT: (dateTime) => reformat(dateTime, "H:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "H:mm:ss"),
      // Customs
      FormatterToken.A: (dateTime) => dateTime.hour < 12 ? "Ү.Ө" : "Ү.Х",
      FormatterToken.a: (dateTime) => dateTime.hour < 12 ? "ү.ө" : "ү.х",
      FormatterToken.MMM: (dateTime) => "${dateTime.month} сар",
      FormatterToken.MMMM: (dateTime) => monthName(dateTime.month),
      // Wanted to include the "гараг" in full form
      FormatterToken.dd: (dateTime) =>
          weekdayName[dateTime.weekday]!.substring(0, 3),
      FormatterToken.ddd: (dateTime) => weekdayName[dateTime.weekday]!,
      FormatterToken.dddd: (dateTime) =>
          "${weekdayName[dateTime.weekday]!} гараг",
      // Era
      FormatterToken.NN: (dateTime) => dateTime.year < 1 ? "НТӨ" : "НТ",
      FormatterToken.NNNN: (dateTime) =>
          dateTime.year < 1 ? "Нийтийн тооллын өмнөх" : "Нийтийн тоолол",
      FormatterToken.NNNNN: (dateTime) => dateTime.year < 1 ? "НТӨ" : "НТ",
    };
  }

  /// Tibet weekday names are here, because it is majorly used in Mongolia
  @override
  Map<int, String> get weekdayName => {
        1: "Даваа",
        2: "Мягмар",
        3: "Лхагва",
        4: "Пүрэв",
        5: "Баасан",
        6: "Бямба",
        7: "Ням",
      };

  @override
  String ordinalNumber(int n) {
    return "$n ${(LocalizationMongolianTraditional.isFeminine(n) ? "дүгээр" : "дугаар")}";
  }

  @override
  CalenderLocalizationData get calendarData => calenderLocalizationDataMn;

  static String last(String weekday) => "Өнгөрсөн $weekday";

  static const CalenderLocalizationData calenderLocalizationDataMn =
      CalenderLocalizationData(
    relativeDayNames: {
      -2: "Уржигдар",
      -1: "Өчигдөр",
      0: "Өнөөдөр",
      1: "Маргааш",
      2: "Нөгөөдөр",
    },
    keywords: CalenderLocalizationKeywords(
      lastWeekday: last,
    ),
  );
}
