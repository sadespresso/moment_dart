import 'package:moment_dart/src/extensions.dart';
import 'package:moment_dart/src/time_range.dart';

class HourTimeRange extends TimeRange with PageableRange<HourTimeRange> {
  @override
  final bool isUtc;

  final int year;
  final int month;
  final int day;
  final int hour;

  /// Set only for the second occurrence of a local hour that repeats when the
  /// clock falls back, which [year]..[hour] alone can't tell apart.
  final DateTime? _from;

  /// Please note that  [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
  factory HourTimeRange(
    int year,
    int month,
    int day,
    int hour, {
    bool isUtc = false,
  }) {
    final DateTime dateTime = DateTimeConstructors.withTimezone(
      isUtc,
      year,
      month,
      day,
      hour,
    );

    return HourTimeRange._internal(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      isUtc: dateTime.isUtc,
    );
  }

  /// Please note that  [minute], [second], [millisecond], [microsecond]
  /// will be ignored.
  const HourTimeRange._internal(
    this.year,
    this.month,
    this.day,
    this.hour, {
    this.isUtc = false,
    DateTime? from,
  })  : _from = from,
        assert(month > 0 &&
            month <= 12 &&
            day > 0 &&
            day <= 31 &&
            hour >= 0 &&
            hour < 24);

  /// Will preserve the timezone of [dateTime]
  factory HourTimeRange.fromDateTime(DateTime dateTime) {
    final HourTimeRange range = HourTimeRange(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      isUtc: dateTime.isUtc,
    );

    final DateTime startOfHour = dateTime.subtract(Duration(
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond,
    ));

    if (startOfHour == range.from ||
        startOfHour.hour != range.hour ||
        startOfHour.minute != 0) {
      return range;
    }

    return HourTimeRange._internal(
      range.year,
      range.month,
      range.day,
      range.hour,
      isUtc: range.isUtc,
      from: startOfHour,
    );
  }

  @override
  DateTime get from =>
      _from ?? DateTimeConstructors.withTimezone(isUtc, year, month, day, hour);

  @override
  DateTime get to => _from == null
      ? from.endOfHour()
      : from.add(const Duration(hours: 1) - const Duration(microseconds: 1));

  @override
  DurationUnit get unit => DurationUnit.hour;

  @override
  HourTimeRange toUtc() =>
      isUtc ? this : HourTimeRange(year, month, day, hour, isUtc: true);

  @override
  HourTimeRange get next =>
      HourTimeRange.fromDateTime(from.add(const Duration(hours: 1)));

  @override
  HourTimeRange get last =>
      HourTimeRange.fromDateTime(from.subtract(const Duration(hours: 1)));
}
