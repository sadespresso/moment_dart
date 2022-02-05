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
    late final String value;

    RelativeInterval interval = Localization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        value = "хэдэн хоромын";
        break;
      case RelativeInterval.aMinute:
        value = "минутын";
        break;
      case RelativeInterval.minutes:
        value = "${(duration.inSeconds / 60).round()} минутын";
        break;
      case RelativeInterval.anHour:
        value = "цагийн";
        break;
      case RelativeInterval.hours:
        "${(duration.inMinutes / 60).round()} цагийн";
        break;
      case RelativeInterval.aDay:
        value = "өдрийн";
        break;
      case RelativeInterval.days:
        "${(duration.inHours / 24).round()} өдрийн";
        break;
      case RelativeInterval.aMonth:
        value = "сарын";
        break;
      case RelativeInterval.months:
        "${(duration.inDays / 30).round()} сарын";
        break;
      case RelativeInterval.aYear:
        value = "жилийн";
        break;
      case RelativeInterval.years:
        "${(duration.inDays / 365).round()} жилийн";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (duration.isNegative ? relativePast : relativeFuture).replaceAll(alpha, value);
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
  String localizationDefaultDateFormat() => "yyyy/MM/DD";

  @override
  String localizationDefaultHourFormat() => "HH:mm";

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => {};
}
