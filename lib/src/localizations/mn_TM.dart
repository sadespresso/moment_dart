// ignore_for_file: file_names

import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: Traditional Mongolian (Unicode)
/// Country: Mongolia
class LocalizationMongolianTraditional extends Localization {
  LocalizationMongolianTraditional() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "$alpha ᠡᠮᠦᠨ᠎ᠡ";
  static const String relativeFuture = "$alpha ᠳᠠᠷᠠᠭ᠎ᠠ";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    late final String value;
    bool isSuffixFeminine = false;

    RelativeInterval interval = Localization.relativeThreshold(duration);

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

    return (duration.isNegative ? relativePast : relativeFuture).replaceAll(alpha, value + (isSuffixFeminine ? " ᠦᠨ" : " ᠤᠨ"));
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
  String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false}) {
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
        final Moment startOfLastWeek = Localization.weekFirstDay(reference).subtract(const Duration(days: 7));

        if (moment.isBefore(startOfLastWeek)) {
          day = moment.format(localizationDefaultDateFormat());
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

    return "$day ${moment.format(localizationDefaultHourFormat())}";
  }

  @override
  String localizationDefaultDateFormat() => "yyyy/MM/DD";

  @override
  String localizationDefaultHourFormat() => "HH:mm";

  @override
  Map<FormatterToken, FormatterTokenFn?> formats() => {};
}
