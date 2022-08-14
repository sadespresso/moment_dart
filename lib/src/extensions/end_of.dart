import 'package:moment_dart/src/exception.dart';
import 'package:moment_dart/src/moment.dart';

extension EndOfUnit on DateTime {
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  ///
  /// Will throw [MomentException] if [unit] is [DurationUnit.microsecond]
  DateTime endOf(DurationUnit unit) {
    if (isUtc) return toLocal().endOf(unit);

    switch (unit) {
      case DurationUnit.microsecond:
        throw MomentException(
            "Illegally called moment.endOf(DurationUnit.microsecond) when microsecond is the smallest unit");
      case DurationUnit.week:
        throw MomentException("endOf(DurationUnit.week) is not supported");
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
        return DateTime(year, month, 31, 23, 59, 59, 999, 999);
      case DurationUnit.year:
        return DateTime(year, 12, 31, 23, 59, 59, 999, 999);
    }
  }

  /// Returns end of the millisecond
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfMillisecond() => endOf(DurationUnit.millisecond);

  /// Returns end of the second
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfSecond() => endOf(DurationUnit.second);

  /// Returns end of the minute
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfMinute() => endOf(DurationUnit.minute);

  /// Returns end of the hour
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfHour() => endOf(DurationUnit.hour);

  /// Returns end of the day
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfDay() => endOf(DurationUnit.day);

  /// Returns end of the month
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime endOfYear() => endOf(DurationUnit.year);
}

extension EndOfUnitMoment on Moment {
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  ///
  /// Will throw [MomentException] if [unit] is [DurationUnit.microsecond]
  Moment endOf(DurationUnit unit) =>
      forcedSuperType.endOf(unit).toMoment(localization: localization);

  /// Returns end of the millisecond
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfMillisecond() => endOf(DurationUnit.millisecond);

  /// Returns end of the second
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfSecond() => endOf(DurationUnit.second);

  /// Returns end of the minute
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfMinute() => endOf(DurationUnit.minute);

  /// Returns end of the hour
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfHour() => endOf(DurationUnit.hour);

  /// Returns end of the day
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfDay() => endOf(DurationUnit.day);

  /// Returns end of the month
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment endOfYear() => endOf(DurationUnit.year);
}
