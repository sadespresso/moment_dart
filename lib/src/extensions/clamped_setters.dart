import 'package:moment_dart/moment_dart.dart';

extension ClampedSetters on DateTime {
  int get lastDayOfMonth => isLeapYear
      ? Moment.daysInMonthsInLeapYear[month]
      : Moment.daysInMonths[month];

  /// Prevents [second] overflows resolving into the next minute by clamping the
  /// second between 0 and 59
  DateTime setClampedSecond(int second) {
    return copyWith(second: second.clamp(0, 59));
  }

  /// Prevents [minute] overflows resolving into the next hour by clamping the
  /// minute between 0 and 59
  DateTime setClampedMinute(int minute) {
    return copyWith(minute: minute.clamp(0, 59));
  }

  /// Prevents [hour] overflows resolving into the next day by clamping the hour
  /// between 0 and 23
  DateTime setClampedHour(int hour) {
    return copyWith(hour: hour.clamp(0, 23));
  }

  /// Prevents [day] overflows resolving into the next month by clamping the day
  /// to between 1 and the last day of the month
  ///
  /// For example, if the current month is February, and the day is 30,
  /// the day will be clamped to 28.
  ///
  /// ```dart
  /// final example = DateTime(2022, DateTime.february, 1);
  /// print(example.setClampedDay(30)); // 2022-02-28 00:00:00.000
  /// ```
  DateTime setClampedDay(int day) {
    return copyWith(day: day.clamp(1, lastDayOfMonth));
  }

  /// Prevents [month] overflows resolving into the next year by clamping the
  /// month between January (1) and December (12). This also clamps the [day]
  /// between 1 and last day of the month if necessary.
  ///
  /// For example, if the current month is December, and the month is February,
  /// the [day] will be clamped between 1 and 28
  ///
  /// ```dart
  /// final example1 = DateTime(2022, DateTime.december, 31);
  /// print(example1.setClampedMonth(DateTime.february)); // 2022-02-28 00:00:00.000
  ///
  /// final example2 = DateTime(2004, DateTime.february, 29);
  /// print(example2.setClampedMonth(DateTime.december)); // 2004-12-29 00:00:00.000
  /// ```
  DateTime setClampedMonth(int month) {
    final clampedMonth =
        month.toInt().clamp(DateTime.january, DateTime.december);
    final clampedDay = day.clamp(
        1,
        isLeapYear
            ? Moment.daysInMonthsInLeapYear[clampedMonth]
            : Moment.daysInMonths[clampedMonth]);

    return copyWith(
      month: clampedMonth,
      day: clampedDay,
    );
  }
}

extension ClampedSettersPlus on Moment {
  Moment setClampedSecond(int second) =>
      copyWith(dateTime: forcedSuperType.setClampedSecond(second));

  Moment setClampedMinute(int minute) =>
      copyWith(dateTime: forcedSuperType.setClampedMinute(minute));

  Moment setClampedHour(int hour) =>
      copyWith(dateTime: forcedSuperType.setClampedHour(hour));

  Moment setClampedDay(int day) =>
      copyWith(dateTime: forcedSuperType.setClampedDay(day));

  Moment setClampedMonth(int month) => copyWith(
        dateTime: forcedSuperType.setClampedMonth(month),
      );
}
