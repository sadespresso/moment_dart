// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: English (US)
/// Country: United States
class LocalizationEnUs extends MomentLocalization {
  LocalizationEnUs() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "$alpha ago";
  static const String relativeFuture = "in $alpha";

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    final bool past = duration.isNegative;

    duration = duration.abs();

    late final String value;

    RelativeInterval interval = MomentLocalization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        value = "a few seconds";
        break;
      case RelativeInterval.aMinute:
        value = "a minute";
        break;
      case RelativeInterval.minutes:
        value = "${(duration.inSeconds / 60).round()} minutes";
        break;
      case RelativeInterval.anHour:
        value = "an hour";
        break;
      case RelativeInterval.hours:
        value = "${(duration.inMinutes / 60).round()} hours";
        break;
      case RelativeInterval.aDay:
        value = "a day";
        break;
      case RelativeInterval.days:
        value = "${(duration.inHours / 24).round()} days";
        break;
      case RelativeInterval.aMonth:
        value = "a month";
        break;
      case RelativeInterval.months:
        value = "${(duration.inDays / 30).round()} months";
        break;
      case RelativeInterval.aYear:
        value = "a year";
        break;
      case RelativeInterval.years:
        value = "${(duration.inDays / 365).round()} years";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (past ? relativePast : relativeFuture).replaceAll(alpha, value);
  }

  static const Map<int, String> weekdayNames = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday",
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
      day = "Today";
    }

    /// Before the `reference`
    else if (moment.isBefore(reference)) {
      final bool isYesterday = _deltaDays == -1;

      if (isYesterday) {
        day = "Yesterday";
      } else {
        final Moment weekBefore = reference.subtract(const Duration(days: 7));

        if (moment.isBefore(weekBefore)) {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        } else {
          day = "Last ${weekdayName(moment.weekday)}";
        }
      }
    } else {
      final bool isTomorrow = _deltaDays == 1;

      if (isTomorrow) {
        day = "Tomorrow";
      } else {
        final Moment weekAfter = reference.add(const Duration(days: 7));

        /// If it's this or next week (relative to the reference)
        if (moment.isBefore(weekAfter)) {
          day = weekdayName(moment.weekday);
        } else {
          day = moment.format(customFormat ?? localizationDefaultDateFormat);
        }
      }
    }

    if (customFormat != null) return day;

    if (omitHours) {
      return day;
    }

    return "$day at ${moment.format(localizationDefaultHourFormat)}";
  }

  String ordinalNumber(int n) {
    final int lastTwoDigit = n % 100;

    if (!(lastTwoDigit > 10 && lastTwoDigit < 14)) {
      final int lastDigit = n % 10;

      switch (lastDigit) {
        case 1:
          return "${n}st";
        case 2:
          return "${n}nd";
        case 3:
          return "${n}rd";
        default:
          break;
      }
    }

    return "${n}th";
  }

  static const Map<int, String> monthNames = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  @override
  Map<FormatterToken, String Function(DateTime)?> formats() => {
        FormatterToken.M: (DateTime dateTime) => dateTime.month.toString(),
        FormatterToken.Mo: (DateTime dateTime) => ordinalNumber(dateTime.month),
        FormatterToken.MM: (DateTime dateTime) =>
            dateTime.month.toString().padLeft(2, '0'),
        FormatterToken.MMM: (DateTime dateTime) =>
            monthNames[dateTime.month]!.substring(0, 3),
        FormatterToken.MMMM: (DateTime dateTime) => monthNames[dateTime.month]!,
        FormatterToken.Q: (DateTime dateTime) => dateTime.quarter.toString(),
        FormatterToken.Qo: (DateTime dateTime) =>
            ordinalNumber(dateTime.quarter),
        FormatterToken.D: (DateTime dateTime) => dateTime.day.toString(),
        FormatterToken.Do: (DateTime dateTime) => ordinalNumber(dateTime.day),
        FormatterToken.DD: (DateTime dateTime) =>
            dateTime.day.toString().padLeft(2, '0'),
        FormatterToken.DDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString(),
        FormatterToken.DDDo: (DateTime dateTime) =>
            ordinalNumber(dateTime.dayOfYear),
        FormatterToken.DDDD: (DateTime dateTime) =>
            dateTime.dayOfYear.toString().padLeft(3, '0'),
        FormatterToken.d: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.d_o: (DateTime dateTime) =>
            ordinalNumber(dateTime.weekday),
        FormatterToken.dd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday).substring(0, 2),
        FormatterToken.ddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday).substring(0, 3),
        FormatterToken.dddd: (DateTime dateTime) =>
            weekdayName(dateTime.weekday),
        FormatterToken.e: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.w: (DateTime dateTime) => dateTime.week.toString(),
        FormatterToken.wo: (DateTime dateTime) => ordinalNumber(dateTime.week),
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
            dateTime.hour < 12 ? "AM" : "PM",
        FormatterToken.a: (DateTime dateTime) =>
            dateTime.hour < 12 ? "am" : "pm",
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
            reformat(dateTime, "MM/DD/YYYY"),
        FormatterToken.l: (DateTime dateTime) => reformat(dateTime, "M/D/YYYY"),
        FormatterToken.LL: (DateTime dateTime) =>
            reformat(dateTime, "MMMM DD YYYY"),
        FormatterToken.ll: (DateTime dateTime) =>
            reformat(dateTime, "MMM D YYYY"),
        FormatterToken.LLL: (DateTime dateTime) =>
            reformat(dateTime, "MMMM DD YYYY hh:mm A"),
        FormatterToken.lll: (DateTime dateTime) =>
            reformat(dateTime, "MMM D YYYY h:mm A"),
        FormatterToken.LLLL: (DateTime dateTime) =>
            reformat(dateTime, "dddd, MMMM DD YYYY hh:mm A"),
        FormatterToken.llll: (DateTime dateTime) =>
            reformat(dateTime, "ddd, MMM D YYYY h:mm A"),
        FormatterToken.LT: (DateTime dateTime) => reformat(dateTime, "h:mm A"),
        FormatterToken.LTS: (DateTime dateTime) =>
            reformat(dateTime, "h:mm:ss A"),
      };

  @override
  String endonym() => "English";

  @override
  String languageCodeISO() => "en";

  @override
  String locale() => "en_US";

  @override
  String languageNameInEnglish() => "English (United States)";
}
