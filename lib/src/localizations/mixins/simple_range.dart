import 'package:moment_dart/src/localization.dart';
import 'package:moment_dart/src/moment.dart';

class SimpleRangeData {
  final String thisWeek;
  final String nextWeek;
  final String lastWeek;

  final String thisMonth;

  final String thisYear;

  final String Function(YearTimeRange) year;

  final String Function(MonthTimeRange) month;

  /// When end date equals [Moment.maxValue]
  ///
  /// For example: "After %", where "%" is same value as [srDelta]
  final String customRangeAfter;

  /// When end date equals [Moment.maxValue]
  ///
  /// For example: "Before %", where "%" is same value as [srDelta]
  final String customRangeBefore;

  /// Delimiter for custom range
  ///
  /// For example, when set to " - ",
  /// output will look like "2021-01-01 - 2021-01-31"
  ///
  /// Defaults to " - "
  final String customRangeDelimiter;

  /// Reverses order of `from` and `to`
  final bool reverseRangeDates;

  const SimpleRangeData({
    required this.reverseRangeDates,
    required this.thisWeek,
    required this.nextWeek,
    required this.lastWeek,
    required this.thisMonth,
    required this.thisYear,
    required this.year,
    required this.month,
    required this.customRangeAfter,
    required this.customRangeBefore,
    required this.customRangeDelimiter,
  });
}

mixin SimpleRange on MomentLocalization {
  /// This is used as a placeholder for date/range in since/before
  String get srDelta => "%";

  SimpleRangeData get simpleRangeData;

  String range(TimeRange range, {DateTime? anchor}) {
    anchor ??= Moment.now();

    if (range is CustomTimeRange) {
      return SimpleRange.customRange(range, this);
    }

    if (range is YearTimeRange) {
      if (range.year == anchor.year) {
        return simpleRangeData.thisYear;
      }

      return simpleRangeData.year(range);
    }

    if (range is MonthTimeRange) {
      if (range.month == anchor.month) {
        return simpleRangeData.thisMonth;
      }

      return simpleRangeData.month(range);
    }

    if (range is DayTimeRange) {
      return range.from.toMoment(localization: this).calendar(omitHours: true);
    }

    // if

    return "";
  }

  static String customRange(CustomTimeRange custom, SimpleRange localization) {
    if (custom.to == Moment.maxValue) {
      return localization.customRangeAfter.replaceAll(localization.srDelta,
          custom.from.toMoment(localization: localization).calendar());
    }
    if (custom.from == Moment.minValue) {
      return localization.customRangeBefore.replaceAll(localization.srDelta,
          custom.to.toMoment(localization: localization).calendar());
    }

    final String from = custom.from
        .toMoment(localization: localization)
        .calendar(omitHours: true);
    final String to = custom.to
        .toMoment(localization: localization)
        .calendar(omitHours: true);

    final List<String> parts = [from, to];

    return localization.reverseRangeDates
        ? parts.reversed.join(localization.customRangeDelimiter)
        : parts.join(localization.customRangeDelimiter);
  }
}
