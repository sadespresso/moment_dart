import 'package:moment_dart/moment_dart.dart';

extension MomentBenefits on DateTime {
  /// [unit]: 0-7
  ///
  /// year,month,day,hour,minute,second,mircos,millis
  bool _isAtSameUnitAs(DateTime other, int unit) {
    other = other.toUtc();
    final DateTime self = toUtc();

    if (other.year != self.year) return false;
    if (unit == 0) return true;

    if (other.month != self.month) return false;
    if (unit == 1) return true;

    if (other.day != self.day) return false;
    if (unit == 2) return true;

    if (other.hour != self.hour) return false;
    if (unit == 3) return true;

    if (other.minute != self.minute) return false;
    if (unit == 4) return true;

    if (other.second != self.second) return false;
    if (unit == 5) return true;

    if (other.millisecond != self.millisecond) return false;
    if (unit == 6) return true;

    return other.microsecond == self.microsecond;
  }

  /// Returns if two dates are in same year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameYearAs(DateTime other) => _isAtSameUnitAs(other, 0);

  /// Returns if two dates are in same month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMonthAs(DateTime other) => _isAtSameUnitAs(other, 1);

  /// Returns if two dates are in same day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameDayAs(DateTime other) => _isAtSameUnitAs(other, 2);

  /// Returns if two dates are in same hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameHourAs(DateTime other) => _isAtSameUnitAs(other, 3);

  /// Returns if two dates are in same minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMinuteAs(DateTime other) => _isAtSameUnitAs(other, 4);

  /// Returns if two dates are in same second, minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameSecondAs(DateTime other) => _isAtSameUnitAs(other, 5);

  /// Returns if two dates are in same millisecond, second, minute, hour, day, month, year.
  ///
  /// The comparison takes UTC/local timezone into account.
  bool isAtSameMillisecondAs(DateTime other) => _isAtSameUnitAs(other, 6);

  /// Returns `this.isAtSameMomentAs(other)`
  bool isAtSameMicrosecondAs(DateTime other) => isAtSameMomentAs(other);

  bool get isLeapYear {
    if (year & 3 == 0) {
      if (year % 400 == 0) {
        return true;
      } else if (year % 100 == 0) {
        return false;
      }

      return true;
    }

    return false;
  }

  /// Returns quarter of the year.
  ///
  /// Jan,Feb,Mar is Q1
  ///
  /// Apr,May,Jun is Q2
  ///
  /// Jul,Aug,Sep is Q3
  ///
  /// Oct,Nov,Dec is Q4
  int get quarter {
    return (month - 1) ~/ 3 + 1;
  }

  int get _isoWeekRaw => (10 + dayOfYear - weekday) ~/ 7;

  bool get _isoWeekInNextYear =>
      DateTime(year, 1, 1).weekday != DateTime.thursday &&
      DateTime(year, 12, 31).weekday != DateTime.thursday;

  /// Returns [ISO week](https://en.wikipedia.org/wiki/ISO_week_date) number of the year
  ///
  /// [1, 2, 3, ..., 52, 53]
  int get week {
    final int w = _isoWeekRaw;

    // Last year may have 52 or 53 weeks, we shall check
    //
    // Dec 28 is always in the last week
    if (w == 0) {
      return DateTime(year - 1, 12, 28).week;
    }

    // It might actually be [Week 1] in the next year
    if (w == 53 && _isoWeekInNextYear) {
      return 1;
    }

    return w;
  }

  /// Returns year according to [ISO week](https://en.wikipedia.org/wiki/ISO_week_date) number of the year
  int get weekYear {
    final int w = _isoWeekRaw;

    if (w == 0) return year - 1;

    if (w == 53 && _isoWeekInNextYear) {
      return year + 1;
    }

    return year;
  }

  /// Returns ordinal day of the year
  ///
  /// [1,2,3,...,365,366]
  int get dayOfYear {
    const List<int> dayCount = [
      0,
      0,
      31,
      59,
      90,
      120,
      151,
      181,
      212,
      243,
      273,
      304,
      334
    ];

    int _dayOfYear = dayCount[month] + day;

    if (isLeapYear && month > 2) {
      return _dayOfYear + 1;
    }

    return _dayOfYear;
  }

  String timeZoneFormatted([bool seperateWithColon = true]) {
    final int hours = timeZoneOffset.inMinutes ~/ 60;
    final int minutes = timeZoneOffset.inMinutes - (hours * 60);

    return (timeZoneOffset.isNegative ? "-" : "+") +
        hours.toString() +
        (seperateWithColon ? ":" : "") +
        minutes.toString();
  }

  Moment toMoment({MomentLocalization? localization}) =>
      Moment(this, localization: localization);
}
