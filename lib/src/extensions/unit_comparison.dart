import 'package:moment_dart/moment_dart.dart';

extension UnitComparision on DateTime {
  /// [unit]: 0-7
  ///
  /// year,month,day,hour,minute,second,mircos,millis
  bool _isAtSameUnitAs(DateTime other, DurationUnit unit) {
    if (unit == DurationUnit.microsecond) {
      return isAtSameMomentAs(other);
    }

    late final DateTime self;

    if (other.isUtc) {
      self = toUtc();
    } else {
      self = toUtc().add(other.timeZoneOffset);
      other = other.toUtc();
    }

    if (other.year != self.year) return false;
    if (unit == DurationUnit.year) return true;

    if (other.month != self.month) return false;
    if (unit == DurationUnit.month) return true;

    if (other.day != self.day) return false;
    if (unit == DurationUnit.day) return true;

    if (other.hour != self.hour) return false;
    if (unit == DurationUnit.hour) return true;

    if (other.minute != self.minute) return false;
    if (unit == DurationUnit.minute) return true;

    if (other.second != self.second) return false;
    if (unit == DurationUnit.second) return true;

    if (other.millisecond != self.millisecond) return false;
    if (unit == DurationUnit.millisecond) return true;

    return other.microsecond == self.microsecond;
  }

  /// Returns if two dates are in same year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameYearAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.year);

  /// Returns if two dates are in same month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMonthAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.month);

  /// Returns if two dates are in same day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameDayAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.day);

  /// Returns if two dates are in same hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameHourAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.hour);

  /// Returns if two dates are in same minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMinuteAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.minute);

  /// Returns if two dates are in same second, minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameSecondAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.second);

  /// Returns if two dates are in same millisecond, second, minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMillisecondAs(DateTime other) =>
      _isAtSameUnitAs(other, DurationUnit.millisecond);

  /// Returns `this.isAtSameMomentAs(other)`
  bool isAtSameMicrosecondAs(DateTime other) => isAtSameMomentAs(other);

  /// Returns whether [this] and [other] is in same **local** week. Local week is determined by [weekStart], defaults to [DateTime.monday]
  bool isSameLocalWeekAs(DateTime other, [int weekStart = DateTime.monday]) {
    final DateTime startOfWeek = startOfLocalWeek(weekStart);
    if (other < startOfWeek) return false;

    final DateTime endOfWeek = endOfLocalWeek(weekStart);
    return other <= endOfWeek;
  }
}

extension UnitComparisonMoment on Moment {
  /// Returns whether [this] and [other] is in same **local** week. Local week is determined by [localization.weekStart], defaults to [DateTime.monday]
  bool isSameLocalWeekAs(DateTime other) {
    return forcedSuperType.isSameLocalWeekAs(other, localization.weekStart);
  }
}
