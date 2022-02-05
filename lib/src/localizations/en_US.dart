// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: English (US)
/// Country: United States
class LocalizationEnUs extends Localization {
  LocalizationEnUs() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "$alpha ago";
  static const String relativeFuture = "in $alpha";

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    late final String value;

    RelativeInterval interval = Localization.relativeThreshold(duration);

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
        "${(duration.inMinutes / 60).round()} hours";
        break;
      case RelativeInterval.aDay:
        value = "a day";
        break;
      case RelativeInterval.days:
        "${(duration.inHours / 24).round()} days";
        break;
      case RelativeInterval.aMonth:
        value = "a month";
        break;
      case RelativeInterval.months:
        "${(duration.inDays / 30).round()} months";
        break;
      case RelativeInterval.aYear:
        value = "a year";
        break;
      case RelativeInterval.years:
        "${(duration.inDays / 365).round()} years";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (duration.isNegative ? relativePast : relativeFuture).replaceAll(alpha, value);
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
  String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) {
    reference ??= Moment.now();

    late final String day;

    final bool isToday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day == moment.dateTime.day);

    if (isToday) {
      day = "Today";
    }

    /// Before the `reference`
    else if (moment.dateTime.isBefore(reference.dateTime)) {
      final bool isYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 1 == moment.dateTime.day);

      if (isYesterday) {
        day = "Yesterday";
      } else {
        final Moment startOfLastWeek = Localization.weekFirstDay(reference).subtract(const Duration(days: 7));

        if (moment.isBefore(startOfLastWeek)) {
          day = moment.format(localizationDefaultDateFormat());
        } else {
          day = "Last ${weekdayName(moment.dateTime.weekday)}";
        }
      }
    } else {
      final bool isTomorrow = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day + 1 == moment.dateTime.day);

      if (isTomorrow) {
        day = "Tomorrow";
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

    return "$day at ${moment.format(localizationDefaultHourFormat())}";
  }

  @override
  String localizationDefaultDateFormat() => "MM/DD/yyyy";

  @override
  String localizationDefaultHourFormat() => "hh:mmA";

  String orderedNumber(int n) {
    final int lastDigit = n % 10;
    final int lastTwoDigit = n % 100;

    if (!(lastTwoDigit > 10 && lastTwoDigit < 14)) {
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
        FormatterToken.Mo: (DateTime dateTime) => orderedNumber(dateTime.month),
        FormatterToken.MM: (DateTime dateTime) => dateTime.month.toString().padLeft(2, "0"),
        FormatterToken.MMM: (DateTime dateTime) => monthNames[dateTime.month]!.substring(0, 3),
        FormatterToken.MMMM: (DateTime dateTime) => monthNames[dateTime.month]!,
        FormatterToken.Q: (DateTime dateTime) => dateTime.quarter.toString(),
        FormatterToken.Qo: (DateTime dateTime) => orderedNumber(dateTime.quarter),
        FormatterToken.D: (DateTime dateTime) => dateTime.day.toString(),
        FormatterToken.Do: (DateTime dateTime) => orderedNumber(dateTime.day),
        FormatterToken.DD: (DateTime dateTime) => dateTime.day.toString().padLeft(2, "0"),
        FormatterToken.DDD: (DateTime dateTime) => dateTime.dayOfYear.toString(),
        FormatterToken.DDDo: (DateTime dateTime) => orderedNumber(dateTime.dayOfYear),
        FormatterToken.DDDD: (DateTime dateTime) => dateTime.dayOfYear.toString().padLeft(3, "0"),
        FormatterToken.d: (DateTime dateTime) => dateTime.weekday.toString(),
        FormatterToken.d_o: (DateTime dateTime) => orderedNumber(dateTime.weekday),
        FormatterToken.dd: (DateTime dateTime) => weekdayName(dateTime.weekday).substring(0, 2),
        FormatterToken.ddd: (DateTime dateTime) => weekdayName(dateTime.weekday).substring(0, 3),
        FormatterToken.dddd: (DateTime dateTime) => weekdayName(dateTime.weekday),
        FormatterToken.e: null,
        FormatterToken.E: null,
        FormatterToken.w: null,
        FormatterToken.wo: null,
        FormatterToken.ww: null,
        FormatterToken.W: null,
        FormatterToken.Wo: null,
        FormatterToken.WW: null,
        FormatterToken.YY:
            //TODO: Improve the code before 22nd century
            (DateTime dateTime) => dateTime.year.toString().substring(2),
        FormatterToken.YYYY: (DateTime dateTime) => dateTime.year.toString(),
        FormatterToken.YYYYYY: null,
        FormatterToken.Y: null,
        FormatterToken.y: null,
        FormatterToken.NN: null,
        FormatterToken.NNNN: null,
        FormatterToken.NNNNN: null,
        FormatterToken.gg: null,
        FormatterToken.gggg: null,
        FormatterToken.GG: null,
        FormatterToken.GGGG: null,
        FormatterToken.A: (DateTime dateTime) => dateTime.hour < 12 ? "AM" : "PM",
        FormatterToken.a: (DateTime dateTime) => dateTime.hour < 12 ? "am" : "pm",
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
