import 'package:moment_dart/src/formatters/token.dart';

import '../localizations.dart';
import 'package:moment_dart/src/moment.dart';

/// Language: Traditional Mongolian (Unicode)
/// Country: Mongolia
class LocalizationMongolianTraditional extends Localization {
  const LocalizationMongolianTraditional() : super();

  /// Used as placeholder in replacable texts. E.g. `relativePast`
  static const String alpha = "%";

  static const String relativePast = "$alpha ᠡᠮᠦᠨ᠎ᠡ";
  static const String relativeFuture = "$alpha ᠳᠠᠷᠠᠭ᠎ᠠ";

  /// Please note that Mongolian language string is not in it's base form. A suffix has been added to work with `relativePast`, `relativeFuture`.
  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) {
    late final String value;

    RelativeInterval interval = Localization.relativeThreshold(duration);

    switch (interval) {
      case RelativeInterval.fewSeconds:
        value = "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ ᠤᠨ";
        break;
      case RelativeInterval.aMinute:
        value = "ᠮᠢᠨᠦ᠋ᠲ᠋ ᠤᠨ";
        break;
      case RelativeInterval.minutes:
        value = "${(duration.inSeconds / 60).round()} ᠮᠢᠨᠦ᠋ᠲ᠋ ᠤᠨ";
        break;
      case RelativeInterval.anHour:
        value = "ᠴᠠᠭ ᠤᠨ";
        break;
      case RelativeInterval.hours:
        "${(duration.inMinutes / 60).round()} ᠴᠠᠭ ᠤᠨ";
        break;
      case RelativeInterval.aDay:
        value = "ᠡᠳᠦᠷ ᠦᠨ";
        break;
      case RelativeInterval.days:
        "${(duration.inHours / 24).round()} ᠡᠳᠦᠷ ᠦᠨ";
        break;
      case RelativeInterval.aMonth:
        value = "ᠰᠠᠷ᠎ᠠ ᠤᠨ";
        break;
      case RelativeInterval.months:
        "${(duration.inDays / 30).round()} ᠰᠠᠷ᠎ᠠ ᠤᠨ";
        break;
      case RelativeInterval.aYear:
        value = "ᠵᠢᠯ ᠤᠨ";
        break;
      case RelativeInterval.years:
        "${(duration.inDays / 365).round()} ᠵᠢᠯ ᠤᠨ";
        break;
    }

    if (dropPrefixOrSuffix) return value;

    return (duration.isNegative ? relativePast : relativeFuture).replaceAll(alpha, value);
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
      day = "ᠦᠨᠦᠳᠦᠷ";
    }

    /// Before the `reference`
    else if (moment.dateTime.isBefore(reference.dateTime)) {
      final bool isYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 1 == moment.dateTime.day);
      final bool isDayBeforeYesterday = (reference.dateTime.year == moment.dateTime.year && reference.dateTime.month == moment.dateTime.month && reference.dateTime.day - 2 == moment.dateTime.day);

      if (isYesterday) {
        day = "ᠦᠴᠦᠭᠡᠳᠦᠷ";
      }
      if (isDayBeforeYesterday) {
        day = "ᠤᠷᠵᠢᠳᠠᠷ";
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
  String format(DateTime dateTime, FormatterToken formatterToken, Localization localization) {
    switch (formatterToken) {
      case FormatterToken.M:
        // TODO: Handle this case.
        break;
      case FormatterToken.Mo:
        // TODO: Handle this case.
        break;
      case FormatterToken.MM:
        // TODO: Handle this case.
        break;
      case FormatterToken.MMM:
        // TODO: Handle this case.
        break;
      case FormatterToken.MMMM:
        // TODO: Handle this case.
        break;
      case FormatterToken.Q:
        // TODO: Handle this case.
        break;
      case FormatterToken.Qo:
        // TODO: Handle this case.
        break;
      case FormatterToken.D:
        // TODO: Handle this case.
        break;
      case FormatterToken.Do:
        // TODO: Handle this case.
        break;
      case FormatterToken.DD:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case FormatterToken.d_o:
        // TODO: Handle this case.
        break;
      case FormatterToken.dd:
        // TODO: Handle this case.
        break;
      case FormatterToken.ddd:
        // TODO: Handle this case.
        break;
      case FormatterToken.dddd:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case FormatterToken.YYYY:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case FormatterToken.a:
        // TODO: Handle this case.
        break;
      case FormatterToken.H:
        // TODO: Handle this case.
        break;
      case FormatterToken.HH:
        // TODO: Handle this case.
        break;
      case FormatterToken.h:
        // TODO: Handle this case.
        break;
      case FormatterToken.hh:
        // TODO: Handle this case.
        break;
      case FormatterToken.k:
        // TODO: Handle this case.
        break;
      case FormatterToken.kk:
        // TODO: Handle this case.
        break;
      case FormatterToken.m:
        // TODO: Handle this case.
        break;
      case FormatterToken.mm:
        // TODO: Handle this case.
        break;
      case FormatterToken.s:
        // TODO: Handle this case.
        break;
      case FormatterToken.ss:
        // TODO: Handle this case.
        break;
      case FormatterToken.S:
        // TODO: Handle this case.
        break;
      case FormatterToken.SS:
        // TODO: Handle this case.
        break;
      case FormatterToken.SSS:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case FormatterToken.x:
        // TODO: Handle this case.
        break;
    }

    throw Exception("Something went wrong");
  }
}
