import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/extensions/constructor.dart';

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

  TimeRange toUtc();

  /// In the local timezone
  factory TimeRange.today() => DayTimeRange.fromDateTime(DateTime.now());

  /// In the local timezone
  factory TimeRange.thisMonth() => MonthTimeRange.fromDateTime(DateTime.now());

  /// In the local timezone
  factory TimeRange.thisYear() => YearTimeRange.fromDateTime(DateTime.now());

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

class CustomTimeRange extends TimeRange {
  @override

  /// Returns if [from] is in UTC timezone.
  ///
  /// Does NOT check it [to] is in UTC timezone.
  bool get isUtc => from.isUtc;

  @override
  final DateTime from;
  @override
  final DateTime to;

  /// The timezone is assumed by the [from] passed in here.
  ///
  /// [CustomTimeRange] does NOT ensure that [from] and [to] have the same timezone.
  const CustomTimeRange(this.from, this.to)
      : assert(from <= to, "[from] must be before or equal to [to]");

  @override
  CustomTimeRange toUtc() =>
      isUtc ? this : CustomTimeRange(from.toUtc(), to.toUtc());
}

class DayTimeRange extends TimeRange {
  @override
  final bool isUtc;

  final int year;
  final int month;
  final int day;

  const DayTimeRange(
    this.year,
    this.month,
    this.day, {
    this.isUtc = false,
  });

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
  DateTime get to => from.endOfDay();

  @override
  DayTimeRange toUtc() =>
      isUtc ? this : DayTimeRange(year, month, day, isUtc: true);
}

class LocalWeekTimeRange extends CustomTimeRange {
  LocalWeekTimeRange(DateTime dateTime)
      : super(dateTime.startOfLocalWeek(), dateTime.endOfLocalWeek());

  @override
  CustomTimeRange toUtc() => throw UnsupportedError(
      "Local week time range cannot be converted to UTC");
}

class IsoWeekTimeRange extends CustomTimeRange {
  IsoWeekTimeRange(DateTime dateTime)
      : super(dateTime.startOfLocalWeek(1), dateTime.endOfLocalWeek(1));

  int get weekYear => from.weekYear;
  int get week => from.week;

  @override
  CustomTimeRange toUtc() => throw UnsupportedError(
      "Local week time range cannot be converted to UTC");
}

class MonthTimeRange extends TimeRange {
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
}

class YearTimeRange extends TimeRange {
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
  DateTime get to => from.endOfYear();

  @override
  YearTimeRange toUtc() => isUtc ? this : YearTimeRange(year, isUtc: true);
}
