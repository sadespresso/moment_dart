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

  static const String relativePast = "$alpha ᠡᠮᠦᠨ᠎ᠡ";
  static const String relativeFuture = "$alpha ᠳᠠᠷᠠᠭ᠎ᠠ";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;
    bool isSuffixFeminine = false;

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        value = "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ";
        break;
      case RelativeInterval.aMinute:
        value = "ᠮᠢᠨᠦ᠋ᠲ᠋";
        break;
      case RelativeInterval.minutes:
        value = "${(duration.inSeconds / 60).round()} ᠮᠢᠨᠦ᠋ᠲ᠋";
        break;
      case RelativeInterval.anHour:
        value = "ᠴᠠᠭ ᠤᠨ";
        break;
      case RelativeInterval.hours:
        value = "${(duration.inMinutes / 60).round()} ᠴᠠᠭ";
        break;
      case RelativeInterval.aDay:
        isSuffixFeminine = true;
        value = "ᠡᠳᠦᠷ ᠦᠨ";
        break;
      case RelativeInterval.days:
        isSuffixFeminine = true;
        value = "${(duration.inHours / 24).round()} ᠡᠳᠦᠷ";
        break;
      case RelativeInterval.aMonth:
        value = "ᠰᠠᠷ᠎ᠠ ᠤᠨ";
        break;
      case RelativeInterval.months:
        value = "${(duration.inDays / 30).round()} ᠰᠠᠷ᠎ᠠ";
        break;
      case RelativeInterval.aYear:
        isSuffixFeminine = true;
        value = "ᠵᠢᠯ";
        break;
      case RelativeInterval.years:
        isSuffixFeminine = true;
        value = "${(duration.inDays / 365).round()} ᠵᠢᠯ";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (past ? relativePast : relativeFuture).replaceAll(alpha, value + (isSuffixFeminine ? " ᠦᠨ" : " ᠤᠨ"));
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
  String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false, String? customFormat}) {
    reference ??= Moment.now();

    late final String day;

    final bool isToday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day == moment.dateTime.day);

    if (isToday) {
      day = "ᠥᠨᠦᠳᠦᠷ";
    }

    /// Before the `reference`
    else if (moment.dateTime.isBefore(reference.dateTime)) {
      final bool isYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 1 == moment.dateTime.day);
      final bool isDayBeforeYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 2 == moment.dateTime.day);

      if (isYesterday) {
        day = "ᠦᠴᠦᠭᠡᠳᠦᠷ";
      }
      if (isDayBeforeYesterday) {
        day = "ᠤᠷᠵᠢᠳᠤᠷ";
      } else {
        final Moment startOfLastWeek = MomentLocalization.weekFirstDay(reference).subtract(const Duration(days: 7));

        if (moment.isBefore(startOfLastWeek)) {
          day = moment.format(customFormat ?? localizationDefaultDateFormat());
        } else {
          day = "ᠡᠮᠦᠨᠡᠬᠢ ${weekdayName(moment.dateTime.weekday)}";
        }
      }
    } else {
      final bool isTomorrow = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day + 1 == moment.dateTime.day);
      final bool isDayAfterTomorrow = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day + 2 == moment.dateTime.day);

      if (isTomorrow) {
        day = "ᠮᠠᠷᠭᠠᠰᠢ";
      } else if (isDayAfterTomorrow) {
        day = "ᠨᠥᠭᠦᠭᠡᠳᠦᠷ";
      } else {
        final Moment startOfNextWeek = MomentLocalization.weekFirstDay(reference).add(const Duration(days: 7));

        /// If it's this week (relative to the reference)
        if (moment.isBefore(startOfNextWeek)) {
          day = weekdayName(moment.dateTime.weekday);
        } else {
          day = moment.format(customFormat ?? localizationDefaultDateFormat());
        }
      }
    }

    if (customFormat != null) {
      return day;
    }

    if (omitHours) {
      return day;
    }

    return "$day ${moment.format(localizationDefaultHourFormat())}";
  }

  @override
  String localizationDefaultDateFormat() => "YYYY/MM/DD";

  @override
  String localizationDefaultHourFormat() => "HH:mm";

  String orderedNumber(int i) {
    int moduloTen = i % 10;

    if (moduloTen == 0) {
      moduloTen = i - moduloTen;
      moduloTen ~/= 10;
      moduloTen %= 10;
    }

    const List<int> feminineUnits = [0, 1, 4, 9];

    final bool feminine = feminineUnits.contains(i);

    return i.toString() + (feminine ? " ᠳᠦᠭᠡᠷ" : " ᠳᠤᠭᠠᠷ");
  }

  String monthName(int i) => "${orderedNumber(i)} ᠰᠠᠷ᠎ᠠ";

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => {
        FormatterToken.M: (DateTime dateTime) => dateTime.month.toString(),
        FormatterToken.Mo: (DateTime dateTime) => orderedNumber(dateTime.month),
        FormatterToken.MM: (DateTime dateTime) => dateTime.month.toString().padLeft(2, '0'),
        FormatterToken.MMM: (DateTime dateTime) => "${dateTime.month} ᠰᠠᠷ᠎ᠠ",
        FormatterToken.MMMM: (DateTime dateTime) => monthName(dateTime.month),
        FormatterToken.Q: (DateTime dateTime) => dateTime.quarter.toString(),
        FormatterToken.Qo: (DateTime dateTime) => orderedNumber(dateTime.quarter),
        FormatterToken.D: (DateTime dateTime) => dateTime.day.toString(),
        FormatterToken.Do: (DateTime dateTime) => orderedNumber(dateTime.day),
        FormatterToken.DD: (DateTime dateTime) => dateTime.day.toString().padLeft(2, '0'),
        FormatterToken.DDD: (DateTime dateTime) => dateTime.dayOfYear.toString(),
        FormatterToken.DDDo: (DateTime dateTime) => orderedNumber(dateTime.dayOfYear),
        FormatterToken.DDDD: (DateTime dateTime) => dateTime.dayOfYear.toString().padLeft(3, '0'),
        FormatterToken.d: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.d_o: (DateTime dateTime) => orderedNumber(dateTime.weekday),
        FormatterToken.dd: (DateTime dateTime) => weekdayName(dateTime.weekday).substring(0, 2),
        FormatterToken.ddd: (DateTime dateTime) => weekdayName(dateTime.weekday).substring(0, 3),
        FormatterToken.dddd: (DateTime dateTime) => weekdayName(dateTime.weekday),
        FormatterToken.e: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.w: (DateTime dateTime) => dateTime.week.toString(),
        FormatterToken.wo: (DateTime dateTime) => orderedNumber(dateTime.week),
        FormatterToken.ww: (DateTime dateTime) => dateTime.week.toString().padLeft(2, '0'),
        FormatterToken.YY:
            //TODO: Improve the code before 22nd century
            (DateTime dateTime) {
          if (dateTime.year < 1970) throw Exception("YY formatter doesn't work for years before 1970");
          if (dateTime.year > 2030) throw Exception("YY formatter doesn't work for years after 2030");
          return dateTime.year.toString().substring(2);
        },
        FormatterToken.YYYY: (DateTime dateTime) => dateTime.year.toString(),
        FormatterToken.YYYYYY: (DateTime dateTime) => dateTime.year.toString(),
        FormatterToken.Y: (DateTime dateTime) => dateTime.year.toString(),
        FormatterToken.y: null,
        FormatterToken.NN: null,
        FormatterToken.NNNN: null,
        FormatterToken.NNNNN: null,
        FormatterToken.gg: (DateTime dateTime) {
          if (dateTime.year < 1970) throw Exception("YY formatter doesn't work for years before 1970");
          if (dateTime.year > 2030) throw Exception("YY formatter doesn't work for years after 2030");
          return dateTime.weekYear.toString().substring(2);
        },
        FormatterToken.gggg: (DateTime dateTime) => dateTime.weekYear.toString(),
        FormatterToken.A: (DateTime dateTime) => dateTime.hour < 12 ? "ᠦᠳᠡ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ" : "ᠦᠳᠡ ᠡᠴᠡ ᠡᠮᠦᠨ᠎ᠡ",
        FormatterToken.a: (DateTime dateTime) => dateTime.hour < 12 ? "ᠦᠳᠡ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ" : "ᠦᠳᠡ ᠡᠴᠡ ᠡᠮᠦᠨ᠎ᠡ",
        FormatterToken.H: (DateTime dateTime) => dateTime.hour.toString(),
        FormatterToken.HH: (DateTime dateTime) => dateTime.hour.toString().padLeft(2, "0"),
        FormatterToken.h: (DateTime dateTime) {
          final int _h = dateTime.hour % 12;
          return _h == 0 ? "12" : _h.toString();
        },
        FormatterToken.hh: (DateTime dateTime) {
          final int _h = dateTime.hour % 12;
          return _h == 0 ? "12" : _h.toString().padLeft(2, "0");
        },
        FormatterToken.k: (DateTime dateTime) => dateTime.hour == 0 ? "24" : dateTime.hour.toString(),
        FormatterToken.kk: (DateTime dateTime) => dateTime.hour == 0 ? "24" : dateTime.hour.toString().padLeft(2, "0"),
        FormatterToken.m: (DateTime dateTime) => dateTime.minute.toString(),
        FormatterToken.mm: (DateTime dateTime) => dateTime.minute.toString().padLeft(2, "0"),
        FormatterToken.s: (DateTime dateTime) => dateTime.second.toString(),
        FormatterToken.ss: (DateTime dateTime) => dateTime.second.toString().padLeft(2, "0"),
        FormatterToken.S: (DateTime dateTime) => (dateTime.millisecond / 100).round().toString().padLeft(2, "0"),
        FormatterToken.SS: (DateTime dateTime) => (dateTime.millisecond / 10).round().toString().padLeft(2, "0"),
        FormatterToken.SSS: (DateTime dateTime) => dateTime.millisecond.toString().padLeft(3, "0"),
        FormatterToken.SSSS: (DateTime dateTime) => (dateTime.microsecond / 100).round().toString().padLeft(3, "0"),
        FormatterToken.SSSSS: (DateTime dateTime) => (dateTime.microsecond / 10).round().toString().padLeft(3, "0"),
        FormatterToken.SSSSSS: (DateTime dateTime) => dateTime.microsecond.toString().padLeft(3, "0"),
        FormatterToken.Z: (DateTime dateTime) => dateTime.timeZoneFormatted(),
        FormatterToken.ZZ: (DateTime dateTime) => dateTime.timeZoneFormatted(false),
        FormatterToken.ZZZ: (DateTime dateTime) => dateTime.timeZoneName,
        FormatterToken.X: (DateTime dateTime) => dateTime.microsecondsSinceEpoch.toString(),
        FormatterToken.x: (DateTime dateTime) => dateTime.millisecondsSinceEpoch.toString(),
      };
}
