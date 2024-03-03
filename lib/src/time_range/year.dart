import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';
import 'package:moment_dart/src/time_range/pageable_range.dart';

class YearTimeRange extends TimeRange with PageableRange<YearTimeRange> {
  @override
  final bool isUtc;

  final int year;

  const YearTimeRange(
    this.year, {
    this.isUtc = false,
  });

  /// Will preserve the timezone of [dateTime]
  factory YearTimeRange.fromDateTime(DateTime dateTime) =>
      YearTimeRange(dateTime.year, isUtc: dateTime.isUtc);

  @override
  DateTime get from => DateTimeConstructors.withTimezone(isUtc, year);

  @override
  DateTime get to => from.startOfNextYear();

  @override
  YearTimeRange toUtc() => isUtc ? this : YearTimeRange(year, isUtc: true);

  @override
  YearTimeRange get next => YearTimeRange(year + 1, isUtc: isUtc);

  @override
  YearTimeRange get last => YearTimeRange(year - 1, isUtc: isUtc);
}
