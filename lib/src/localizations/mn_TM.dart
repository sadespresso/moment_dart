// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: Traditional Mongolian (Unicode)
/// Country: Mongolia
class LocalizationMongolianTraditional extends MomentLocalization {
  LocalizationMongolianTraditional() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativeDeadline = "$alpha ᠳᠣᠳᠤᠷ᠎ᠠ";
  static const String relativePast = "$alpha ᠡᠮᠦᠨ᠎ᠡ";
  static const String relativeFuture = "$alpha ᠳᠠᠷᠠᠭ᠎ᠠ";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;
    late final bool isSuffixFeminine;

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        isSuffixFeminine = false;
        value = "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ";
        break;
      case RelativeInterval.aMinute:
        isSuffixFeminine = true;
        value = "1 ᠮᠢᠨᠦ᠋ᠲ᠋";
        break;
      case RelativeInterval.minutes:
        isSuffixFeminine = true;
        value = "${(duration.inSeconds / 60).round()} ᠮᠢᠨᠦ᠋ᠲ᠋";
        break;
      case RelativeInterval.anHour:
        isSuffixFeminine = false;
        value = "1 ᠴᠠᠭ";
        break;
      case RelativeInterval.hours:
        isSuffixFeminine = false;
        value = "${(duration.inMinutes / 60).round()} ᠴᠠᠭ";
        break;
      case RelativeInterval.aDay:
        isSuffixFeminine = true;
        value = "1 ᠡᠳᠦᠷ";
        break;
      case RelativeInterval.days:
        isSuffixFeminine = true;
        value = "${(duration.inHours / 24).round()} ᠡᠳᠦᠷ";
        break;
      case RelativeInterval.aMonth:
        isSuffixFeminine = false;
        value = "1 ᠰᠠᠷ᠎ᠠ";
        break;
      case RelativeInterval.months:
        isSuffixFeminine = false;
        value = "${(duration.inDays / 30).round()} ᠰᠠᠷ᠎ᠠ";
        break;
      case RelativeInterval.aYear:
        isSuffixFeminine = false;
        value = "1 ᠵᠢᠯ";
        break;
      case RelativeInterval.years:
        isSuffixFeminine = false;
        value = "${(duration.inDays / 365).round()} ᠵᠢᠯ";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (past ? relativePast : relativeFuture)
        .replaceAll(alpha, value + (isSuffixFeminine ? " ᠦᠨ" : " ᠤᠨ"));
  }

  static const Map<int, String> weekdayNames = {
    1: "ᠰᠠᠷᠠᠨ",
    2: "ᠤᠯᠠᠭᠠᠨ",
    3: "ᠥᠯᠡᠮᠵᠢ",
    4: "ᠭᠠᠳᠠᠰᠤ",
    5: "ᠴᠣᠯᠮᠤᠨ",
    6: "ᠬᠡᠰᠢᠭ",
    7: "ᠨᠠᠷᠠᠨ",
  };

  @override
  String weekdayName(int i) => weekdayNames[i]!;

  @override
  String calendar(
    Moment moment, {
    Moment? reference,
    bool weekStartOnSunday = false,
    bool omitHours = false,
    String? customFormat,
  }) {
    reference ??= Moment.now();

    late final String day;

    final int _deltaDays = deltaDays(reference, moment);

    final bool isToday = _deltaDays == 0;

    if (isToday) {
      day = "ᠥᠨᠦᠳᠦᠷ";
    }

    /// Before the `reference`
    else if (moment.isBefore(reference)) {
      final bool isYesterday = _deltaDays == -1;
      final bool isDayBeforeYesterday = _deltaDays == -2;

      if (isYesterday) {
        day = "ᠦᠴᠦᠭᠡᠳᠦᠷ";
      }
      if (isDayBeforeYesterday) {
        day = "ᠤᠷᠵᠢᠳᠤᠷ";
      } else {
        final Moment weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        } else {
          day = "ᠡᠮᠦᠨᠡᠬᠢ ${weekdayName(moment.dateTime.weekday)}";
        }
      }
    } else {
      final bool isTomorrow = _deltaDays == 1;
      final bool isDayAfterTomorrow = _deltaDays == 2;

      if (isTomorrow) {
        day = "ᠮᠠᠷᠭᠠᠰᠢ";
      } else if (isDayAfterTomorrow) {
        day = "ᠨᠥᠭᠦᠭᠡᠳᠦᠷ";
      } else {
        final Moment weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          day = weekdayName(moment.dateTime.weekday);
        } else {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        }
      }
    }

    if (customFormat != null) {
      return day;
    }

    if (omitHours) {
      return day;
    }

    return "$day ${moment.format(localizationDefaultHourFormat)}";
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

  String orderedNumber(int i) {
    return i.toString() +
        (LocalizationMongolianTraditional.isFeminine(i) ? " ᠳᠦᠭᠡᠷ" : " ᠳᠤᠭᠠᠷ");
  }

  String monthName(int i) => "${orderedNumber(i)} ᠰᠠᠷ᠎ᠠ";

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => {
        FormatterToken.M: (DateTime dateTime) => dateTime.month.toString(),
        FormatterToken.Mo: (DateTime dateTime) => orderedNumber(dateTime.month),
        FormatterToken.MM: (DateTime dateTime) =>
            dateTime.month.toString().padLeft(2, '0'),
        FormatterToken.MMM: (DateTime dateTime) => "${dateTime.month} ᠰᠠᠷ᠎ᠠ",
        FormatterToken.MMMM: (DateTime dateTime) => monthName(dateTime.month),
        FormatterToken.Q: (DateTime dateTime) => dateTime.quarter.toString(),
        FormatterToken.Qo: (DateTime dateTime) =>
            orderedNumber(dateTime.quarter),
        FormatterToken.D: (DateTime dateTime) => dateTime.day.toString(),
        FormatterToken.Do: (DateTime dateTime) => orderedNumber(dateTime.day),
        FormatterToken.DD: (DateTime dateTime) =>
            dateTime.day.toString().padLeft(2, '0'),
        FormatterToken.DDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString(),
        FormatterToken.DDDo: (DateTime dateTime) =>
            orderedNumber(dateTime.dayOfYear),
        FormatterToken.DDDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString().padLeft(3, '0'),
        FormatterToken.d: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.d_o: (DateTime dateTime) =>
            orderedNumber(dateTime.weekday),
        FormatterToken.dd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday).substring(0, 2),
        FormatterToken.ddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday).substring(0, 3),
        FormatterToken.dddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday),
        FormatterToken.e: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.w: (DateTime dateTime) => dateTime.week.toString(),
        FormatterToken.wo: (DateTime dateTime) => orderedNumber(dateTime.week),
        FormatterToken.ww: (DateTime dateTime) =>
            dateTime.week.toString().padLeft(2, '0'),
        FormatterToken.YY:
            //TODO: Improve the code before 22nd century
            (DateTime dateTime) {
          if (dateTime.year < 1970 || dateTime.year > 2030) {
            throw Exception("YY formatter only work in range [1970; 2030]");
          }
          return dateTime.year.toString().substring(2);
        },
        FormatterToken.YYYY: (DateTime dateTime) => dateTime.year.toString(),
        FormatterToken.y: null,
        FormatterToken.NN: null,
        FormatterToken.NNNN: null,
        FormatterToken.NNNNN: null,
        FormatterToken.gg: (DateTime dateTime) {
          if (dateTime.year < 1970 || dateTime.year > 2030) {
            throw Exception("YY formatter only work in range [1970; 2030]");
          }
          return dateTime.weekYear.toString().substring(2);
        },
        FormatterToken.gggg: (DateTime dateTime) =>
            dateTime.weekYear.toString(),
        FormatterToken.A: (DateTime dateTime) =>
            dateTime.hour < 12 ? "ᠦᠳᠡ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ" : "ᠦᠳᠡ ᠡᠴᠡ ᠡᠮᠦᠨ᠎ᠡ",
        FormatterToken.a: (DateTime dateTime) =>
            dateTime.hour < 12 ? "ᠦᠳᠡ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ" : "ᠦᠳᠡ ᠡᠴᠡ ᠡᠮᠦᠨ᠎ᠡ",
        FormatterToken.H: (DateTime dateTime) =>
            dateTime.hour == 0 ? "00" : dateTime.hour.toString(),
        FormatterToken.HH: (DateTime dateTime) =>
            dateTime.hour.toString().padLeft(2, "0"),
        FormatterToken.h: (DateTime dateTime) =>
            dateTime.hour == 0 ? "12" : "${dateTime.hour % 12}",
        FormatterToken.hh: (DateTime dateTime) => dateTime.hour == 0
            ? "12"
            : (dateTime.hour % 12).toString().padLeft(2, "0"),
        FormatterToken.k: (DateTime dateTime) =>
            dateTime.hour == 0 ? "24" : dateTime.hour.toString(),
        FormatterToken.kk: (DateTime dateTime) => dateTime.hour == 0
            ? "24"
            : dateTime.hour.toString().padLeft(2, "0"),
        FormatterToken.m: (DateTime dateTime) => dateTime.minute.toString(),
        FormatterToken.mm: (DateTime dateTime) =>
            dateTime.minute.toString().padLeft(2, "0"),
        FormatterToken.s: (DateTime dateTime) => dateTime.second.toString(),
        FormatterToken.ss: (DateTime dateTime) =>
            dateTime.second.toString().padLeft(2, "0"),
        FormatterToken.S: (DateTime dateTime) =>
            (dateTime.millisecond / 100).round().toString().padLeft(2, "0"),
        FormatterToken.SS: (DateTime dateTime) =>
            (dateTime.millisecond / 10).round().toString().padLeft(2, "0"),
        FormatterToken.SSS: (DateTime dateTime) =>
            dateTime.millisecond.toString().padLeft(3, "0"),
        FormatterToken.SSSS: (DateTime dateTime) =>
            (dateTime.microsecond / 100).round().toString().padLeft(3, "0"),
        FormatterToken.SSSSS: (DateTime dateTime) =>
            (dateTime.microsecond / 10).round().toString().padLeft(3, "0"),
        FormatterToken.SSSSSS: (DateTime dateTime) =>
            dateTime.microsecond.toString().padLeft(3, "0"),
        FormatterToken.Z: (DateTime dateTime) => dateTime.timeZoneFormatted(),
        FormatterToken.ZZ: (DateTime dateTime) =>
            dateTime.timeZoneFormatted(false),
        FormatterToken.ZZZ: (DateTime dateTime) => dateTime.timeZoneName,
        FormatterToken.X: (DateTime dateTime) =>
            dateTime.microsecondsSinceEpoch.toString(),
        FormatterToken.x: (DateTime dateTime) =>
            dateTime.millisecondsSinceEpoch.toString(),
        // Localization aware formats
        FormatterToken.L: (DateTime dateTime) =>
            reformat(dateTime, "YYYY/MM/DD"),
        FormatterToken.l: (DateTime dateTime) => reformat(dateTime, "YYYY/M/D"),
        FormatterToken.LL: (DateTime dateTime) =>
            reformat(dateTime, "YYYY ᠣᠨ ᠤ MMMM ᠶᠢᠨ DD"),
        FormatterToken.ll: (DateTime dateTime) =>
            reformat(dateTime, "YYYY ᠣᠨ ᠤ MMM ᠶᠢᠨ D"),
        FormatterToken.LLL: (DateTime dateTime) =>
            reformat(dateTime, "YYYY ᠣᠨ ᠤ MMMM ᠶᠢᠨ DD HH:mm"),
        FormatterToken.lll: (DateTime dateTime) =>
            reformat(dateTime, "YYYY ᠣᠨ ᠤ MMM ᠶᠢᠨ D HH:mm"),
        FormatterToken.LLLL: (DateTime dateTime) =>
            reformat(dateTime, "dddd, YYYY ᠣᠨ ᠤ MMMM ᠶᠢᠨ DD H:mm"),
        FormatterToken.llll: (DateTime dateTime) =>
            reformat(dateTime, "ddd, YYYY ᠣᠨ ᠤ MMM ᠶᠢᠨ D H:mm"),
        FormatterToken.LT: (DateTime dateTime) => reformat(dateTime, "H:mm"),
        FormatterToken.LTS: (DateTime dateTime) =>
            reformat(dateTime, "H:mm:ss"),
      };

  @override
  String endonym() => "ᠮᠣᠩᠭᠤᠯ ᠬᠡᠯᠡ";

  @override
  String languageCodeISO() => "mn";

  @override
  String locale() => "mn";

  @override
  String languageNameInEnglish() => "Mongolian (Traditional Script)";
}
