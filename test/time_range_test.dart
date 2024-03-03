import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  const aMicrosecond = Duration(microseconds: 1);
  group("Equality", () {
    final now = DateTime.now();

    test("TimeRange Factories", () {
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
      final CustomTimeRange todayCustom =
          CustomTimeRange(now, now.startOfNextDay());

      expect(today == todayCustom, false);
      expect(today.from == todayCustom.from, true);
      expect(today.to == todayCustom.to, true);

      final TimeRange thisMonth = TimeRange.thisMonth();
      final CustomTimeRange thisMonthCustom =
          CustomTimeRange(now.startOfMonth(), now.startOfNextMonth());

      expect(thisMonth == thisMonthCustom, false);
      expect(thisMonth.from == thisMonthCustom.from, true);
      expect(thisMonth.to == thisMonthCustom.to, true);

      final TimeRange thisYear = TimeRange.thisYear();
      final CustomTimeRange thisYearCustom =
          CustomTimeRange(now.startOfYear(), now.startOfNextYear());

      expect(thisYear == thisYearCustom, false);
      expect(thisYear.from == thisYearCustom.from, true);
      expect(thisYear.to == thisYearCustom.to, true);
    });
  });

  group("Duration", () {
    test("Day", () {
      final TimeRange today = TimeRange.today();
      expect(today.duration, Duration(days: 1));
    });

    test("Month days", () {
      for (final year in [1970, 2000, 2020, 2021, 2024]) {
        for (final month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) {
          final MonthTimeRange monthRange = MonthTimeRange(year, month);
          expect(monthRange.duration,
              Duration(days: DateTime(year, month).endOfMonth().day));
        }
      }
    });

    test("Year days", () {
      for (final year in [1970, 2000, 2020, 2021, 2024]) {
        final YearTimeRange yearRange = YearTimeRange(year);
        expect(
          yearRange.duration,
          Duration(days: DateTime(year).endOfYear().dayOfYear),
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
    expect(monthRange.toUtc().to,
        DateTime.utc(now.year, now.month).startOfNextMonth());
  });

  test("YearTimeRange", () {
    final DateTime now = DateTime.now();
    final YearTimeRange yearRange = YearTimeRange.fromDateTime(now);

    // Because [YearTimeRange] constructs the [DateTime] itself,
    // we can't do `year.from.toUtc()`
    expect(yearRange.toUtc().isUtc, true);
    expect(yearRange.toUtc().from, DateTime.utc(now.year));
    expect(yearRange.toUtc().to, DateTime.utc(now.year).startOfNextYear());
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

  test("next/prev time ranges", () {
    final HourTimeRange thisHour = TimeRange.thisHour();
    final HourTimeRange nextHour = TimeRange.nextHour();
    final HourTimeRange lastHour = TimeRange.lastHour();
    final DayTimeRange today = TimeRange.today();
    final DayTimeRange tomorrow = TimeRange.tomorrow();
    final DayTimeRange yesterday = TimeRange.yesterday();
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
    expect(thisMonth.next, nextMonth);
    expect(thisMonth.last, lastMonth);
    expect(thisYear.next, nextYear);
    expect(thisYear.last, lastYear);
  });
}
