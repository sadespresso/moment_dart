import 'package:moment_dart/moment_dart.dart';

extension YearFinder on DateTime {
  /// Returns a new [DateTime] of same timezone
  DateTime startOfNextYear() =>
      DateTimeConstructors.withTimezone(isUtc, year + 1);

  /// Returns a new [DateTime] of same timezone
  DateTime startOfLastYear() =>
      DateTimeConstructors.withTimezone(isUtc, year - 1);

  /// Returns a new [DateTime] of same timezone
  DateTime endOfNextYear() =>
      DateTimeConstructors.withTimezone(isUtc, year + 1).endOfYear();

  /// Returns a new [DateTime] of same timezone
  DateTime endOfLastYear() =>
      DateTimeConstructors.withTimezone(isUtc, year - 1).endOfYear();
}

extension MonthFinder on DateTime {
  /// Returns a new [DateTime] of same timezone
  DateTime startOfNextMonth() =>
      DateTimeConstructors.withTimezone(isUtc, year, month + 1);

  /// Returns a new [DateTime] of same timezone
  DateTime startOfLastMonth() =>
      DateTimeConstructors.withTimezone(isUtc, year, month - 1);

  /// Returns a new [DateTime] of same timezone
  DateTime endOfNextMonth() =>
      DateTimeConstructors.withTimezone(isUtc, year, month + 1).endOfMonth();

  /// Returns a new [DateTime] of same timezone
  DateTime endOfLastMonth() =>
      DateTimeConstructors.withTimezone(isUtc, year, month - 1).endOfMonth();
}

extension LocalWeekFinder on DateTime {
  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime startOfNextLocalWeek([int? weekStart]) =>
      startOfLocalWeek(weekStart).add(const Duration(days: 7));

  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime startOfLastLocalWeek([int? weekStart]) =>
      startOfLocalWeek(weekStart).subtract(const Duration(days: 7));

  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime endOfNextLocalWeek([int? weekStart]) =>
      endOfLocalWeek(weekStart).add(const Duration(days: 7));

  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime endOfLastLocalWeek([int? weekStart]) =>
      endOfLocalWeek(weekStart).subtract(const Duration(days: 7));
}

extension IsoWeekFinder on DateTime {
  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime startOfNextIsoWeek() => startOfNextLocalWeek(DateTime.monday);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime startOfLastIsoWeek() => startOfLastLocalWeek(DateTime.monday);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime endOfNextIsoWeek() => endOfNextLocalWeek(DateTime.monday);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  DateTime endOfLastIsoWeek() => endOfLastLocalWeek(DateTime.monday);
}

extension DayFinder on DateTime {
  /// Returns a new [DateTime] of same timezone
  DateTime startOfNextDay() =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day + 1);

  /// Returns a new [DateTime] of same timezone
  DateTime startOfLastDay() =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day - 1);

  /// Returns a new [DateTime] of same timezone
  DateTime endOfNextDay() =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day + 1).endOfDay();

  /// Returns a new [DateTime] of same timezone
  DateTime endOfLastDay() =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day - 1).endOfDay();
}

extension HourFinder on DateTime {
  /// Returns a new [DateTime] of same timezone
  DateTime startOfNextHour() =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day, hour + 1);

  /// Returns a new [DateTime] of same timezone
  DateTime startOfLastHour() =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day, hour - 1);

  /// Returns a new [DateTime] of same timezone
  DateTime endOfNextHour() => DateTimeConstructors.withTimezone(
        isUtc,
        year,
        month,
        day,
        hour + 1,
        59,
        59,
        999,
        999,
      );

  /// Returns a new [DateTime] of same timezone
  DateTime endOfLastHour() => DateTimeConstructors.withTimezone(
        isUtc,
        year,
        month,
        day,
        hour - 1,
        59,
        59,
        999,
        999,
      );
}

extension MinuteFinder on DateTime {
  /// Returns a new [DateTime] of same timezone
  DateTime startOfNextMinute() => DateTimeConstructors.withTimezone(
      isUtc, year, month, day, hour, minute + 1);

  /// Returns a new [DateTime] of same timezone
  DateTime startOfLastMinute() => DateTimeConstructors.withTimezone(
      isUtc, year, month, day, hour, minute - 1);

  /// Returns a new [DateTime] of same timezone
  DateTime endOfNextMinute() => DateTimeConstructors.withTimezone(
      isUtc, year, month, day, hour, minute + 1, 59, 999, 999);

  /// Returns a new [DateTime] of same timezone
  DateTime endOfLastMinute() => DateTimeConstructors.withTimezone(
      isUtc, year, month, day, hour, minute - 1, 59, 999, 999);
}

extension YearFinderMoment on Moment {
  /// Returns a new [Moment] of same timezone
  Moment startOfNextYear() =>
      forcedSuperType.startOfNextYear().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment startOfLastYear() =>
      forcedSuperType.startOfLastYear().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfNextYear() =>
      forcedSuperType.endOfNextYear().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfLastYear() =>
      forcedSuperType.endOfLastYear().toMoment(localization: setLocalization);
}

extension MonthFinderMoment on Moment {
  /// Returns a new [Moment] of same timezone
  Moment startOfNextMonth() => forcedSuperType
      .startOfNextMonth()
      .toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment startOfLastMonth() => forcedSuperType
      .startOfLastMonth()
      .toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfNextMonth() =>
      forcedSuperType.endOfNextMonth().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfLastMonth() =>
      forcedSuperType.endOfLastMonth().toMoment(localization: setLocalization);
}

extension LocalWeekFinderMoment on Moment {
  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment startOfNextLocalWeek([int? weekStart]) => forcedSuperType
      .startOfNextLocalWeek(weekStart ?? localization.weekStart)
      .toMoment(localization: setLocalization);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment startOfLastLocalWeek([int? weekStart]) => forcedSuperType
      .startOfLastLocalWeek(weekStart ?? localization.weekStart)
      .toMoment(localization: setLocalization);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment endOfNextLocalWeek([int? weekStart]) => forcedSuperType
      .endOfNextLocalWeek(weekStart ?? localization.weekStart)
      .toMoment(localization: setLocalization);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment endOfLastLocalWeek([int? weekStart]) => forcedSuperType
      .endOfLastLocalWeek(weekStart ?? localization.weekStart)
      .toMoment(localization: setLocalization);
}

extension IsoWeekFinderMoment on Moment {
  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment startOfNextIsoWeek() => forcedSuperType
      .startOfNextLocalWeek(DateTime.monday)
      .toMoment(localization: setLocalization);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment startOfLastIsoWeek() => forcedSuperType
      .startOfLastLocalWeek(DateTime.monday)
      .toMoment(localization: setLocalization);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment endOfNextIsoWeek() => forcedSuperType
      .endOfNextLocalWeek(DateTime.monday)
      .toMoment(localization: setLocalization);

  /// Assumes [this] is in local timezone, but will preserve the timezone
  Moment endOfLastIsoWeek() => forcedSuperType
      .endOfLastLocalWeek(DateTime.monday)
      .toMoment(localization: setLocalization);
}

extension DayFinderMoment on Moment {
  /// Returns a new [Moment] of same timezone
  Moment startOfNextDay() =>
      forcedSuperType.startOfNextDay().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment startOfLastDay() =>
      forcedSuperType.startOfLastDay().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfNextDay() =>
      forcedSuperType.endOfNextDay().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfLastDay() =>
      forcedSuperType.endOfLastDay().toMoment(localization: setLocalization);
}

extension HourFinderMoment on Moment {
  /// Returns a new [Moment] of same timezone
  Moment startOfNextHour() =>
      forcedSuperType.startOfNextHour().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment startOfLastHour() =>
      forcedSuperType.startOfLastHour().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfNextHour() =>
      forcedSuperType.endOfNextHour().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfLastHour() =>
      forcedSuperType.endOfLastHour().toMoment(localization: setLocalization);
}

extension MinuteFinderMoment on Moment {
  /// Returns a new [Moment] of same timezone
  Moment startOfNextMinute() => forcedSuperType
      .startOfNextMinute()
      .toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment startOfLastMinute() => forcedSuperType
      .startOfLastMinute()
      .toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfNextMinute() =>
      forcedSuperType.endOfNextMinute().toMoment(localization: setLocalization);

  /// Returns a new [Moment] of same timezone
  Moment endOfLastMinute() =>
      forcedSuperType.endOfLastMinute().toMoment(localization: setLocalization);
}
