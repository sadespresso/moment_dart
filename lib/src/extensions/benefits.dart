import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/extensions/constructor.dart';

export 'duration.dart';

extension MomentBenefits on DateTime {
  /// Returns if [year] is leap year.
  ///
  /// More about leap years: [Leap Year](https://en.wikipedia.org/wiki/Leap_year)
  bool get isLeapYear {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    return year % 4 == 0;
  }

  /// Returns hour in 12-hour format
  ///
  /// Relevant: [isAm] or [isPm]
  int get hour12 {
    if (hour == 0 || hour == 12) return 12;

    return hour % 12;
  }

  /// Returns whether the [hour] is before noon (ante meridiem) in the current timezone
  bool get isAm => hour < 12;

  /// Returns whether the [hour] is after noon (post meridiem) in the current timezone
  bool get isPm => hour >= 12;

  /// Returns quarter of the year.
  ///
  /// Jan,Feb,Mar is Q1
  ///
  /// Apr,May,Jun is Q2
  ///
  /// Jul,Aug,Sep is Q3
  ///
  /// Oct,Nov,Dec is Q4
  int get quarter => (month - 1) ~/ 3 + 1;

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

  /// Returns ordinal day of the year in the current timezone
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

    final int dayOfTheYear = dayCount[month] + day;

    if (isLeapYear && month > 2) {
      return dayOfTheYear + 1;
    }

    return dayOfTheYear;
  }

  /// Difference calculated after omitting hour, minute, ..., microsecond
  ///
  /// Does not take timezones of [this] and [other]!
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
    return date.difference(other.date).inDays;
  }

  /// Equivalent to `add(other)`
  operator +(Duration other) => add(other);

  /// Equivalent to `subtract(other)`
  operator -(Duration other) => subtract(other);

  /// Equivalent to `isAfter(other)`
  operator >(DateTime other) => isAfter(other);

  /// Equivalent to `isBefore(other)`
  operator <(DateTime other) => isBefore(other);

  /// Equivalent to `isAfter(other) || isAtSameMomentAs(other)`
  operator >=(DateTime other) => isAfter(other) || isAtSameMomentAs(other);

  /// Equivalent to `isBefore(other) || isAtSameMomentAs(other)`
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
    final int inMinutes = timeZoneOffset.abs().inMinutes;

    final int hours = inMinutes ~/ 60;
    final int minutes = inMinutes - (hours * 60);

    return (timeZoneOffset.isNegative ? "-" : "+") +
        hours.toString().padLeft(2, '0') +
        (seperateWithColon ? ":" : "") +
        minutes.toString().padLeft(2, '0');
  }

  /// Returns new `DateTime`, preserves timezone
  DateTime clone() {
    return DateTimeConstructors.withTimezone(
      isUtc,
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Returns new `DateTime` with the date at 00:00:00 AM, preserves timezone
  DateTime get date => DateTimeConstructors.dateWithTimezone(
        year,
        month,
        day,
        isUtc,
      );

  Moment toMoment({MomentLocalization? localization}) =>
      Moment(this, localization: localization);

  String format({
    String payload = MomentLocalization.localizationDefaultDateFormat,
    bool forceLocal = false,
    MomentLocalization? localization,
  }) {
    if (this is Moment) {
      return localization == null
          ? (this as Moment).format(payload, forceLocal)
          : (this as Moment)
              .copyWith(localization: localization)
              .format(payload, forceLocal);
    }

    return toMoment(localization: localization).format(payload, forceLocal);
  }
}

extension MomentBenefitsPlus on Moment {
  /// Returns [this] as [DateTime] (the super type)
  DateTime get forcedSuperType => this;

  Moment clone() {
    return Moment(
      forcedSuperType.clone(),
      localization: setLocalization,
    );
  }

  Moment get date {
    return Moment(
      forcedSuperType.date,
      localization: setLocalization,
    );
  }
}
