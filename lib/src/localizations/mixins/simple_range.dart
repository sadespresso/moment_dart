import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/moment.dart';

class SimpleRangeData {
  final String thisWeek;

  final String thisMonth;

  final String thisYear;

  final String Function(YearTimeRange) year;

  final String Function(MonthTimeRange) month;

  /// When end date equals [Moment.maxValue]
  ///
  /// For example, in en_US,
  /// (formattedDate) => "After $formattedDate"
  final String Function(String formattedDate) allAfter;

  /// When start date equals [Moment.minValue]
  ///
  /// For example, in en_US,
  /// (formattedDate) => "Before $formattedDate"
  final String Function(String formattedDate) allBefore;

  /// When range [from] is equal to [Moment.minValue] and
  /// [to] is equal to [Moment.maxValue]
  ///
  /// For example, in en_US,
  /// "All time"
  final String customRangeAllTime;

  /// Delimiter for custom range
  ///
  /// For example, when set to " - ",
  /// output will look like "2021-01-01 - 2021-01-31"
  ///
  /// Defaults to " - "
  final String customRangeDelimiter;

  /// Reverses order of `from` and `to`
  ///
  /// Defaults to [false]
  final bool reverseRangeDates;

  const SimpleRangeData({
    required this.thisWeek,
    required this.thisMonth,
    required this.thisYear,
    required this.year,
    required this.month,
    required this.allAfter,
    required this.allBefore,
    required this.customRangeAllTime,
    this.customRangeDelimiter = " - ",
    this.reverseRangeDates = false,
  });
}

mixin SimpleRange on MomentLocalization {
  SimpleRangeData get simpleRangeData;

  @override
  String range(TimeRange range, {DateTime? anchor, bool useRelative = true}) {
    anchor ??= Moment.now();

    if (range is HourTimeRange ||
        range is DayTimeRange ||
        range is IsoWeekTimeRange) {
      return super.range(range, anchor: anchor, useRelative: useRelative);
    } else if (range is LocalWeekTimeRange) {
      if (useRelative && range.from == anchor.startOfLocalWeek(weekStart)) {
        return simpleRangeData.thisWeek;
      }

      return super.range(range, anchor: anchor, useRelative: useRelative);
    } else if (range is MonthTimeRange) {
      if (useRelative && range.month == anchor.month) {
        return simpleRangeData.thisMonth;
      }

      return simpleRangeData.month(range);
    } else if (range is YearTimeRange) {
      if (useRelative && range.year == anchor.year) {
        return simpleRangeData.thisYear;
      }

      return simpleRangeData.year(range);
    }

    return _customRange(range, this);
  }

  static String _customRange(
    TimeRange custom,
    SimpleRange localization, {
    DateTime? anchor,
  }) {
    if (custom.to == Moment.maxValue) {
      final String formattedDate = custom.from
          .toMoment(localization: localization)
          .calendar(omitHours: custom.from.isMidnight, reference: anchor);

      return localization.simpleRangeData.allAfter(formattedDate);
    }
    if (custom.from == Moment.minValue) {
      final String formattedDate = custom.to
          .toMoment(localization: localization)
          .calendar(omitHours: custom.to.isMidnight, reference: anchor);

      return localization.simpleRangeData.allBefore(formattedDate);
    }

    final bool omitHours = custom.from.isMidnight && custom.to.isMidnight;

    final String from = custom.from
        .toMoment(localization: localization)
        .calendar(omitHours: omitHours, reference: anchor);
    final String to = custom.to
        .toMoment(localization: localization)
        .calendar(omitHours: omitHours, reference: anchor);

    final List<String> parts = [from, to];

    return localization.simpleRangeData.reverseRangeDates
        ? parts.reversed.join(localization.simpleRangeData.customRangeDelimiter)
        : parts.join(localization.simpleRangeData.customRangeDelimiter);
  }
}
