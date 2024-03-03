import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  // Sunday as the start of the week
  Moment.setGlobalLocalization(LocalizationEnUs());

  group('YearFinder', () {
    test('startOfNextYear', () {
      final date = DateTime(2022);
      final nextYear = date.startOfNextYear();
      expect(nextYear.year, 2023);
      expect(nextYear.month, 1);
      expect(nextYear.day, 1);
    });

    test('startOfLastYear', () {
      final date = DateTime(2022);
      final lastYear = date.startOfLastYear();
      expect(lastYear.year, 2021);
      expect(lastYear.month, 1);
      expect(lastYear.day, 1);
    });

    test('endOfNextYear', () {
      final date = DateTime(2022);
      final endNextYear = date.endOfNextYear();
      expect(endNextYear.year, 2023);
      expect(endNextYear.month, 12);
      expect(endNextYear.day, 31);
    });

    test('endOfLastYear', () {
      final date = DateTime(2022);
      final endLastYear = date.endOfLastYear();
      expect(endLastYear.year, 2021);
      expect(endLastYear.month, 12);
      expect(endLastYear.day, 31);
    });
    test('endOfNextYear', () {
      final date = DateTime(2022);
      final endLastYear = date.endOfNextYear();
      expect(endLastYear.year, 2023);
      expect(endLastYear.month, 12);
      expect(endLastYear.day, 31);
    });
  });

  group('MonthFinder', () {
    test('startOfNextMonth', () {
      final date = DateTime(2022, 5);
      final nextMonth = date.startOfNextMonth();
      expect(nextMonth.year, 2022);
      expect(nextMonth.month, 6);
      expect(nextMonth.day, 1);
    });
    test('startOfLastMonth', () {
      final date = DateTime(2022, 5);
      final lastMonth = date.startOfLastMonth();
      expect(lastMonth.year, 2022);
      expect(lastMonth.month, 4);
      expect(lastMonth.day, 1);
    });
    test('endOfNextMonth', () {
      final date = DateTime(2022, 5);
      final nextMonth = date.endOfNextMonth();
      expect(nextMonth.year, 2022);
      expect(nextMonth.month, 6);
      expect(nextMonth.day, 30);
    });
    test('endOfLastMonth', () {
      final date = DateTime(2022, 5);
      final lastMonth = date.endOfLastMonth();
      expect(lastMonth.year, 2022);
      expect(lastMonth.month, 4);
      expect(lastMonth.day, 30);
    });
  });
  group('LocalWeekFinder', () {
    test('startOfNextWeek', () {
      final date = DateTime(2022, 5, 5);
      final nextWeek = date.startOfNextLocalWeek();
      expect(nextWeek.year, 2022);
      expect(nextWeek.month, 5);
      expect(nextWeek.day, 8);
    });
    test('startOfLastWeek', () {
      final date = DateTime(2022, 5, 5);
      final lastWeek = date.startOfLastLocalWeek();
      expect(lastWeek.year, 2022);
      expect(lastWeek.month, 4);
      expect(lastWeek.day, 24);
    });
    test('endOfNextWeek', () {
      final date = DateTime(2022, 5, 5);
      final nextWeek = date.endOfNextLocalWeek();
      expect(nextWeek.year, 2022);
      expect(nextWeek.month, 5);
      expect(nextWeek.day, 14);
    });
    test('endOfLastWeek', () {
      final date = DateTime(2022, 5, 5);
      final lastWeek = date.endOfLastLocalWeek();
      expect(lastWeek.year, 2022);
      expect(lastWeek.month, 4);
      expect(lastWeek.day, 30);
    });
  });
  group("IsoWeekFinder", () {
    test('startOfNextIsoWeek', () {
      final date = DateTime(2022, 5, 5);
      final nextWeek = date.startOfNextIsoWeek();
      expect(nextWeek.year, 2022);
      expect(nextWeek.month, 5);
      expect(nextWeek.day, 9);
    });
    test('startOfLastIsoWeek', () {
      final date = DateTime(2022, 5, 5);
      final lastWeek = date.startOfLastIsoWeek();
      expect(lastWeek.year, 2022);
      expect(lastWeek.month, 4);
      expect(lastWeek.day, 25);
    });
    test('endOfNextIsoWeek', () {
      final date = DateTime(2022, 5, 5);
      final nextWeek = date.endOfNextIsoWeek();
      expect(nextWeek.year, 2022);
      expect(nextWeek.month, 5);
      expect(nextWeek.day, 15);
    });
    test('endOfLastIsoWeek', () {
      final date = DateTime(2022, 5, 5);
      final lastWeek = date.endOfLastIsoWeek();
      expect(lastWeek.year, 2022);
      expect(lastWeek.month, 5);
      expect(lastWeek.day, 1);
    });
  });
  group("DayFinder", () {
    test('startOfNextDay', () {
      final date = DateTime(2022, 5, 5);
      final nextDay = date.startOfNextDay();
      expect(nextDay.year, 2022);
      expect(nextDay.month, 5);
      expect(nextDay.day, 6);
    });
    test('startOfLastDay', () {
      final date = DateTime(2022, 5, 5);
      final lastDay = date.startOfLastDay();
      expect(lastDay.year, 2022);
      expect(lastDay.month, 5);
      expect(lastDay.day, 4);
    });
    test('endOfNextDay', () {
      final date = DateTime(2022, 5, 5);
      final nextDay = date.endOfNextDay();
      expect(nextDay.year, 2022);
      expect(nextDay.month, 5);
      expect(nextDay.day, 6);
    });
    test('endOfLastDay', () {
      final date = DateTime(2022, 5, 5);
      final lastDay = date.endOfLastDay();
      expect(lastDay.year, 2022);
      expect(lastDay.month, 5);
      expect(lastDay.day, 4);
    });
  });
  group("HourFinder", () {
    test('startOfNextHour', () {
      final date = DateTime(2022, 5, 5, 5);
      final nextHour = date.startOfNextHour();
      expect(nextHour.year, 2022);
      expect(nextHour.month, 5);
      expect(nextHour.day, 5);
      expect(nextHour.hour, 6);
      expect(nextHour.minute, 0);
      expect(nextHour.second, 0);
      expect(nextHour.millisecond, 0);
      expect(nextHour.microsecond, 0);
    });
    test('startOfLastHour', () {
      final date = DateTime(2022, 5, 5, 5);
      final lastHour = date.startOfLastHour();
      expect(lastHour.year, 2022);
      expect(lastHour.month, 5);
      expect(lastHour.day, 5);
      expect(lastHour.hour, 4);
      expect(lastHour.minute, 0);
      expect(lastHour.second, 0);
      expect(lastHour.millisecond, 0);
      expect(lastHour.microsecond, 0);
    });
    test('endOfNextHour', () {
      final date = DateTime(2022, 5, 5, 5);
      final nextHour = date.endOfNextHour();
      expect(nextHour.year, 2022);
      expect(nextHour.month, 5);
      expect(nextHour.day, 5);
      expect(nextHour.hour, 6);
      expect(nextHour.minute, 59);
      expect(nextHour.second, 59);
      expect(nextHour.millisecond, 999);
      expect(nextHour.microsecond, 999);
    });
    test('endOfLastHour', () {
      final date = DateTime(2022, 5, 5, 5);
      final lastHour = date.endOfLastHour();
      expect(lastHour.year, 2022);
      expect(lastHour.month, 5);
      expect(lastHour.day, 5);
      expect(lastHour.hour, 4);
      expect(lastHour.minute, 59);
      expect(lastHour.second, 59);
      expect(lastHour.millisecond, 999);
      expect(lastHour.microsecond, 999);
    });
  });
}
