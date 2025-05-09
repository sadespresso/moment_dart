import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  const aMicrosecond = Duration(microseconds: 1);
  group("Equality", () {
    final now = DateTime.now();

    test("TimeRange Factories", () {
      expect(
        TimeRange.allTime() ==
            CustomTimeRange(Moment.minValue, Moment.maxValue),
        true,
      );
      expect(
        TimeRange.allTime() ==
            CustomTimeRange(Moment.minValueUtc, Moment.maxValueUtc),
        false,
      );
      expect(
        TimeRange.today() == DayTimeRange.fromDateTime(now),
        true,
      );
      expect(
        TimeRange.tomorrow() ==
            DayTimeRange.fromDateTime(Moment.startOfTomorrow()),
        true,
      );
      expect(
        TimeRange.yesterday() ==
            DayTimeRange.fromDateTime(Moment.startOfYesterday()),
        true,
      );
      expect(
        TimeRange.thisMonth() == MonthTimeRange.fromDateTime(now),
        true,
      );
      expect(
        TimeRange.nextMonth() ==
            MonthTimeRange.fromDateTime(Moment.startOfNextMonth()),
        true,
      );
      expect(
        TimeRange.lastMonth() ==
            MonthTimeRange.fromDateTime(Moment.startOfLastMonth()),
        true,
      );
      expect(
        TimeRange.thisYear() == YearTimeRange.fromDateTime(now),
        true,
      );
      expect(
        TimeRange.nextYear() ==
            YearTimeRange.fromDateTime(Moment.startOfNextYear()),
        true,
      );
      expect(
        TimeRange.lastYear() ==
            YearTimeRange.fromDateTime(Moment.startOfLastYear()),
        true,
      );
    });
    test("Different timezones", () {
      expect(
        TimeRange.today() == DayTimeRange.fromDateTime(now.toUtc()),
        false,
      );
      expect(
        TimeRange.tomorrow() ==
            DayTimeRange.fromDateTime(Moment.startOfTomorrow().toUtc()),
        false,
      );
      expect(
        TimeRange.yesterday() ==
            DayTimeRange.fromDateTime(Moment.startOfYesterday().toUtc()),
        false,
      );
      expect(
        TimeRange.thisMonth() == MonthTimeRange.fromDateTime(now.toUtc()),
        false,
      );
      expect(
        TimeRange.nextMonth() ==
            MonthTimeRange.fromDateTime(Moment.startOfNextMonth().toUtc()),
        false,
      );
      expect(
        TimeRange.lastMonth() ==
            MonthTimeRange.fromDateTime(Moment.startOfLastMonth().toUtc()),
        false,
      );
      expect(
        TimeRange.thisYear() == YearTimeRange.fromDateTime(now.toUtc()),
        false,
      );
      expect(
        TimeRange.nextYear() ==
            YearTimeRange.fromDateTime(Moment.startOfNextYear().toUtc()),
        false,
      );
      expect(
        TimeRange.lastYear() ==
            YearTimeRange.fromDateTime(Moment.startOfLastYear().toUtc()),
        false,
      );
    });
    test("different types shouldn't be equal", () {
      final DateTime now = Moment.startOfToday();

      final TimeRange today = TimeRange.today();
      final CustomTimeRange todayCustom = CustomTimeRange(now, now.endOfDay());

      expect(today == todayCustom, false);
      expect(today.from == todayCustom.from, true);
      expect(today.to == todayCustom.to, true);

      final TimeRange thisMonth = TimeRange.thisMonth();
      final CustomTimeRange thisMonthCustom =
          CustomTimeRange(now.startOfMonth(), now.endOfMonth());

      expect(thisMonth == thisMonthCustom, false);
      expect(thisMonth.from == thisMonthCustom.from, true);
      expect(thisMonth.to == thisMonthCustom.to, true);

      final TimeRange thisYear = TimeRange.thisYear();
      final CustomTimeRange thisYearCustom =
          CustomTimeRange(now.startOfYear(), now.endOfYear());

      expect(thisYear == thisYearCustom, false);
      expect(thisYear.from == thisYearCustom.from, true);
      expect(thisYear.to == thisYearCustom.to, true);
    });
  });

  group("Duration", () {
    test("Day", () {
      final TimeRange today = TimeRange.today();
      expect(today.duration, Duration(days: 1) - aMicrosecond);
    });

    test("Month days", () {
      for (final year in [1970, 2000, 2020, 2021, 2024]) {
        for (final month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) {
          final MonthTimeRange monthRange = MonthTimeRange(year, month);
          expect(
              monthRange.duration,
              Duration(days: DateTime(year, month).endOfMonth().day) -
                  aMicrosecond);
        }
      }
    });

    test("Year days", () {
      for (final year in [1970, 2000, 2020, 2021, 2024]) {
        final YearTimeRange yearRange = YearTimeRange(year);
        expect(
          yearRange.duration,
          Duration(days: DateTime(year).endOfYear().dayOfYear) - aMicrosecond,
        );
      }
    });
  });

  test("Local week cannot be converted to UTC", () {
    final DateTime now = DateTime.now();
    final TimeRange localWeek = LocalWeekTimeRange(now);
    expect(() => localWeek.toUtc(), throwsUnsupportedError);
  });

  test("ISO week", () {
    final DateTime now = DateTime.now();
    final IsoWeekTimeRange isoWeek = IsoWeekTimeRange(now);
    expect(() => isoWeek.toUtc(), throwsUnsupportedError);
    expect(isoWeek.weekYear, now.weekYear);
    expect(isoWeek.week, now.week);

    final DateTime epoch = DateTime.fromMicrosecondsSinceEpoch(0);
    final IsoWeekTimeRange epochIsoWeek = IsoWeekTimeRange(epoch);
    expect(() => epochIsoWeek.toUtc(), throwsUnsupportedError);
    expect(epochIsoWeek.weekYear, epoch.weekYear);
    expect(epochIsoWeek.week, epoch.week);
  });

  test("MonthTimeRange", () {
    final DateTime now = DateTime.now();
    final MonthTimeRange monthRange = MonthTimeRange.fromDateTime(now);

    // Because [MonthTimeRange] constructs the [DateTime] itself,
    // we can't do `month.from.toUtc()`
    expect(monthRange.toUtc().isUtc, true);
    expect(monthRange.toUtc().from, DateTime.utc(now.year, now.month));
    expect(
        monthRange.toUtc().to, DateTime.utc(now.year, now.month).endOfMonth());
  });

  test("YearTimeRange", () {
    final DateTime now = DateTime.now();
    final YearTimeRange yearRange = YearTimeRange.fromDateTime(now);

    // Because [YearTimeRange] constructs the [DateTime] itself,
    // we can't do `year.from.toUtc()`
    expect(yearRange.toUtc().isUtc, true);
    expect(yearRange.toUtc().from, DateTime.utc(now.year));
    expect(yearRange.toUtc().to, DateTime.utc(now.year).endOfYear());
  });

  test("CustomTimeRange", () {
    final DateTime epoch = DateTime.fromMicrosecondsSinceEpoch(0);
    final DateTime now = DateTime.now();
    final CustomTimeRange customRange = CustomTimeRange(epoch, now);
    expect(customRange.toUtc().isUtc, true);
    expect(customRange.toUtc().from, customRange.from.toUtc());
    expect(customRange.toUtc().to, customRange.to.toUtc());
  });

  group("Contains", () {
    test("Day", () {
      final DateTime now = DateTime.now();
      final TimeRange today = TimeRange.today();
      expect(today.contains(now), true);
      expect(today.contains(now.startOfDay()), true);
      expect(today.contains(now.endOfDay()), true);
      expect(today.contains(today.from - aMicrosecond), false);
      expect(today.contains(today.to + aMicrosecond), false);
    });

    test("Month", () {
      final DateTime now = DateTime.now();
      final TimeRange thisMonth = TimeRange.thisMonth();
      expect(thisMonth.contains(now), true);
      expect(thisMonth.contains(now.startOfMonth()), true);
      expect(thisMonth.contains(now.endOfMonth()), true);
      expect(thisMonth.contains(thisMonth.from - aMicrosecond), false);
      expect(thisMonth.contains(thisMonth.to + aMicrosecond), false);
    });

    test("Year", () {
      final DateTime now = DateTime.now();
      final TimeRange thisYear = TimeRange.thisYear();
      expect(thisYear.contains(now), true);
      expect(thisYear.contains(now.startOfYear()), true);
      expect(thisYear.contains(now.endOfYear()), true);
      expect(thisYear.contains(thisYear.from - aMicrosecond), false);
      expect(thisYear.contains(thisYear.to + aMicrosecond), false);
    });

    test("Custom", () {
      final DateTime now = DateTime.now();
      final CustomTimeRange customRange =
          CustomTimeRange(now, now.add(Duration(days: 1)));
      expect(customRange.contains(now), true);
      expect(customRange.contains(customRange.from), true);
      expect(customRange.contains(customRange.to), true);
      expect(customRange.contains(customRange.from - aMicrosecond), false);
      expect(customRange.contains(customRange.to + aMicrosecond), false);
    });
  });

  test("next/last time ranges", () {
    final HourTimeRange thisHour = TimeRange.thisHour();
    final HourTimeRange nextHour = TimeRange.nextHour();
    final HourTimeRange lastHour = TimeRange.lastHour();
    final DayTimeRange today = TimeRange.today();
    final DayTimeRange tomorrow = TimeRange.tomorrow();
    final DayTimeRange yesterday = TimeRange.yesterday();
    final LocalWeekTimeRange thisLocalWeek = TimeRange.thisLocalWeek();
    final LocalWeekTimeRange nextLocalWeek = TimeRange.nextLocalWeek();
    final LocalWeekTimeRange lastLocalWeek = TimeRange.lastLocalWeek();
    final IsoWeekTimeRange thisIsoWeek = TimeRange.thisIsoWeek();
    final IsoWeekTimeRange nextIsoWeek = TimeRange.nextIsoWeek();
    final IsoWeekTimeRange lastIsoWeek = TimeRange.lastIsoWeek();
    final MonthTimeRange thisMonth = TimeRange.thisMonth();
    final MonthTimeRange nextMonth = TimeRange.nextMonth();
    final MonthTimeRange lastMonth = TimeRange.lastMonth();
    final YearTimeRange thisYear = TimeRange.thisYear();
    final YearTimeRange nextYear = TimeRange.nextYear();
    final YearTimeRange lastYear = TimeRange.lastYear();

    expect(thisHour.next, nextHour);
    expect(thisHour.last, lastHour);
    expect(today.next, tomorrow);
    expect(today.last, yesterday);
    expect(thisLocalWeek.next, nextLocalWeek);
    expect(thisLocalWeek.last, lastLocalWeek);
    expect(thisIsoWeek.next, nextIsoWeek);
    expect(thisIsoWeek.last, lastIsoWeek);
    expect(thisMonth.next, nextMonth);
    expect(thisMonth.last, lastMonth);
    expect(thisYear.next, nextYear);
    expect(thisYear.last, lastYear);
  });

  test("parsing test", () {
    final HourTimeRange thisHour = TimeRange.thisHour();
    expect(TimeRange.parse(thisHour.encode()), thisHour);
    expect(TimeRange.parse(thisHour.encodeShort()), thisHour);

    final HourTimeRange nextHour = TimeRange.nextHour();
    expect(TimeRange.parse(nextHour.encode()), nextHour);
    expect(TimeRange.parse(nextHour.encodeShort()), nextHour);

    final HourTimeRange lastHour = TimeRange.lastHour();
    expect(TimeRange.parse(lastHour.encode()), lastHour);
    expect(TimeRange.parse(lastHour.encodeShort()), lastHour);

    final DayTimeRange today = TimeRange.today();
    expect(TimeRange.parse(today.encode()), today);
    expect(TimeRange.parse(today.encodeShort()), today);

    final DayTimeRange tomorrow = TimeRange.tomorrow();
    expect(TimeRange.parse(tomorrow.encode()), tomorrow);
    expect(TimeRange.parse(tomorrow.encodeShort()), tomorrow);

    final DayTimeRange yesterday = TimeRange.yesterday();
    expect(TimeRange.parse(yesterday.encode()), yesterday);
    expect(TimeRange.parse(yesterday.encodeShort()), yesterday);

    final LocalWeekTimeRange thisLocalWeek = TimeRange.thisLocalWeek();
    expect(TimeRange.parse(thisLocalWeek.encode()), thisLocalWeek);
    expect(TimeRange.parse(thisLocalWeek.encodeShort()), thisLocalWeek);

    final LocalWeekTimeRange nextLocalWeek = TimeRange.nextLocalWeek();
    expect(TimeRange.parse(nextLocalWeek.encode()), nextLocalWeek);
    expect(TimeRange.parse(nextLocalWeek.encodeShort()), nextLocalWeek);

    final LocalWeekTimeRange lastLocalWeek = TimeRange.lastLocalWeek();
    expect(TimeRange.parse(lastLocalWeek.encode()), lastLocalWeek);
    expect(TimeRange.parse(lastLocalWeek.encodeShort()), lastLocalWeek);

    final IsoWeekTimeRange thisIsoWeek = TimeRange.thisIsoWeek();
    expect(TimeRange.parse(thisIsoWeek.encode()), thisIsoWeek);
    expect(TimeRange.parse(thisIsoWeek.encodeShort()), thisIsoWeek);

    final IsoWeekTimeRange nextIsoWeek = TimeRange.nextIsoWeek();
    expect(TimeRange.parse(nextIsoWeek.encode()), nextIsoWeek);
    expect(TimeRange.parse(nextIsoWeek.encodeShort()), nextIsoWeek);

    final IsoWeekTimeRange lastIsoWeek = TimeRange.lastIsoWeek();
    expect(TimeRange.parse(lastIsoWeek.encode()), lastIsoWeek);
    expect(TimeRange.parse(lastIsoWeek.encodeShort()), lastIsoWeek);

    final MonthTimeRange thisMonth = TimeRange.thisMonth();
    expect(TimeRange.parse(thisMonth.encode()), thisMonth);
    expect(TimeRange.parse(thisMonth.encodeShort()), thisMonth);

    final MonthTimeRange nextMonth = TimeRange.nextMonth();
    expect(TimeRange.parse(nextMonth.encode()), nextMonth);
    expect(TimeRange.parse(nextMonth.encodeShort()), nextMonth);

    final MonthTimeRange lastMonth = TimeRange.lastMonth();
    expect(TimeRange.parse(lastMonth.encode()), lastMonth);
    expect(TimeRange.parse(lastMonth.encodeShort()), lastMonth);

    final YearTimeRange thisYear = TimeRange.thisYear();
    expect(TimeRange.parse(thisYear.encode()), thisYear);
    expect(TimeRange.parse(thisYear.encodeShort()), thisYear);

    final YearTimeRange nextYear = TimeRange.nextYear();
    expect(TimeRange.parse(nextYear.encode()), nextYear);
    expect(TimeRange.parse(nextYear.encodeShort()), nextYear);

    final YearTimeRange lastYear = TimeRange.lastYear();
    expect(TimeRange.parse(lastYear.encode()), lastYear);
    expect(TimeRange.parse(lastYear.encodeShort()), lastYear);
  });

  test("karma", () {
    expect(YearTimeRange(2025).contains(DateTime(2026, 1, 1)), false);
    expect(YearTimeRange(2025).contains(DateTime(2025, 6, 15)), true);
    expect(YearTimeRange(2025).contains(DateTime(2025, 1, 1)), true);
    expect(
        YearTimeRange(2025)
            .contains(DateTime(2025, 1, 1) - Duration(microseconds: 1)),
        false);
    expect(
        YearTimeRange(2025).contains(DateTime(2025, 12, 31, 23, 59, 59)), true);
  });

  group("toCustom and asCustom", () {
    test("CustomTimeRange should return itself", () {
      final custom =
          CustomTimeRange(DateTime(2025, 1, 1), DateTime(2025, 12, 31));
      expect(custom.toCustom(), same(custom));
      expect(custom.asCustom, same(custom));
    });

    test("DayTimeRange conversion to CustomTimeRange", () {
      final day = DayTimeRange.fromDateTime(DateTime(2025, 3, 15));
      final customDay = day.toCustom();

      expect(customDay, isA<CustomTimeRange>());
      expect(customDay.from, day.from);
      expect(customDay.to, day.to);
      expect(day == customDay, isFalse); // Different types
    });

    test("MonthTimeRange conversion to CustomTimeRange", () {
      final month = MonthTimeRange(2025, 3);
      final customMonth = month.toCustom();

      expect(customMonth, isA<CustomTimeRange>());
      expect(customMonth.from, month.from);
      expect(customMonth.to, month.to);
      expect(month == customMonth, isFalse); // Different types
    });

    test("YearTimeRange conversion to CustomTimeRange", () {
      final year = YearTimeRange(2025);
      final customYear = year.toCustom();

      expect(customYear, isA<CustomTimeRange>());
      expect(customYear.from, year.from);
      expect(customYear.to, year.to);
      expect(year == customYear, isFalse); // Different types
    });

    test("asCustom is alias for toCustom", () {
      final day = TimeRange.today();
      final customViaToCustom = day.toCustom();
      final customViaAsCustom = day.asCustom;

      expect(customViaToCustom.from, customViaAsCustom.from);
      expect(customViaToCustom.to, customViaAsCustom.to);
      expect(customViaToCustom, equals(customViaAsCustom));
    });

    test("Converted custom ranges preserve timezone", () {
      final utcDay = DayTimeRange.fromDateTime(DateTime.utc(2025, 3, 15));
      final localDay = DayTimeRange.fromDateTime(DateTime(2025, 3, 15));

      final utcCustom = utcDay.toCustom();
      final localCustom = localDay.toCustom();

      expect(utcCustom.isUtc, isTrue);
      expect(localCustom.isUtc, isFalse);
    });
  });

  group("Intersection", () {
    test("Same ranges return original range", () {
      final timeRange = TimeRange.today();
      expect(timeRange.intersect(timeRange), timeRange);
      expect(timeRange & timeRange, timeRange);
    });

    test("Ranges with identical from/to but different types", () {
      final day = TimeRange.today();
      final custom = CustomTimeRange(day.from, day.to);

      final intersection = day.intersect(custom);
      expect(intersection, isNotNull);
      expect(intersection, isA<DayTimeRange>());
      expect(intersection!.from, day.from);
      expect(intersection.to, day.to);
    });

    test("Non-overlapping ranges return null", () {
      final today = TimeRange.today();
      final tomorrow = TimeRange.tomorrow();

      expect(today.intersect(tomorrow), isNull);
      expect(tomorrow.intersect(today), isNull);
      expect(today & tomorrow, isNull);
    });

    test("Partially overlapping ranges return intersection", () {
      final thisMonth = TimeRange.thisMonth();
      final customRange = CustomTimeRange(
          thisMonth.from.subtract(const Duration(days: 10)),
          thisMonth.from.add(const Duration(days: 10)));

      final intersection = thisMonth.intersect(customRange);
      expect(intersection, isNotNull);
      expect(intersection!.from, thisMonth.from);
      expect(intersection.to, customRange.to);
    });

    test("Contained range returns inner range", () {
      final thisYear = TimeRange.thisYear();
      final thisMonth = TimeRange.thisMonth();

      final intersection = thisYear.intersect(thisMonth);
      expect(intersection, isNotNull);
      expect(intersection!.from, thisMonth.from);
      expect(intersection.to, thisMonth.to);
    });

    test("Operator & works the same as intersect", () {
      final range1 =
          CustomTimeRange(DateTime(2025, 1, 1), DateTime(2025, 3, 31));
      final range2 =
          CustomTimeRange(DateTime(2025, 3, 1), DateTime(2025, 6, 30));

      final intersection1 = range1.intersect(range2);
      final intersection2 = range1 & range2;

      expect(intersection1, intersection2);
      expect(intersection1!.from, DateTime(2025, 3, 1));
      expect(intersection1.to, DateTime(2025, 3, 31));
    });

    test("Edge case - ranges touching at endpoints", () {
      final range1 =
          CustomTimeRange(DateTime(2025, 1, 1), DateTime(2025, 3, 31));
      final range2 =
          CustomTimeRange(DateTime(2025, 3, 31), DateTime(2025, 6, 30));

      final intersection = range1.intersect(range2);
      expect(intersection, isNotNull);
      expect(intersection!.from, DateTime(2025, 3, 31));
      expect(intersection.to, DateTime(2025, 3, 31));
      // The intersection is a valid time range with the same start and end
    });
  });
}
