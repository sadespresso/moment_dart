import 'package:moment_dart/moment_dart.dart';

export 'time_range/day.dart';
export 'time_range/week.dart';
export 'time_range/month.dart';
export 'time_range/year.dart';
export 'time_range/custom.dart';

abstract class TimeRange {
  const TimeRange();

  bool get isUtc;

  DateTime get from;
  DateTime get to;

  /// Returns true if [dateTime] is between [from] and [to] (inclusive)
  bool contains(DateTime dateTime) => from <= dateTime && dateTime <= to;

  /// Returns true if [this] contains [timeRange]
  bool containsRange(TimeRange timeRange) =>
      timeRange.from >= from && timeRange.to <= to;

  Duration get duration => to.difference(from);

  /// Unless you're using CustomTimeRange, this will always keep the
  /// properties like [year], [month] the same.
  ///
  /// TL;DR, the following is NOT same.
  ///
  /// * `TimeRange().toUtc().from != TimeRange().from.toUtc()`
  /// * `TimeRange().toUtc().to != TimeRange().to.toUtc()`
  ///
  /// For example,
  ///
  /// ```dart
  /// final yearRange = YearTimeRange(2022);
  ///
  /// print(yearRange.from.year); // 2022
  /// print(yearRagne.toUtc().from.year); // 2022
  /// ```
  /// But as DateTime(2022, DateTime.january, 1) can be in the year 2021 in
  /// certain timezones.
  /// ```dart
  /// print(yearRange.from.toUtc().year); // Depending on the time zone, 2021 or 2022
  /// ```
  TimeRange toUtc();

  /// In the local timezone
  factory TimeRange.today() => DayTimeRange.fromDateTime(DateTime.now());

  /// In the local timezone
  factory TimeRange.tomorrow() =>
      DayTimeRange.fromDateTime(Moment.startOfTomorrow());

  /// In the local timezone
  factory TimeRange.yesterday() =>
      DayTimeRange.fromDateTime(Moment.startOfYesterday());

  /// In the local timezone
  factory TimeRange.thisMonth() => MonthTimeRange.fromDateTime(DateTime.now());

  /// In the local timezone
  factory TimeRange.nextMonth() =>
      MonthTimeRange.fromDateTime(Moment.startOfNextMonth());

  /// In the local timezone
  factory TimeRange.lastMonth() =>
      MonthTimeRange.fromDateTime(Moment.startOfLastMonth());

  /// In the local timezone
  factory TimeRange.thisYear() => YearTimeRange.fromDateTime(DateTime.now());

  /// In the local timezone
  factory TimeRange.nextYear() =>
      YearTimeRange.fromDateTime(Moment.startOfNextYear());

  /// In the local timezone
  factory TimeRange.lastYear() =>
      YearTimeRange.fromDateTime(Moment.startOfLastYear());

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType) return false;

    return other is TimeRange &&
        from == other.from &&
        to == other.to &&
        isUtc == other.isUtc;
  }

  @override
  int get hashCode => Object.hash(from, to, isUtc);

  @override
  String toString() => "TimeRange($from -> $to)";
}
