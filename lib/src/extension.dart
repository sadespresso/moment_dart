import 'package:moment_dart/moment_dart.dart';

enum DurationUnit {
  microsecond(0),
  millisecond(1),
  second(2),
  minute(3),
  hour(4),
  day(5),

  /// Doesn't take timezone into account.
  month(6),

  /// Doesn't take timezone into account.
  year(7);

  final int value;

  const DurationUnit(this.value);
}

extension MomentBenefits on DateTime {
  /// Returns if [year] is leap year.
  ///
  /// More about leap years: [Leap Year](https://en.wikipedia.org/wiki/Leap_year)
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

  operator +(Duration other) => add(other);
  operator -(Duration other) => subtract(other);
  operator >(DateTime other) => isAfter(other);
  operator <(DateTime other) => isBefore(other);
  operator >=(DateTime other) => isAfter(other) || isAtSameMomentAs(other);
  operator <=(DateTime other) => isBefore(other) || isAtSameMomentAs(other);

  /// Returns timezone:
  ///
  /// -06:00 => GMT-6
  ///
  /// +13:00 => GMT+13
  ///
  /// You can disable [seperateWithColon].
  ///
  /// -0730 => GMT-7:30
  ///
  /// +1300 => GMT+13
  String timeZoneFormatted([bool seperateWithColon = true]) {
    final int hours = timeZoneOffset.inMinutes ~/ 60;
    final int minutes = timeZoneOffset.inMinutes - (hours * 60);

    return (timeZoneOffset.isNegative ? "-" : "+") +
        hours.toString().padLeft(2, '0') +
        (seperateWithColon ? ":" : "") +
        minutes.toString().padLeft(2, '0');
  }

  Moment toMoment({MomentLocalization? localization}) =>
      Moment(this, localization: localization);
}

extension UnitComparision on DateTime {
  /// [unit]: 0-7
  ///
  /// year,month,day,hour,minute,second,mircos,millis
  bool _isAtSameUnitAs(DateTime other, DurationUnit unit) {
    if (unit == DurationUnit.microsecond) {
      return isAtSameMomentAs(other);
    }

    other = other.toUtc();
    final DateTime self = toUtc();

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
}

extension WeekdayFinder on DateTime {
  /// Returns new [DateTime] instance of nearest `n`th weekday in the future
  ///
  /// If `n`th day is today, will return `7 days in the future`.
  DateTime nextWeekday(int weekday) {
    assert(weekday > -1 && weekday < 8,
        "[Moment Dart] Weekday must be in range `0<=n<=7`");

    final int requiredDelta = (weekday - this.weekday) % 7;

    return this + Duration(days: requiredDelta == 0 ? 7 : requiredDelta);
  }

  /// Returns new [DateTime] instance of nearest Monday in the Future
  ///
  /// If [this] is Monday, will return `7 days in the future`
  DateTime nextMonday() => nextWeekday(DateTime.monday);

  /// Returns new [DateTime] instance of nearest Tuesday in the Future
  ///
  /// If [this] is Tuesday, will return `7 days in the future`
  DateTime nextTuesday() => nextWeekday(DateTime.tuesday);

  /// Returns new [DateTime] instance of nearest Wednesday in the Future
  ///
  /// If [this] is Wednesday, will return `7 days in the future`
  DateTime nextWednesday() => nextWeekday(DateTime.wednesday);

  /// Returns new [DateTime] instance of nearest Thursday in the Future
  ///
  /// If [this] is Thursday, will return `7 days in the future`
  DateTime nextThursday() => nextWeekday(DateTime.thursday);

  /// Returns new [DateTime] instance of nearest Friday in the Future
  ///
  /// If [this] is Friday, will return `7 days in the future`
  DateTime nextFriday() => nextWeekday(DateTime.friday);

  /// Returns new [DateTime] instance of nearest Saturday in the Future
  ///
  /// If [this] is Saturday, will return `7 days in the future`
  DateTime nextSaturday() => nextWeekday(DateTime.saturday);

  /// Returns new [DateTime] instance of nearest Sunday in the Future
  ///
  /// If [this] is Sunday, will return `7 days in the future`
  DateTime nextSunday() => nextWeekday(DateTime.sunday);

  /// Returns new [DateTime] instance of last `n`th weekday
  ///
  /// If today is the `n`th day, will return `7 days in the past`
  DateTime lastWeekday(int weekday) {
    assert(weekday > -1 && weekday < 8,
        "[Moment Dart] Weekday must be in range `0<=n<=7`");

    final int requiredDelta = (this.weekday - weekday) % 7;

    return this - Duration(days: requiredDelta == 0 ? 7 : requiredDelta);
  }

  /// Returns new [DateTime] instance of nearest Monday in the past
  ///
  /// If [this] is Monday, will return `7 days in the past`
  DateTime lastMonday() => lastWeekday(DateTime.monday);

  /// Returns new [DateTime] instance of nearest Tuesday in the past
  ///
  /// If [this] is Tuesday, will return `7 days in the past`
  DateTime lastTuesday() => lastWeekday(DateTime.tuesday);

  /// Returns new [DateTime] instance of nearest Wednesday in the past
  ///
  /// If [this] is Wednesday, will return `7 days in the past`
  DateTime lastWednesday() => lastWeekday(DateTime.wednesday);

  /// Returns new [DateTime] instance of nearest Thursday in the past
  ///
  /// If [this] is Thursday, will return `7 days in the past`
  DateTime lastThursday() => lastWeekday(DateTime.thursday);

  /// Returns new [DateTime] instance of nearest Friday in the past
  ///
  /// If [this] is Friday, will return `7 days in the past`
  DateTime lastFriday() => lastWeekday(DateTime.friday);

  /// Returns new [DateTime] instance of nearest Saturday in the past
  ///
  /// If [this] is Saturday, will return `7 days in the past`
  DateTime lastSaturday() => lastWeekday(DateTime.saturday);

  /// Returns new [DateTime] instance of nearest Sunday in the past
  ///
  /// If [this] is Sunday, will return `7 days in the past`
  DateTime lastSunday() => lastWeekday(DateTime.sunday);
}

extension StartOfUnit on DateTime {
  /// ⚠️ Only works on local time zone dates
  ///
  /// When UTC DateTime is passed, it's converted into Local DateTime first.
  ///
  /// Will throw if [unit] is [DurationUnit.microsecond]
  DateTime startOf(DurationUnit unit) {
    if (isUtc) return toLocal().startOf(unit);

    switch (unit) {
      case DurationUnit.microsecond:
        throw "Microsecond is the smallest ";
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
