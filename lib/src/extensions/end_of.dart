import 'package:moment_dart/src/exception.dart';
import 'package:moment_dart/src/extensions/constructor.dart';
import 'package:moment_dart/src/moment.dart';

extension EndOfUnit on DateTime {
  /// Returned object will have same timezone as [this]
  ///
  /// Notes:
  ///
  /// * instance.startOf(DurationUnit.week) will throw [MomentException]
  ///
  /// * instance.startOf(DurationUnit.microsecond) will return clone of that instance
  DateTime endOf(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.microsecond:
        return clone();
      case DurationUnit.week:
        throw MomentException(
            "endOf(DurationUnit.week) is not supported on DateTime object. You can use it on Moment objects");
      case DurationUnit.millisecond:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, minute, second, millisecond, 999, isUtc);
      case DurationUnit.second:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, minute, second, 999, 999, isUtc);
      case DurationUnit.minute:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, minute, 59, 999, 999, isUtc);
      case DurationUnit.hour:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, 59, 59, 999, 999, isUtc);
      case DurationUnit.day:
        return DateTimeConstructors.withTimezone(
            year, month, day, 23, 59, 59, 999, 999, isUtc);
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
        return DateTimeConstructors.withTimezone(
            year, 12, 31, 23, 59, 59, 999, 999, isUtc);
    }
  }

  /// Returns end of the millisecond
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfMillisecond() => endOf(DurationUnit.millisecond);

  /// Returns end of the second
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfSecond() => endOf(DurationUnit.second);

  /// Returns end of the minute
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfMinute() => endOf(DurationUnit.minute);

  /// Returns end of the hour
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfHour() => endOf(DurationUnit.hour);

  /// Returns end of the day
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfDay() => endOf(DurationUnit.day);

  /// Returns start of the week based on [weekStart]. If it's null, it uses [Moment.defaultLocalization.weekStart]
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfLocalWeek([int? weekStart]) {
    weekStart ??= Moment.defaultLocalization.weekStart;

    int delta = (weekStart + 6) - weekday;
    if (delta > 7) {
      delta -= 7;
    }

    return add(Duration(days: delta)).endOfDay();
  }

  /// Returns end of the month
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfYear() => endOf(DurationUnit.year);
}

extension EndOfUnitMoment on Moment {
  /// Returned object will have same timezone as [this]
  Moment endOf(DurationUnit unit) =>
      forcedSuperType.endOf(unit).toMoment(localization: localization);

  /// Returns end of the millisecond
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfMillisecond() => endOf(DurationUnit.millisecond);

  /// Returns end of the second
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfSecond() => endOf(DurationUnit.second);

  /// Returns end of the minute
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfMinute() => endOf(DurationUnit.minute);

  /// Returns end of the hour
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfHour() => endOf(DurationUnit.hour);

  /// Returns end of the day
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfDay() => endOf(DurationUnit.day);

  /// Returns end of the week based on [localization.weekStart]
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfLocalWeek() {
    return forcedSuperType
        .endOfLocalWeek(localization.weekStart)
        .toMoment(localization: localization);
  }

  /// Returns end of the month
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfYear() => endOf(DurationUnit.year);
}
