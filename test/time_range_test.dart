import 'package:moment_dart/src/extensions/benefits.dart';
import 'package:moment_dart/src/extensions/end_of.dart';
import 'package:moment_dart/src/extensions/start_of.dart';
import 'package:moment_dart/src/time_range.dart';
import 'package:test/test.dart';

/// One microsecond
const aMicrosecond = Duration(microseconds: 1);

void main() {
  group("Equality", () {
    test("TimeRange Factories", () {
      expect(
        TimeRange.today() == DayTimeRange.fromDateTime(DateTime.now().toUtc()),
        false,
      );
      expect(
        TimeRange.thisMonth() ==
            MonthTimeRange.fromDateTime(DateTime.now().toUtc()),
        false,
      );
      expect(
        TimeRange.thisYear() ==
            YearTimeRange.fromDateTime(DateTime.now().toUtc()),
        false,
      );
    });
    test("Different timezones", () {
      expect(
        TimeRange.today() == DayTimeRange.fromDateTime(DateTime.now()),
        true,
      );
      expect(
        TimeRange.thisMonth() == MonthTimeRange.fromDateTime(DateTime.now()),
        true,
      );
      expect(
        TimeRange.thisYear() == YearTimeRange.fromDateTime(DateTime.now()),
        true,
      );
    });
    test("different types shouldn't be equal", () {
      final DateTime now = DateTime.now().startOfDay();

      final TimeRange today = TimeRange.today(now);
      final CustomTimeRange todayCustom = CustomTimeRange(now, now.endOfDay());

      expect(today == todayCustom, false);
      expect(today.from == todayCustom.from, true);
      expect(today.to == todayCustom.to, true);

      final TimeRange thisMonth = TimeRange.thisMonth(now);
      final CustomTimeRange thisMonthCustom =
          CustomTimeRange(now.startOfMonth(), now.endOfMonth());

      expect(thisMonth == thisMonthCustom, false);
      expect(thisMonth.from == thisMonthCustom.from, true);
      expect(thisMonth.to == thisMonthCustom.to, true);

      final TimeRange thisYear = TimeRange.thisYear(now);
      final CustomTimeRange thisYearCustom =
          CustomTimeRange(now.startOfYear(), now.endOfYear());

      expect(thisYear == thisYearCustom, false);
      expect(thisYear.from == thisYearCustom.from, true);
      expect(thisYear.to == thisYearCustom.to, true);
    });
  });

  group("Duration", () {
    test("Day", () {
      final DateTime now = DateTime.now();
      final TimeRange today = TimeRange.today(now);
      expect(today.duration, Duration(days: 1) - aMicrosecond);
    });

    test("Month days", () {
      for (final year in [1970, 2000, 2020, 2021, 2024]) {
        for (final month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) {
          final MonthTimeRange monthRange = MonthTimeRange(year, month);
          expect(
            monthRange.duration,
            Duration(days: DateTime(year, month).endOfMonth().day) -
                aMicrosecond,
          );
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
      final TimeRange today = TimeRange.today(now);
      expect(today.contains(now), true);
      expect(today.contains(now.startOfDay()), true);
      expect(today.contains(now.endOfDay()), true);
      expect(today.contains(now.startOfDay() - aMicrosecond), false);
      expect(today.contains(now.endOfDay() + aMicrosecond), false);
    });

    test("Month", () {
      final DateTime now = DateTime.now();
      final TimeRange thisMonth = TimeRange.thisMonth(now);
      expect(thisMonth.contains(now), true);
      expect(thisMonth.contains(now.subtract(Duration(days: 1))), false);
      expect(thisMonth.contains(now.add(Duration(days: 1))), true);
    });

    test("Year", () {
      final DateTime now = DateTime.now();
      final TimeRange thisYear = TimeRange.thisYear(now);
      expect(thisYear.contains(now), true);
      expect(thisYear.contains(now.subtract(Duration(days: 366))), false);
      expect(thisYear.contains(now.add(Duration(days: 366))), true);
    });

    test("Custom", () {
      final DateTime now = DateTime.now();
      final CustomTimeRange customRange =
          CustomTimeRange(now, now.add(Duration(days: 1)));
      expect(customRange.contains(now), true);
      expect(customRange.contains(now.subtract(Duration(days: 1))), false);
      expect(customRange.contains(now.add(Duration(days: 1))), false);
    });
  });
}
