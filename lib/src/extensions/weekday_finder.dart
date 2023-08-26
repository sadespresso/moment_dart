import 'package:moment_dart/src/moment.dart';

extension WeekdayFinder on DateTime {
  /// Returns new [DateTime] instance of nearest `n`th weekday in the future
  ///
  /// If `n`th day is today, will return `7 days in the future`.
  DateTime nextWeekday(int weekday) {
    assert(weekday > -1 && weekday < 8,
        "[moment_dart] Weekday must be in range `0<=n<=7`");

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

extension WeekdayFinderMoment on Moment {
  /// Returns new [Moment] instance of nearest `n`th weekday in the future
  ///
  /// If `n`th day is today, will return `7 days in the future`.
  Moment nextWeekday(int weekday) => forcedSuperType
      .nextWeekday(weekday)
      .toMoment(localization: setLocalization);

  /// Returns new [Moment] instance of nearest Monday in the Future
  ///
  /// If [this] is Monday, will return `7 days in the future`
  Moment nextMonday() => nextWeekday(DateTime.monday);

  /// Returns new [Moment] instance of nearest Tuesday in the Future
  ///
  /// If [this] is Tuesday, will return `7 days in the future`
  Moment nextTuesday() => nextWeekday(DateTime.tuesday);

  /// Returns new [Moment] instance of nearest Wednesday in the Future
  ///
  /// If [this] is Wednesday, will return `7 days in the future`
  Moment nextWednesday() => nextWeekday(DateTime.wednesday);

  /// Returns new [Moment] instance of nearest Thursday in the Future
  ///
  /// If [this] is Thursday, will return `7 days in the future`
  Moment nextThursday() => nextWeekday(DateTime.thursday);

  /// Returns new [Moment] instance of nearest Friday in the Future
  ///
  /// If [this] is Friday, will return `7 days in the future`
  Moment nextFriday() => nextWeekday(DateTime.friday);

  /// Returns new [Moment] instance of nearest Saturday in the Future
  ///
  /// If [this] is Saturday, will return `7 days in the future`
  Moment nextSaturday() => nextWeekday(DateTime.saturday);

  /// Returns new [Moment] instance of nearest Sunday in the Future
  ///
  /// If [this] is Sunday, will return `7 days in the future`
  Moment nextSunday() => nextWeekday(DateTime.sunday);

  /// Returns new [Moment] instance of last `n`th weekday
  ///
  /// If today is the `n`th day, will return `7 days in the past`
  Moment lastWeekday(int weekday) => forcedSuperType
      .lastWeekday(weekday)
      .toMoment(localization: setLocalization);

  /// Returns new [Moment] instance of nearest Monday in the past
  ///
  /// If [this] is Monday, will return `7 days in the past`
  Moment lastMonday() => lastWeekday(DateTime.monday);

  /// Returns new [Moment] instance of nearest Tuesday in the past
  ///
  /// If [this] is Tuesday, will return `7 days in the past`
  Moment lastTuesday() => lastWeekday(DateTime.tuesday);

  /// Returns new [Moment] instance of nearest Wednesday in the past
  ///
  /// If [this] is Wednesday, will return `7 days in the past`
  Moment lastWednesday() => lastWeekday(DateTime.wednesday);

  /// Returns new [Moment] instance of nearest Thursday in the past
  ///
  /// If [this] is Thursday, will return `7 days in the past`
  Moment lastThursday() => lastWeekday(DateTime.thursday);

  /// Returns new [Moment] instance of nearest Friday in the past
  ///
  /// If [this] is Friday, will return `7 days in the past`
  Moment lastFriday() => lastWeekday(DateTime.friday);

  /// Returns new [Moment] instance of nearest Saturday in the past
  ///
  /// If [this] is Saturday, will return `7 days in the past`
  Moment lastSaturday() => lastWeekday(DateTime.saturday);

  /// Returns new [Moment] instance of nearest Sunday in the past
  ///
  /// If [this] is Sunday, will return `7 days in the past`
  Moment lastSunday() => lastWeekday(DateTime.sunday);
}
