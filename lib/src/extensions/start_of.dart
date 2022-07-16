import 'package:moment_dart/src/moment.dart';

extension StartOfUnit on DateTime {
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  ///
  /// instance.startOf(DurationUnit.microsecond) will return clone of that instance
  DateTime startOf(DurationUnit unit) {
    if (isUtc) return toLocal().startOf(unit);

    switch (unit) {
      case DurationUnit.microsecond:
        return clone();
      case DurationUnit.millisecond:
        return DateTime(year, month, day, hour, minute, second, millisecond);
      case DurationUnit.second:
        return DateTime(year, month, day, hour, minute, second);
      case DurationUnit.minute:
        return DateTime(year, month, day, hour, minute);
      case DurationUnit.hour:
        return DateTime(year, month, day, hour);
      case DurationUnit.day:
        return DateTime(year, month, day);
      case DurationUnit.month:
        return DateTime(year, month);
      case DurationUnit.year:
        return DateTime(year);
    }
  }

  /// Returns start of the millisecond
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfMillisecond() => startOf(DurationUnit.millisecond);

  /// Returns start of the second
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfSecond() => startOf(DurationUnit.second);

  /// Returns start of the minute
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfMinute() => startOf(DurationUnit.minute);

  /// Returns start of the hour
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfHour() => startOf(DurationUnit.hour);

  /// Returns start of the day
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfDay() => startOf(DurationUnit.day);

  /// Returns start of the month
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  DateTime startOfYear() => startOf(DurationUnit.year);
}

extension StartOfUnitMoment on Moment {
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  ///
  /// instance.startOf(DurationUnit.microsecond) will return clone of that instance
  Moment startOf(DurationUnit unit) =>
      forcedSuperType.startOf(unit).toMoment(localization: localization);

  /// Returns start of the millisecond
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfMillisecond() => startOf(DurationUnit.millisecond);

  /// Returns start of the second
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfSecond() => startOf(DurationUnit.second);

  /// Returns start of the minute
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfMinute() => startOf(DurationUnit.minute);

  /// Returns start of the hour
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfHour() => startOf(DurationUnit.hour);

  /// Returns start of the day
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfDay() => startOf(DurationUnit.day);

  /// Returns start of the month
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  Moment startOfYear() => startOf(DurationUnit.year);
}
