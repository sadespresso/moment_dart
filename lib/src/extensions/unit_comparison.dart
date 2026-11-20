import 'package:moment_dart/moment_dart.dart';

extension UnitComparision on DateTime {
  bool _isAtSameUnitAs(
    DateTime other,
    DurationUnit unit, {
    bool enforceUTC = false,
  }) {
    if (enforceUTC) {
      return toUtc()._isAtSameUnitAs(other.toUtc(), unit);
    }

    final DateTime converted = other.isUtc == isUtc
        ? other
        : (isUtc ? other.toUtc() : other.toLocal());

    // Comparing unit starts as instants (not wall-clock fields) keeps the two
    // copies of a repeated DST hour apart
    return startOf(unit).isAtSameMomentAs(converted.startOf(unit));
  }

  /// Returns if two dates are in same year.
  ///
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
  /// [other] is converted to the timezone of [this] first
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
