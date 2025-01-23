import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class YearTimeRange extends TimeRange with PageableRange<YearTimeRange> {
  @override
  final bool isUtc;

  final int year;

  factory YearTimeRange(
    int year, {
    bool isUtc = false,
  }) {
    final DateTime dateTime = DateTimeConstructors.withTimezone(isUtc, year);
    return YearTimeRange._internal(dateTime.year, isUtc: dateTime.isUtc);
  }

  const YearTimeRange._internal(
    this.year, {
    this.isUtc = false,
  });

  /// Will preserve the timezone of [dateTime]
  ///
  /// Please note that [month], [day], [hour], [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
  factory YearTimeRange.fromDateTime(DateTime dateTime) =>
      YearTimeRange(dateTime.year, isUtc: dateTime.isUtc);

  @override
  DateTime get from => DateTimeConstructors.withTimezone(isUtc, year);

  @override
  DateTime get to => from.startOfNextYear();

  @override
  DurationUnit get unit => DurationUnit.year;

  @override
  YearTimeRange toUtc() => isUtc ? this : YearTimeRange(year, isUtc: true);

  @override
  YearTimeRange get next => YearTimeRange(year + 1, isUtc: isUtc);

  @override
  YearTimeRange get last => YearTimeRange(year - 1, isUtc: isUtc);
}
