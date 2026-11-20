import 'package:moment_dart/src/exception.dart';
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
            "startOf(DurationUnit.week) is not supported on DateTime. You can use Moment(...).startOf(DurationUnit.week)");
      case DurationUnit.millisecond:
      case DurationUnit.second:
      case DurationUnit.minute:
      case DurationUnit.hour:
        // Wall-clock fields are ambiguous during the repeated hour of a DST
        // fall-back, so truncate the instant itself. Falls back to fields if
        // a transition inside the unit (e.g. half-hour DST) breaks that.
        final DateTime truncated = DateTime.fromMicrosecondsSinceEpoch(
          microsecondsSinceEpoch - _remainderWithin(unit),
          isUtc: isUtc,
        );
        if (truncated._remainderWithin(unit) == 0) return truncated;
        return _startOfByFields(unit);
      case DurationUnit.day:
      case DurationUnit.month:
      case DurationUnit.year:
        return _startOfByFields(unit);
    }
  }

  int _remainderWithin(DurationUnit unit) {
    int remainder = 0;
    if (unit.value <= DurationUnit.microsecond.value) return remainder;
    remainder += microsecond;
    if (unit.value <= DurationUnit.millisecond.value) return remainder;
    remainder += millisecond * Duration.microsecondsPerMillisecond;
    if (unit.value <= DurationUnit.second.value) return remainder;
    remainder += second * Duration.microsecondsPerSecond;
    if (unit.value <= DurationUnit.minute.value) return remainder;
    return remainder + minute * Duration.microsecondsPerMinute;
  }

  DateTime _startOfByFields(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.microsecond:
      case DurationUnit.week:
        throw StateError("unreachable");
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

    final int delta = (weekday - weekStart + 7) % 7;

    return DateTimeConstructors.withTimezone(
      isUtc,
      year,
      month,
      day - delta,
    );
  }

  /// Returns start of the ISO week (always Monday)
  ///
  /// Returned object will have same timezone as [this]
  DateTime startOfIsoWeek() => startOfLocalWeek(DateTime.monday);

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
  Moment startOf(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.week:
        return startOfLocalWeek();

      case DurationUnit.microsecond:
      case DurationUnit.millisecond:
      case DurationUnit.second:
      case DurationUnit.minute:
      case DurationUnit.hour:
      case DurationUnit.day:
      case DurationUnit.month:
      case DurationUnit.year:
        return forcedSuperType
            .startOf(unit)
            .toMoment(localization: setLocalization);
    }
  }

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

  /// Returns start of the ISO week (always Monday)
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfIsoWeek() => startOfLocalWeek(DateTime.monday);

  /// Returns start of the month
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfMonth() => startOf(DurationUnit.month);

  /// Returns start of the year
  ///
  /// Returned object will have same timezone as [this]
  Moment startOfYear() => startOf(DurationUnit.year);
}
