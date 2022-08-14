import 'package:moment_dart/src/extension.dart';

/// Does not take account for timezone
enum DurationUnit {
  /// A microsecond equals a millionth of a second.
  ///
  /// Smallest unit we have in [Duration]
  microsecond(0, 1),

  /// A second equals [Duration.microsecondsPerMillisecond] microseconds
  millisecond(1, Duration.microsecondsPerMillisecond),

  /// A second equals [Duration.millisecondsPerSecond] milliseconds
  second(2, Duration.microsecondsPerSecond),

  /// An hour equals [Duration.secondsPerMinute] minutes
  ///
  /// No leap seconds
  minute(3, Duration.microsecondsPerMinute),

  /// An hour equals [Duration.minutesPerHour] minutes
  hour(4, Duration.microsecondsPerHour),

  /// A day equals [Duration.hoursPerDay] hours
  ///
  /// Timezone is NOT taken into account
  day(5, Duration.microsecondsPerDay),

  /// A week equals [DurationExtra.daysPerWeek] days
  ///
  /// Timezone is NOT taken into account
  week(6, DurationExtra.daysPerWeek * Duration.microsecondsPerDay),

  /// A month equals [DurationExtra.daysPerMonth] days
  ///
  /// Timezone is NOT taken into account
  month(7, DurationExtra.daysPerMonth * Duration.microsecondsPerDay),

  /// A year equals [DurationExtra.daysPerYear] days
  ///
  /// Timezone is NOT taken into account
  year(8, DurationExtra.daysPerYear * Duration.microsecondsPerDay);

  final int value;
  final int microseconds;

  const DurationUnit(this.value, this.microseconds);

  /// Returns **rounded** unit in specified [unit]
  static int relativeDuration(Duration duration, DurationUnit unit) {
    switch (unit) {
      case DurationUnit.microsecond:
        return duration.inMicroseconds;
      case DurationUnit.millisecond:
        return (duration.inMicroseconds / Duration.microsecondsPerMillisecond)
            .round();
      case DurationUnit.second:
        return (duration.inMilliseconds / Duration.millisecondsPerSecond)
            .round();
      case DurationUnit.minute:
        return (duration.inSeconds / Duration.secondsPerMinute).round();
      case DurationUnit.hour:
        return (duration.inMinutes / Duration.minutesPerHour).round();
      case DurationUnit.day:
        return (duration.inHours / Duration.hoursPerDay).round();
      case DurationUnit.week:
        return (duration.inHours / Duration.hoursPerDay / 7).round();
      case DurationUnit.month:
        return (duration.inDays / DurationExtra.daysPerMonth).round();
      case DurationUnit.year:
        return (duration.inDays / DurationExtra.daysPerYear).round();
    }
  }
}
