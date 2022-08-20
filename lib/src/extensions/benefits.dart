import 'package:moment_dart/src/moment_localization.dart';
import 'package:moment_dart/src/moment.dart';

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

    int dayOfTheYear = dayCount[month] + day;

    if (isLeapYear && month > 2) {
      return dayOfTheYear + 1;
    }

    return dayOfTheYear;
  }

  /// Difference calculated after omitting hour, minute, ..., microsecond
  ///
  /// Uses DateTime.difference(), therefore behaves same.
  /// So, be careful with UTC and local timezones.
  ///
  /// -------
  ///
  /// If [other] occured after [this], result is negative
  ///
  /// ```dart
  /// today.differenceInDays(tomorrow); // -1
  /// tomorrow.differenceInDays(today); // 1
  ///
  /// // 0 means [this] and [other] occured at the same day.
  /// ```
  int differenceInDays(DateTime other) {
    return DateTime(year, month, day)
        .difference(DateTime(other.year, other.month, other.day))
        .inDays;
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

  DateTime clone() {
    final value = DateTime(
        year, month, day, hour, minute, second, millisecond, microsecond);

    return isUtc ? value.toUtc() : value;
  }

  Moment toMoment({MomentLocalization? localization}) =>
      Moment(this, localization: localization);
}

extension MomentBenefitsPlus on Moment {
  DateTime get forcedSuperType => this;

  Moment clone() {
    return Moment(
        DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond),
        localization: localization);
  }
}

extension DurationExtra on Duration {
  static const int daysPerWeek = 7;

  int get inWeeks => inDays ~/ daysPerWeek;

  static const int daysPerMonth = 30;
  static const double daysPerMonthPrecise = 30.4368499;

  int get inMonths => inDays ~/ daysPerMonth;

  static const int daysPerYear = 365;
  static const double daysPerYearPrecise = 365.242199;

  int get inYears => inDays ~/ daysPerYear;

  static const int weeksPerYear = 52;
  static const double weeksPerYearPrecise = 52.177457;

  static const int monthsPerYear = 12;
}
