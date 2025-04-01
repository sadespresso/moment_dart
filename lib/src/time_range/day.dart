import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class DayTimeRange extends TimeRange with PageableRange<DayTimeRange> {
  @override
  final bool isUtc;

  final int year;
  final int month;
  final int day;

  factory DayTimeRange(
    int year,
    int month,
    int day, {
    bool isUtc = false,
  }) {
    final DateTime dateTime = DateTimeConstructors.withTimezone(
      isUtc,
      year,
      month,
      day,
    );

    return DayTimeRange._internal(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      isUtc: dateTime.isUtc,
    );
  }

  const DayTimeRange._internal(
    this.year,
    this.month,
    this.day, {
    this.isUtc = false,
  }) : assert(month > 0 && month <= 12 && day > 0 && day <= 31);

  /// Will preserve the timezone of [dateTime]
  ///
  /// Please note that [hour], [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
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
  DateTime get to => from.endOfDay();

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
