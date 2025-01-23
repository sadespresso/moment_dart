import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class DayTimeRange extends TimeRange with PageableRange<DayTimeRange> {
  @override
  final bool isUtc;

  final int year;
  final int month;
  final int day;

  /// Please note that [hour], [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
  const DayTimeRange(
    this.year,
    this.month,
    this.day, {
    this.isUtc = false,
  }) : assert(month > 0 && month <= 12 && day > 0 && day <= 31);

  /// Will preserve the timezone of [dateTime]
  factory DayTimeRange.fromDateTime(DateTime dateTime) => DayTimeRange(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        isUtc: dateTime.isUtc,
      );

  @override
  DateTime get from =>
      DateTimeConstructors.withTimezone(isUtc, year, month, day);

  @override
  DateTime get to => from.startOfNextDay();

  @override
  DurationUnit get unit => DurationUnit.day;

  @override
  DayTimeRange toUtc() =>
      isUtc ? this : DayTimeRange(year, month, day, isUtc: true);

  @override
  DayTimeRange get next => DayTimeRange(year, month, day + 1, isUtc: isUtc);

  @override
  DayTimeRange get last => DayTimeRange(year, month, day - 1, isUtc: isUtc);
}
