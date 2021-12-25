import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: English (US)
/// Country: United States
class LocalizationEnUs extends Localization {
  const LocalizationEnUs() : super();

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
  String format(DateTime dateTime, FormatterToken formatterToken, Localization localization) {
    switch (formatterToken) {
      case FormatterToken.M:
        return dateTime.month.toString();
      case FormatterToken.Mo:
        return orderedNumber(dateTime.month);
      case FormatterToken.MM:
        return dateTime.month.toString().padLeft(2, "0");
      case FormatterToken.MMM:
        return monthNames[dateTime.month]!.substring(0, 3);
      case FormatterToken.MMMM:
        return monthNames[dateTime.month]!;
      case FormatterToken.Q:
        // TODO: Handle this case.
        break;
      case FormatterToken.Qo:
        // TODO: Handle this case.
        break;
      case FormatterToken.D:
        return dateTime.day.toString();
      case FormatterToken.Do:
        return orderedNumber(dateTime.day);
      case FormatterToken.DD:
        return dateTime.day.toString().padLeft(2, "0");
      case FormatterToken.DDD:
        // TODO: Handle this case.
        break;
      case FormatterToken.DDDo:
        // TODO: Handle this case.
        break;
      case FormatterToken.DDDD:
        // TODO: Handle this case.
        break;
      case FormatterToken.d:
        return dateTime.weekday.toString();
      case FormatterToken.d_o:
        return orderedNumber(dateTime.weekday);
      case FormatterToken.dd:
        return weekdayName(dateTime.weekday).substring(0, 2);
      case FormatterToken.ddd:
        return weekdayName(dateTime.weekday).substring(0, 3);
      case FormatterToken.dddd:
        return weekdayName(dateTime.weekday);
      case FormatterToken.e:
        // TODO: Handle this case.
        break;
      case FormatterToken.E:
        // TODO: Handle this case.
        break;
      case FormatterToken.w:
        // TODO: Handle this case.
        break;
      case FormatterToken.wo:
        // TODO: Handle this case.
        break;
      case FormatterToken.ww:
        // TODO: Handle this case.
        break;
      case FormatterToken.W:
        // TODO: Handle this case.
        break;
      case FormatterToken.Wo:
        // TODO: Handle this case.
        break;
      case FormatterToken.WW:
        // TODO: Handle this case.
        break;
      case FormatterToken.YY:
        //TODO: Improve the code before 22nd century
        return dateTime.year.toString().substring(2);
      case FormatterToken.YYYY:
        return dateTime.year.toString();
      case FormatterToken.YYYYYY:
        // TODO: Handle this case.
        break;
      case FormatterToken.Y:
        // TODO: Handle this case.
        break;
      case FormatterToken.y:
        // TODO: Handle this case.
        break;
      case FormatterToken.NN:
        // TODO: Handle this case.
        break;
      case FormatterToken.NNNN:
        // TODO: Handle this case.
        break;
      case FormatterToken.NNNNN:
        // TODO: Handle this case.
        break;
      case FormatterToken.gg:
        // TODO: Handle this case.
        break;
      case FormatterToken.gggg:
        // TODO: Handle this case.
        break;
      case FormatterToken.GG:
        // TODO: Handle this case.
        break;
      case FormatterToken.GGGG:
        // TODO: Handle this case.
        break;
      case FormatterToken.A:
        return dateTime.hour < 12 ? "AM" : "PM";
      case FormatterToken.a:
        return dateTime.hour < 12 ? "am" : "pm";
      case FormatterToken.H:
        return dateTime.hour.toString();
      case FormatterToken.HH:
        return dateTime.hour.toString().padLeft(2, "0");

      case FormatterToken.h:
        final int _h = dateTime.hour % 12;
        return _h == 0 ? "12" : _h.toString();
      case FormatterToken.hh:
        final int _h = dateTime.hour % 12;
        return _h == 0 ? "12" : _h.toString().padLeft(2, "0");
      case FormatterToken.k:
        return dateTime.hour == 0 ? "24" : dateTime.hour.toString();
      case FormatterToken.kk:
        return dateTime.hour == 0 ? "24" : dateTime.hour.toString().padLeft(2, "0");
      case FormatterToken.m:
        return dateTime.minute.toString();
      case FormatterToken.mm:
        return dateTime.minute.toString().padLeft(2, "0");
      case FormatterToken.s:
        return dateTime.second.toString();
      case FormatterToken.ss:
        return dateTime.second.toString().padLeft(2, "0");
      case FormatterToken.S:
        return (dateTime.millisecond / 100).round().toString().padLeft(2, "0");
      case FormatterToken.SS:
        return (dateTime.millisecond / 10).round().toString().padLeft(2, "0");
      case FormatterToken.SSS:
        return dateTime.millisecond.toString().padLeft(3, "0");
      case FormatterToken.SSSS:
        // TODO: Handle this case.
        break;
      case FormatterToken.Z:
        // TODO: Handle this case.
        break;
      case FormatterToken.ZZ:
        // TODO: Handle this case.
        break;
      case FormatterToken.X:
        return dateTime.microsecondsSinceEpoch.toString();
      case FormatterToken.x:
        return dateTime.millisecondsSinceEpoch.toString();
    }

    throw Exception("Something went wrong");
  }
}
