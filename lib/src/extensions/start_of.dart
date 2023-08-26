import 'package:moment_dart/src/exception.dart';
import 'package:moment_dart/src/extensions/constructor.dart';
import 'package:moment_dart/src/moment.dart';

extension StartOfUnit on DateTime {
  /// Returned object will have same timezone as [this]
  ///
  /// Notes:
  ///
  /// * instance.startOf(DurationUnit.week) will throw [MomentException]
  ///
  /// * instance.startOf(DurationUnit.microsecond) will return clone of that instance
  DateTime startOf(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.microsecond:
        return clone();
      case DurationUnit.week:
        throw MomentException(
            "endOf(DurationUnit.week) is not supported on DateTime. You can use Moment(...).startOf(DurationUnit.week)");
      case DurationUnit.millisecond:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
        );
      case DurationUnit.second:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
          month,
          day,
          hour,
          minute,
          second,
        );
      case DurationUnit.minute:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
          month,
          day,
          hour,
          minute,
        );
      case DurationUnit.hour:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
          month,
          day,
          hour,
        );
      case DurationUnit.day:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
          month,
          day,
        );
      case DurationUnit.month:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
          month,
        );
      case DurationUnit.year:
        return DateTimeConstructors.withTimezone(
          isUtc,
          year,
        );
    }
  }

  /// Returns start of the millisecond
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfMillisecond() => startOf(DurationUnit.millisecond);

  /// Returns start of the second
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfSecond() => startOf(DurationUnit.second);

  /// Returns start of the minute
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfMinute() => startOf(DurationUnit.minute);

  /// Returns start of the hour
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfHour() => startOf(DurationUnit.hour);

  /// Returns start of the day
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfDay() => startOf(DurationUnit.day);

  /// Returns start of the week based on [weekStart]. If it's null, it uses [Moment.defaultLocalization.weekStart]
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfLocalWeek([int? weekStart]) {
    weekStart ??= Moment.defaultLocalization.weekStart;

    int delta = weekday - weekStart;

    if (delta < 0) {
      delta += 7;
    }

    return subtract(Duration(days: delta)).startOfDay();
  }

  /// Returns start of the month
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfYear() => startOf(DurationUnit.year);
}

extension StartOfUnitMoment on Moment {
  /// Returned object will have same timezone as [this]
  ///
  /// instance.startOf(DurationUnit.microsecond) will return clone of that instance
  Moment startOf(DurationUnit unit) =>
      forcedSuperType.startOf(unit).toMoment(localization: setLocalization);

  /// Returns start of the millisecond
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfMillisecond() => startOf(DurationUnit.millisecond);

  /// Returns start of the second
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfSecond() => startOf(DurationUnit.second);

  /// Returns start of the minute
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfMinute() => startOf(DurationUnit.minute);

  /// Returns start of the hour
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfHour() => startOf(DurationUnit.hour);

  /// Returns start of the day
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfDay() => startOf(DurationUnit.day);

  /// Returns start of the week based on [localization.weekStart]. You can override this with [weekStart]
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfLocalWeek([int? weekStart]) {
    return forcedSuperType
        .startOfLocalWeek(weekStart ?? localization.weekStart)
        .toMoment(localization: setLocalization);
  }

  /// Returns start of the month
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfYear() => startOf(DurationUnit.year);
}
