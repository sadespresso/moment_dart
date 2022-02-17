// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: Cyrillic Mongolian
/// Country: Mongolia
class LocalizationMongolianCyrillic extends Localization {
  LocalizationMongolianCyrillic() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "$alpha өмнө";
  static const String relativeFuture = "$alpha дараа";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;
    late final bool isSuffixMasculine;

    RelativeInterval interval = Localization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        isSuffixMasculine = true;
        value = "хэдэн хором";
        break;
      case RelativeInterval.aMinute:
        isSuffixMasculine = true;
        value = "минут";
        break;
      case RelativeInterval.minutes:
        isSuffixMasculine = true;
        value = "${(duration.inSeconds / 60).round()} минут";
        break;
      case RelativeInterval.anHour:
        isSuffixMasculine = false;
        value = "цаг";
        break;
      case RelativeInterval.hours:
        isSuffixMasculine = false;
        value = "${(duration.inMinutes / 60).round()} цаг";
        break;
      case RelativeInterval.aDay:
        isSuffixMasculine = false;
        value = dropPrefixOrSuffix ? "өдөр" : "өдр"; // Here the letter "ө" will be omitted when
        break;
      case RelativeInterval.days:
        isSuffixMasculine = false;
        value = "${(duration.inHours / 24).round()} " + (dropPrefixOrSuffix ? "өдөр" : "өдр");
        break;
      case RelativeInterval.aMonth:
        isSuffixMasculine = true;
        value = "сар";
        break;
      case RelativeInterval.months:
        isSuffixMasculine = true;
        value = "${(duration.inDays / 30).round()} сар";
        break;
      case RelativeInterval.aYear:
        isSuffixMasculine = false;
        value = "жил";
        break;
      case RelativeInterval.years:
        isSuffixMasculine = false;
        value = "${(duration.inDays / 365).round()} жил";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (past ? relativePast : relativeFuture).replaceAll(alpha, value + (isSuffixMasculine ? "ын" : "ийн"));
  }

  // Tibet weekday names are here, because it is majorly used in Mongolia
  static const Map<int, String> weekdayNames = {
    1: "Даваа",
    2: "Мягмар",
    3: "Лхагва",
    4: "Пүрэв",
    5: "Баасан",
    6: "Бямба",
    7: "Ням",
  };

  @override
  String weekdayName(int i) => weekdayNames[i]!;

  @override
  String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) {
    reference ??= Moment.now();

    late final String day;

    final bool isToday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day == moment.dateTime.day);

    if (isToday) {
      day = "Өнөөдөр";
    }

    /// Before the `reference`
    else if (moment.dateTime.isBefore(reference.dateTime)) {
      final bool isYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 1 == moment.dateTime.day);
      final bool isDayBeforeYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 2 == moment.dateTime.day);
      if (isYesterday) {
        day = "Өчигдөр";
      } else if (isDayBeforeYesterday) {
        day = "Уржигдар";
      } else {
        final Moment startOfLastWeek = Localization.weekFirstDay(reference).subtract(const Duration(days: 7));

        if (moment.isBefore(startOfLastWeek)) {
          day = moment.format(localizationDefaultDateFormat());
        } else {
          day = "Өмнөх ${weekdayName(moment.dateTime.weekday)}";
        }
      }
    } else {
      final bool isTomorrow = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day + 1 == moment.dateTime.day);
      final bool isDayAfterTomorrow = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day + 2 == moment.dateTime.day);
      if (isTomorrow) {
        day = "Маргааш";
      } else if (isDayAfterTomorrow) {
        day = "Нөгөөдөр";
      } else {
        final Moment startOfNextWeek = Localization.weekFirstDay(reference).add(const Duration(days: 7));

        /// If it's this week (relative to the reference)
        if (moment.isBefore(startOfNextWeek)) {
          day = weekdayName(moment.dateTime.weekday);
        } else {
          day = moment.format(localizationDefaultDateFormat());
        }
      }
    }

    if (omitHours) {
      return day;
    }

    return "$day ${moment.format(localizationDefaultHourFormat())}д";
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

    return i.toString() + (feminine ? "дүгээр" : "дугаар");
  }

  String monthName(int i) => "${orderedNumber(i)} сар";

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => {
        FormatterToken.M: (DateTime dateTime) => dateTime.month.toString(),
        FormatterToken.Mo: (DateTime dateTime) => orderedNumber(dateTime.month),
        FormatterToken.MM: (DateTime dateTime) => dateTime.month.toString().padLeft(2, '0'),
        FormatterToken.MMM: (DateTime dateTime) => "${dateTime.month}-р сар",
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
        FormatterToken.A: (DateTime dateTime) => dateTime.hour < 12 ? "Ү.Ө" : "Ү.Х",
        FormatterToken.a: (DateTime dateTime) => dateTime.hour < 12 ? "ү.ө" : "ү.х",
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
