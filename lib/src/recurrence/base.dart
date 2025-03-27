import "dart:math" as math;

import "package:json_annotation/json_annotation.dart";
import "package:moment_dart/moment_dart.dart";

@JsonEnum(valueField: "value")
enum RecurrenceType {
  /// Every occurrence of chosen weekday
  ///
  /// e.g., every Monday, Wednesday, and Friday
  weekday("weekday"),

  /// Every nth day of the month
  ///
  /// Will be clamped to 28-31 depending on the month
  ///
  /// e.g., every 1st, 15th, and 30th day of the month (clamped down to 28th, or 29th on February depending on the year for example)
  monthly("monthly"),

  /// Every month-day combination
  ///
  /// e.g., December 31st, January 1st, and February 29th (clamped down to February 28th on non-leap years)
  yearly("yearly"),

  /// Every nth day from the start date
  ///
  /// e.g., every 3 days starting Jan 1 -> Jan 1, Jan 4, Jan 7, Jan 10, ...
  everyNthDay("everyNthDay");

  final String value;

  const RecurrenceType(this.value);
}

abstract class Recurrence<T> {
  const Recurrence();

  RecurrenceType get type;
  T get data;

  /// Returns the next occurrence after [from]
  ///
  /// If [from] is a valid occurence, still ignores it and gives the next one.
  ///
  /// If [range] isn't null, and the next occurrence is outside of the range (the range is inclusive),
  /// returns null
  ///
  /// This function does not check for time zones (utc, local). It's recommended to use [DateTime] with local time zone.
  DateTime? nextOccurrence(DateTime from, {TimeRange? range});

  /// Returns the previous occurrence before [from]
  ///
  /// If [from] is a valid occurence, still ignores it and gives the previous one.
  ///
  /// If [range] isn't null, and the previous occurrence is outside of the range (the range is inclusive),
  /// returns null
  ///
  /// This function does not check for time zones (utc, local). It's recommended to use [DateTime] with local time zone.
  DateTime? previousOccurrence(DateTime from, {TimeRange? range});

  /// Returns all occurrences within [range] (inclusive)
  List<DateTime> occurrences({required TimeRange range});
}

class WeekdayRecurrence extends Recurrence<int> {
  /// Same number as DateTime defined weekdays.
  ///
  /// * 1 is Monday (same as [DateTime.monday])
  /// * 7 is Sunday (same as [DateTime.sunday])
  @override
  final int data;

  const WeekdayRecurrence({required this.data})
    : assert(data >= DateTime.monday && data <= DateTime.sunday);

  @override
  DateTime? nextOccurrence(DateTime from, {TimeRange? range}) {
    final next = from.nextWeekday(data);

    if (range != null && !range.contains(next)) {
      return null;
    }

    return next;
  }

  @override
  DateTime? previousOccurrence(DateTime from, {TimeRange? range}) {
    final previous = from.lastWeekday(data);

    if (range != null && !range.contains(previous)) {
      return null;
    }

    return previous;
  }

  @override
  List<DateTime> occurrences({required TimeRange range}) {
    final List<DateTime> result = [];

    if (range.from.weekday == data) result.add(range.from);

    for (;;) {
      final DateTime next = result.last.nextWeekday(data);

      if (!range.contains(next)) {
        break;
      }

      result.add(next);
    }

    return result;
  }

  @override
  RecurrenceType get type => RecurrenceType.weekday;
}

class MonthlyRecurrence extends Recurrence<int> {
  /// Allowed range is [1,31], this is not enforced, expect unexpected behavior
  /// for illegal values.
  @override
  final int data;

  const MonthlyRecurrence({required this.data})
    : assert(data >= 1 && data <= 31);

  @override
  DateTime? nextOccurrence(DateTime from, {TimeRange? range}) {
    if (from.day > data) {
      final DateTime endOfMonth = from.endOfMonth().startOfDay();

      final DateTime next = DateTimeConstructors.dateWithTimezone(
        endOfMonth.year,
        endOfMonth.month,
        math.min(endOfMonth.day, data),
      );

      return next;
    }

    final DateTime endOfNextMonth = from.endOfNextMonth().startOfDay();

    final next = DateTimeConstructors.dateWithTimezone(
      endOfNextMonth.year,
      endOfNextMonth.month,
      math.min(endOfNextMonth.day, data),
    );

    if (range != null && !range.contains(next)) {
      return null;
    }

    return next;
  }

  @override
  DateTime? previousOccurrence(DateTime from, {TimeRange? range}) {
    if (data < from.day) {
      final DateTime endOfMonth = from.endOfMonth().startOfDay();

      final DateTime previous = DateTimeConstructors.dateWithTimezone(
        endOfMonth.year,
        endOfMonth.month,
        math.min(endOfMonth.day, data),
      );

      return previous;
    }

    final DateTime endOfLastMonth = from.endOfLastMonth().startOfDay();

    final previous = DateTimeConstructors.dateWithTimezone(
      endOfLastMonth.year,
      endOfLastMonth.month,
      math.min(endOfLastMonth.day, data),
    );

    if (range != null && !range.contains(previous)) {
      return null;
    }

    return previous;
  }

  @override
  List<DateTime> occurrences({required TimeRange range}) {
    final List<DateTime> result = [];

    final DateTime endOfFromMonth = range.from.endOfMonth().startOfDay();

    final DateTime start = DateTimeConstructors.dateWithTimezone(
      range.from.year,
      range.from.month,
      math.min(endOfFromMonth.day, data),
    );

    if (range.from == start) {
      result.add(start);
    }

    for (;;) {
      final next = nextOccurrence(range.from, range: range);

      if (next == null) {
        break;
      }

      result.add(next);
    }

    return result;
  }

  @override
  RecurrenceType get type => RecurrenceType.monthly;
}

class YearlyRecurrence extends Recurrence<({int month, int day})> {
  /// Tuple of (int month, int day)
  /// Allowed range is [1,31], this is not enforced, expect unexpected behavior
  /// for illegal values.
  @override
  final ({int month, int day}) data;

  const YearlyRecurrence({required this.data});

  @override
  DateTime? nextOccurrence(DateTime from, {TimeRange? range}) {
    final DateTime endOfMonth = from

    final next = DateTimeConstructors.dateWithTimezone(
      endOfNextYear.year,
      data.item2,
      math.min(endOfNextYear.day, data.item1),
    );

    if (range != null && !range.contains(next)) {
      return null;
    }

    return next;
  }

  @override
  DateTime? previousOccurrence(DateTime from, {TimeRange? range}) {
    final DateTime endOfLastYear = from.endOfLastYear().startOfDay();

    final previous = DateTimeConstructors.dateWithTimezone(
      endOfLastYear.year,
      data.item2,
      math.min(endOfLastYear.day, data.item1),
    );

    if (range != null && !range.contains(previous)) {
      return null;
    }

    return previous;
  }

  @override
  List<DateTime> occurrences({required TimeRange range}) {
    final List<DateTime> result = [];

    final DateTime endOfFromYear = range.from.endOfYear().startOfDay();

    final DateTime start = DateTimeConstructors.dateWithTimezone(
      range.from.year,
      data.item2,
      math.min(endOfFromYear.day, data.item1),
    );

    if (range.from == start) {
      result.add(start);
    }

    for (;;) {
      final next = nextOccurrence(range.from, range: range);

      if (next == null) {
        break;
      }

      result.add(next);
    }

    return result;
  }

  @override
  RecurrenceType get type => RecurrenceType.yearly;
}
