import 'package:moment_dart/moment_dart.dart';

extension UnitComparision on DateTime {
  /// [unit]: 0-7
  ///
  /// year, month, day, hour, minute, second, millisecond, microsecond
  bool _isAtSameUnitAs(
    DateTime other,
    DurationUnit unit, {
    bool enforceUTC = false,
  }) {
    if (enforceUTC) {
      return toUtc()._isAtSameUnitAs(other.toUtc(), unit, enforceUTC: false);
    }

    if (other.year != year) return false;
    if (unit == DurationUnit.year) return true;

    if (other.month != month) return false;
    if (unit == DurationUnit.month) return true;

    if (other.day != day) return false;
    if (unit == DurationUnit.day) return true;

    if (other.hour != hour) return false;
    if (unit == DurationUnit.hour) return true;

    if (other.minute != minute) return false;
    if (unit == DurationUnit.minute) return true;

    if (other.second != second) return false;
    if (unit == DurationUnit.second) return true;

    if (other.millisecond != millisecond) return false;
    if (unit == DurationUnit.millisecond) return true;

    return other.microsecond == microsecond;
  }

  /// Returns if two dates are in same year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameYearAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.year,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameMonthAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.month,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same day, month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameDayAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.day,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same hour, day, month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameHourAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.hour,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same minute, hour, day, month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameMinuteAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.minute,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same second, minute, hour, day, month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameSecondAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.second,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same millisecond, second, minute, hour, day, month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameMillisecondAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.millisecond,
        enforceUTC: enforceUTC,
      );

  /// Returns if two dates are in same microsecond, millisecond, second, minute, hour, day, month, year.
  ///
  /// Assumes both [this] and [other] has same timezone
  ///
  /// To convert both to `UTC` before comparison, set [enforceUTC] to `true`
  bool isAtSameMicrosecondAs(
    DateTime other, {
    bool enforceUTC = false,
  }) =>
      _isAtSameUnitAs(
        other,
        DurationUnit.microsecond,
        enforceUTC: enforceUTC,
      );

  /// Returns whether [this] and [other] is in same **local** week. Local week is determined by [weekStart], defaults to [DateTime.monday]
  ///
  /// Assumes both [this] and [other] is in local timezone.
  bool isSameLocalWeekAs(
    DateTime other, [
    int? weekStart,
  ]) {
    weekStart ??= Moment.defaultLocalization.weekStart;

    final DateTime startOfWeek = startOfLocalWeek(weekStart);
    if (other < startOfWeek) return false;

    final DateTime endOfWeek = endOfLocalWeek(weekStart);

    return other <= endOfWeek;
  }
}

extension UnitComparisonMoment on Moment {
  /// Returns whether [this] and [other] is in same **local** week. Local week is determined by [localization.weekStart], defaults to [DateTime.monday]
  ///
  /// Assumes both [this] and [other] is in local timezone.
  bool isSameLocalWeekAs(DateTime other) =>
      forcedSuperType.isSameLocalWeekAs(other, localization.weekStart);
}
