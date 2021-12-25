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
}
