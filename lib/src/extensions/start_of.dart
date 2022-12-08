import 'package:moment_dart/src/exception.dart';
import 'package:moment_dart/src/extensions/constructor.dart';
import 'package:moment_dart/src/moment.dart';

extension StartOfUnit on DateTime {
  /// Will assume [this] is local date.
  ///
  /// instance.startOf(DurationUnit.microsecond) will return clone of that instance
  DateTime startOf(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.microsecond:
        return clone();
      case DurationUnit.week:
        throw MomentException(
            "endOf(DurationUnit.week) is not supported on DateTime. You can use Moment(...).startOf(DurationUnit.week)");
      case DurationUnit.millisecond:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, minute, second, millisecond);
      case DurationUnit.second:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, minute, second);
      case DurationUnit.minute:
        return DateTimeConstructors.withTimezone(
            year, month, day, hour, minute);
      case DurationUnit.hour:
        return DateTimeConstructors.withTimezone(year, month, day, hour);
      case DurationUnit.day:
        return DateTimeConstructors.withTimezone(year, month, day);
      case DurationUnit.month:
        return DateTimeConstructors.withTimezone(year, month);
      case DurationUnit.year:
        return DateTimeConstructors.withTimezone(year);
    }
  }

  /// Returns start of the millisecond
  ///
  /// Will assume [this] is local date.
  DateTime startOfMillisecond() => startOf(DurationUnit.millisecond);

  /// Returns start of the second
  ///
  /// Will assume [this] is local date.
  DateTime startOfSecond() => startOf(DurationUnit.second);

  /// Returns start of the minute
  ///
  /// Will assume [this] is local date.
  DateTime startOfMinute() => startOf(DurationUnit.minute);

  /// Returns start of the hour
  ///
  /// Will assume [this] is local date.
  DateTime startOfHour() => startOf(DurationUnit.hour);

  /// Returns start of the day
  ///
  /// Will assume [this] is local date.
  DateTime startOfDay() => startOf(DurationUnit.day);

  /// Returns start of the week based on [weekStart]
  ///
  /// Will assume [this] is local date.
  DateTime startOfLocalWeek([int weekStart = DateTime.monday]) {
    if (isUtc) return toLocal().startOfLocalWeek(weekStart);

    int delta = weekday - weekStart;

    if (delta < 0) {
      delta += 7;
    }

    return subtract(Duration(days: delta)).startOfDay();
  }

  /// Returns start of the month
  ///
  /// Will assume [this] is local date.
  DateTime startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// Will assume [this] is local date.
  DateTime startOfYear() => startOf(DurationUnit.year);
}

extension StartOfUnitMoment on Moment {
  /// Will assume [this] is local date.
  ///
  /// instance.startOf(DurationUnit.microsecond) will return clone of that instance
  Moment startOf(DurationUnit unit) =>
      forcedSuperType.startOf(unit).toMoment(localization: localization);

  /// Returns start of the millisecond
  ///
  /// Will assume [this] is local date.
  Moment startOfMillisecond() => startOf(DurationUnit.millisecond);

  /// Returns start of the second
  ///
  /// Will assume [this] is local date.
  Moment startOfSecond() => startOf(DurationUnit.second);

  /// Returns start of the minute
  ///
  /// Will assume [this] is local date.
  Moment startOfMinute() => startOf(DurationUnit.minute);

  /// Returns start of the hour
  ///
  /// Will assume [this] is local date.
  Moment startOfHour() => startOf(DurationUnit.hour);

  /// Returns start of the day
  ///
  /// Will assume [this] is local date.
  Moment startOfDay() => startOf(DurationUnit.day);

  /// Returns start of the week based on [localization.weekStart]
  ///
  /// Will assume [this] is local date.
  Moment startOfLocalWeek() {
    return forcedSuperType
        .startOfLocalWeek(localization.weekStart)
        .toMoment(localization: localization);
  }

  /// Returns start of the month
  ///
  /// Will assume [this] is local date.
  Moment startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// Will assume [this] is local date.
  Moment startOfYear() => startOf(DurationUnit.year);
}
