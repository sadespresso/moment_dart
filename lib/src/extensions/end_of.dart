import 'package:moment_dart/src/exception.dart';
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
      case DurationUnit.second:
      case DurationUnit.minute:
      case DurationUnit.hour:
        // See [startOf]. A wall-clock unit can last longer than
        // [unit.microseconds] (half-hour DST shifts), so step until the next
        // unit actually starts after [this].
        final int start = startOf(unit).microsecondsSinceEpoch;
        DateTime next = this;
        for (int k = 1; !next.isAfter(this); k++) {
          next = DateTime.fromMicrosecondsSinceEpoch(
            start + k * unit.microseconds,
            isUtc: isUtc,
          ).startOf(unit);
        }
        return DateTime.fromMicrosecondsSinceEpoch(
          next.microsecondsSinceEpoch - 1,
          isUtc: isUtc,
        );
      // One microsecond before the next unit starts. Building 23:59:59.999999
      // from fields would pick the first copy of a repeated hour, which is
      // before [this] where DST falls back at midnight (e.g. America/Santiago)
      case DurationUnit.day:
        return _justBefore(
            DateTimeConstructors.withTimezone(isUtc, year, month, day + 1));
      case DurationUnit.month:
        return _justBefore(
            DateTimeConstructors.withTimezone(isUtc, year, month + 1));
      case DurationUnit.year:
        return _justBefore(DateTimeConstructors.withTimezone(isUtc, year + 1));
    }
  }

  DateTime _justBefore(DateTime next) => DateTime.fromMicrosecondsSinceEpoch(
        next.microsecondsSinceEpoch - 1,
        isUtc: isUtc,
      );

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

    final int delta = (weekStart + 6 - weekday) % 7;

    return _justBefore(DateTimeConstructors.withTimezone(
      isUtc,
      year,
      month,
      day + delta + 1,
    ));
  }

  /// Returns end of the ISO week (always Sunday)
  ///
  /// Returned object will have same timezone as [this]
  DateTime endOfIsoWeek() => endOfLocalWeek(DateTime.monday);

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
  Moment endOf(DurationUnit unit) {
    switch (unit) {
      case DurationUnit.week:
        return endOfLocalWeek();

      case DurationUnit.microsecond:
      case DurationUnit.millisecond:
      case DurationUnit.second:
      case DurationUnit.minute:
      case DurationUnit.hour:
      case DurationUnit.day:
      case DurationUnit.month:
      case DurationUnit.year:
        return forcedSuperType
            .endOf(unit)
            .toMoment(localization: setLocalization);
    }
  }

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

  /// Returns end of the week based on [localization.weekStart]. You can override this with [weekStart]
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfLocalWeek([int? weekStart]) {
    return forcedSuperType
        .endOfLocalWeek(weekStart ?? localization.weekStart)
        .toMoment(localization: setLocalization);
  }

  /// Returns start of the ISO week (always Monday)
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfIsoWeek() => endOfLocalWeek(DateTime.monday);

  /// Returns end of the month
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfMonth() => endOf(DurationUnit.month);

  /// Returns end of the year
  ///
  /// Returned object will have same timezone as [this]
  Moment endOfYear() => endOf(DurationUnit.year);
}
