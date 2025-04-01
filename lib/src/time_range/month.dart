import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class MonthTimeRange extends TimeRange with PageableRange<MonthTimeRange> {
  @override
  final bool isUtc;

  final int year;
  final int month;

  factory MonthTimeRange(
    int year,
    int month, {
    bool isUtc = false,
  }) {
    final DateTime date = DateTimeConstructors.withTimezone(isUtc, year, month);
    return MonthTimeRange._internal(date.year, date.month, isUtc: date.isUtc);
  }

  const MonthTimeRange._internal(
    this.year,
    this.month, {
    this.isUtc = false,
  }) : assert(month > 0 && month <= 12);

  /// Will preserve the timezone of [dateTime]
  ///
  /// Please note that [day], [hour], [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
  factory MonthTimeRange.fromDateTime(DateTime dateTime) => MonthTimeRange(
        dateTime.year,
        dateTime.month,
        isUtc: dateTime.isUtc,
      );

  @override
  DateTime get from => DateTimeConstructors.withTimezone(isUtc, year, month);

  @override
  DateTime get to => from.endOfMonth();

  @override
  DurationUnit get unit => DurationUnit.month;

  @override
  MonthTimeRange toUtc() =>
      isUtc ? this : MonthTimeRange(year, month, isUtc: true);

  @override
  MonthTimeRange get next => MonthTimeRange(year, month + 1, isUtc: isUtc);

  @override
  MonthTimeRange get last => MonthTimeRange(year, month - 1, isUtc: isUtc);
}
