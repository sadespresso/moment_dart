import 'package:moment_dart/src/localizations/utils/duration_unit.dart';

enum DurationInterval {
  //"(in) a few seconds (ago)"
  lessThanASecond(0, unit: DurationUnit.second, singular: false),
  //"(in) a second (ago)"
  aSecond(1, unit: DurationUnit.second, singular: true),
  //"(in) X seconds (ago)"
  seconds(2, unit: DurationUnit.second, singular: false),
  //"(in) a minute (ago)"
  aMinute(3, unit: DurationUnit.minute, singular: true),
  //"(in) X minutes (ago)"
  minutes(4, unit: DurationUnit.minute, singular: false),
  //"(in) an hour (ago)"
  anHour(5, unit: DurationUnit.hour, singular: true),
  //"(in) X hours (ago)"
  hours(6, unit: DurationUnit.hour, singular: false),
  //"(in) a day (ago)"
  aDay(7, unit: DurationUnit.day, singular: true),
  //"(in) X days (ago)"
  days(8, unit: DurationUnit.day, singular: false),
  //"(in) a day (ago)"
  aWeek(9, unit: DurationUnit.week, singular: true),
  //"(in) X days (ago)"
  weeks(10, unit: DurationUnit.week, singular: false),
  //"(in) a month (ago)"
  aMonth(11, unit: DurationUnit.month, singular: true),
  //"(in) X months (ago)"
  months(12, unit: DurationUnit.month, singular: false),
  //"(in) a year (ago)"
  aYear(13, unit: DurationUnit.year, singular: true),
  //"(in) X years (ago)"
  years(14, unit: DurationUnit.year, singular: false);

  final int value;
  final DurationUnit unit;
  final bool singular;

  const DurationInterval(
    this.value, {
    required this.unit,
    this.singular = false,
  });

  /// Returns [DurationInterval] based on value and unit.
  ///
  /// [DurationUnit.microsecond] and [DurationUnit.millisecond] will return
  static DurationInterval findByUnit(int unitValue, DurationUnit unit) {
    final bool singular = unitValue == 1;

    switch (unit) {
      case DurationUnit.microsecond:
      case DurationUnit.millisecond:
        return DurationInterval.lessThanASecond;
      case DurationUnit.second:
        return singular ? DurationInterval.aSecond : DurationInterval.seconds;
      case DurationUnit.minute:
        return singular ? DurationInterval.aMinute : DurationInterval.minutes;
      case DurationUnit.hour:
        return singular ? DurationInterval.anHour : DurationInterval.hours;
      case DurationUnit.day:
        return singular ? DurationInterval.aDay : DurationInterval.days;
      case DurationUnit.week:
        return singular ? DurationInterval.aWeek : DurationInterval.weeks;
      case DurationUnit.month:
        return singular ? DurationInterval.aMonth : DurationInterval.months;
      case DurationUnit.year:
        return singular ? DurationInterval.aYear : DurationInterval.years;
    }
  }
}
