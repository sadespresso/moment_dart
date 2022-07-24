import 'package:moment_dart/src/extension.dart';

/// Does not take account for timezone
enum DurationUnit {
  microsecond(0),
  millisecond(1),
  second(2),
  minute(3),
  hour(4),
  day(5),
  month(6),
  year(7);

  final int value;

  const DurationUnit(this.value);

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
      case DurationUnit.month:
        return (duration.inDays / DurationExtra.daysPerMonthPrecise).round();
      case DurationUnit.year:
        return (duration.inDays / DurationExtra.daysPerYearPrecise).round();
    }
  }
}
