import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class HourTimeRange extends TimeRange with PageableRange<HourTimeRange> {
  @override
  final bool isUtc;

  final int year;
  final int month;
  final int day;
  final int hour;

  /// Please note that  [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
  const HourTimeRange(
    this.year,
    this.month,
    this.day,
    this.hour, {
    this.isUtc = false,
  }) : assert(month > 0 &&
            month <= 12 &&
            day > 0 &&
            day <= 31 &&
            hour >= 0 &&
            hour < 24);

  /// Will preserve the timezone of [dateTime]
  factory HourTimeRange.fromDateTime(DateTime dateTime) => HourTimeRange(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        isUtc: dateTime.isUtc,
      );

  @override
  DateTime get from =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day, hour);

  @override
  DateTime get to => from.startOfNextHour();

  @override
  DurationUnit get unit => DurationUnit.hour;

  @override
  HourTimeRange toUtc() =>
      isUtc ? this : HourTimeRange(year, month, day, hour, isUtc: true);

  @override
  HourTimeRange get next => HourTimeRange(
        year,
        month,
        day,
        hour + 1,
        isUtc: isUtc,
      );

  @override
  HourTimeRange get last => HourTimeRange(
        year,
        month,
        day,
        hour - 1,
        isUtc: isUtc,
      );
}
