import 'package:moment_dart/src/exception.dart';
import 'package:moment_dart/src/moment.dart';

extension EndOfUnit on DateTime {
  /// Will assume [this] is local date.
  ///
  /// Will throw [MomentException] if [unit] is [DurationUnit.microsecond]
  DateTime endOf(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.microsecond:
        throw MomentException(
            "Illegally called moment.endOf(DurationUnit.microsecond) when microsecond is the smallest unit");
      case DurationUnit.week:
        throw MomentException(
            "endOf(DurationUnit.week) is not supported on DateTime object. You can use it on Moment objects");
      case DurationUnit.millisecond:
        return DateTime(
            year, month, day, hour, minute, second, millisecond, 999);
      case DurationUnit.second:
        return DateTime(year, month, day, hour, minute, second, 999, 999);
      case DurationUnit.minute:
        return DateTime(year, month, day, hour, minute, 59, 999, 999);
      case DurationUnit.hour:
        return DateTime(year, month, day, hour, 59, 59, 999, 999);
      case DurationUnit.day:
        return DateTime(year, month, day, 23, 59, 59, 999, 999);
      case DurationUnit.month:
        const daysInMonths = [
          0,
          31,
          28,
          31,
          30,
          31,
          30,
          31,
          31,
          30,
          31,
          30,
          31
        ];

        final bool extraFebDay = month == DateTime.february && isLeapYear;
        return DateTime(
          year,
          month,
          daysInMonths[month] + (extraFebDay ? 1 : 0),
          23,
          59,
          59,
          999,
          999,
        );
      case DurationUnit.year:
        return DateTime(year, 12, 31, 23, 59, 59, 999, 999);
    }
  }

  /// Returns end of the millisecond
  ///
  /// Will assume [this] is local date.
  DateTime endOfMillisecond() => endOf(DurationUnit.millisecond);

  /// Returns end of the second
  ///
  /// Will assume [this] is local date.
  DateTime endOfSecond() => endOf(DurationUnit.second);

  /// Returns end of the minute
  ///
  /// Will assume [this] is local date.
  DateTime endOfMinute() => endOf(DurationUnit.minute);

  /// Returns end of the hour
  ///
  /// Will assume [this] is local date.
  DateTime endOfHour() => endOf(DurationUnit.hour);

  /// Returns end of the day
  ///
  /// Will assume [this] is local date.
  DateTime endOfDay() => endOf(DurationUnit.day);

  /// Returns start of the week based on [weekStart]
  ///
  /// Will assume [this] is local date.
  DateTime endOfLocalWeek([int weekStart = DateTime.monday]) {
    if (isUtc) return toLocal().endOfLocalWeek(weekStart);

    int delta = (weekStart + 6) - weekday;
    if (delta > 7) {
      delta -= 7;
    }

    return add(Duration(days: delta)).endOfDay();
  }

  /// Returns end of the month
  ///
  /// Will assume [this] is local date.
  DateTime endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// Will assume [this] is local date.
  DateTime endOfYear() => endOf(DurationUnit.year);
}

extension EndOfUnitMoment on Moment {
  /// Will assume [this] is local date.
  ///
  /// Will throw [MomentException] if [unit] is [DurationUnit.microsecond]
  Moment endOf(DurationUnit unit) =>
      forcedSuperType.endOf(unit).toMoment(localization: localization);

  /// Returns end of the millisecond
  ///
  /// Will assume [this] is local date.
  Moment endOfMillisecond() => endOf(DurationUnit.millisecond);

  /// Returns end of the second
  ///
  /// Will assume [this] is local date.
  Moment endOfSecond() => endOf(DurationUnit.second);

  /// Returns end of the minute
  ///
  /// Will assume [this] is local date.
  Moment endOfMinute() => endOf(DurationUnit.minute);

  /// Returns end of the hour
  ///
  /// Will assume [this] is local date.
  Moment endOfHour() => endOf(DurationUnit.hour);

  /// Returns end of the day
  ///
  /// Will assume [this] is local date.
  Moment endOfDay() => endOf(DurationUnit.day);

  /// Returns end of the week based on [localization.weekStart]
  ///
  /// Will assume [this] is local date.
  Moment endOfLocalWeek() {
    return forcedSuperType
        .endOfLocalWeek(localization.weekStart)
        .toMoment(localization: localization);
  }

  /// Returns end of the month
  ///
  /// Will assume [this] is local date.
  Moment endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// Will assume [this] is local date.
  Moment endOfYear() => endOf(DurationUnit.year);
}
