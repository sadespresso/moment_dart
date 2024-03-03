import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/extensions/constructor.dart';
import 'package:moment_dart/src/time_range.dart';
import 'package:moment_dart/src/time_range/pageable_range.dart';

class MonthTimeRange extends TimeRange with PageableRange<MonthTimeRange> {
  @override
  final bool isUtc;

  final int year;
  final int month;

  const MonthTimeRange(
    this.year,
    this.month, {
    this.isUtc = false,
  });

  /// Will preserve the timezone of [dateTime]
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
  MonthTimeRange toUtc() =>
      isUtc ? this : MonthTimeRange(year, month, isUtc: true);

  @override
  MonthTimeRange get next => MonthTimeRange(year, month + 1, isUtc: isUtc);

  @override
  MonthTimeRange get last => MonthTimeRange(year, month - 1, isUtc: isUtc);
}
