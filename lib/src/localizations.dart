import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/moment.dart';

enum RelativeInterval {
  //"(in) a few seconds (ago)"
  fewSeconds,
  //"(in) a minute (ago)"
  aMinute,
  //"(in) X minutes (ago)"
  minutes,
  //"(in) an hour (ago)"
  anHour,
  //"(in) X hours (ago)"
  hours,
  //"(in) a day (ago)"
  aDay,
  //"(in) X days (ago)"
  days,
  //"(in) a month (ago)"
  aMonth,
  //"(in) X months (ago)"
  months,
  //"(in) a year (ago)"
  aYear,
  //"(in) X years (ago)"
  years,
}

/// Extend this class to create new localization
abstract class Localization {
  Localization();

  static const int maxInt = (double.infinity is int) ? double.infinity as int : ~minInt;
  static const int minInt = (double.infinity is int) ? -double.infinity as int : (-1 << 63);

  /// Defined intervals' upper-limit has been stored as <String,Duration?> map. Null [Duration] value indicates last possible case.
  ///
  /// Used this table as guide:
  /// [https://momentjs.com/docs/#/displaying/fromnow/]
  static const Map<RelativeInterval, Duration?> _relativeThresholds = {
    RelativeInterval.fewSeconds: Duration(seconds: 45),
    RelativeInterval.aMinute: Duration(seconds: 90),
    RelativeInterval.minutes: Duration(minutes: 45),
    RelativeInterval.anHour: Duration(minutes: 90),
    RelativeInterval.hours: Duration(hours: 22),
    RelativeInterval.aDay: Duration(hours: 36),
    RelativeInterval.days: Duration(days: 26),
    RelativeInterval.aMonth: Duration(days: 45),
    RelativeInterval.months: Duration(days: 320),
    RelativeInterval.aYear: Duration(days: 548),
    RelativeInterval.years: null,
  };

  /// Uses [Localization._relativeThresholds] map. Refer to this table for details:
  /// [https://momentjs.com/docs/#/displaying/fromnow/]
  static RelativeInterval relativeThreshold(Duration _duration) {
    final Duration duration = _duration.abs();

    for (RelativeInterval key in _relativeThresholds.keys) {
      final Duration? maxDuration = _relativeThresholds[key];

      if (maxDuration == null) return key;

      if (duration < maxDuration) {
        return key;
      }
    }

    throw Exception("Something went wrong");
  }

  /// Please take a look at [Localization.relativeThreshold] function and [Localization._relativeThresholds] before implementing. Those will make your life slightly easier
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]);
  String calendar(Moment moment, {Moment? reference, bool weekStartOnSunday = false, bool omitHours = false});

  String weekdayName(int i);

  String localizationDefaultDateFormat();
  String localizationDefaultHourFormat();

  Map<FormatterToken, FormatterTokenFn?> formats();

  static Moment weekFirstDay(Moment reference, [bool weekStartOnSunday = false]) {
    return Moment(weekStartOnSunday ? reference.lastSunday() : reference.lastMonday());
  }

  final List<FormatterToken> tokens = [...FormatterToken.values]..sort((a, b) => b.toString().length.compareTo(a.toString().length));
}
