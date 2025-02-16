// ignore_for_file: file_names
// Author: Batmend Ganbaatar (https://github.com/sadespresso)

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/ordinal_numbers.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/mixins/mn_MN/units.dart';
import 'package:moment_dart/src/types.dart';

/// Language: Mongolian (Cyrillic)
/// Country: Mongolia
class LocalizationMnMn extends MomentLocalization
    with Ordinal, SimpleUnits, MnMnUnits, SimpleDuration, SimpleRange {
  static LocalizationMnMn? _instance;

  LocalizationMnMn._internal() : super();

  factory LocalizationMnMn() {
    _instance ??= LocalizationMnMn._internal();

    return _instance!;
  }

  @override
  String get endonym => "Монгол хэл";

  @override
  String get languageCode => "mn";

  @override
  String get countryCode => "MN";

  @override
  String get languageNameInEnglish => "Mongolian";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    DurationInterval interval = MomentLocalization.relativeThreshold(duration);

    String value = getUnit(
      interval,
      form,
      dropPrefixOrSuffix: dropPrefixOrSuffix,
    );

    if (!interval.singular) {
      value = value.replaceAll(
        srDelta,
        DurationUnit.relativeDuration(duration, interval.unit).toString(),
      );
    }

    if (dropPrefixOrSuffix) return value;

    return past ? relativePast(value) : relativeFuture(value);
  }

  String monthName(int i) => "${ordinalNumber(i)} сар";

  @override
  FormatSetOptional overrideFormatters() {
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
      FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
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
          "${weekdayName[dateTime.weekday]} гараг",
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
        DateTime.monday: "Даваа",
        DateTime.tuesday: "Мягмар",
        DateTime.wednesday: "Лхагва",
        DateTime.thursday: "Пүрэв",
        DateTime.friday: "Баасан",
        DateTime.saturday: "Бямба",
        DateTime.sunday: "Ням",
      };

  @override
  String ordinalNumber(int n) {
    return "$n ${(LocalizationMnMongMn.isFeminine(n) ? "дүгээр" : "дугаар")}";
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

  @override
  SimpleRangeData get simpleRangeData => SimpleRangeData(
        thisWeek: "Энэ долоо хоног",
        year: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && range.year == anchor.year) {
            return "Энэ жил";
          }

          return "${range.year} он";
        },
        month: (range, {DateTime? anchor, bool useRelative = true}) {
          anchor ??= Moment.now();

          if (useRelative && anchor.year == range.year) {
            if (anchor.month == range.month) {
              return "Энэ сар";
            }

            return monthName(range.month);
          }

          return "${range.year} оны ${monthName(range.month)}";
        },
        allAfter: (formattedDate) => "$formattedDate-с хойш",
        allBefore: (formattedDate) => "$formattedDate-с өмнө",
        customRangeAllTime: "Бүх цаг үе",
      );
}
