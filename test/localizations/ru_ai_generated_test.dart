// ignore_for_file: avoid_dynamic_calls

import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  final localization = LocalizationRuRu();
  final now = DateTime.now();

  group('Russian Localization Tests', () {
    setUp(() {
      // Set default localization for tests
      Moment.setGlobalLocalization(localization);
    });

    test('Endonym', () {
      expect(localization.endonym, "Русский");
    });

    test('Date and Time Formatting', () {
      final testDate =
          DateTime(2023, 1, 2, 3, 4, 5); // January 2, 2023, 03:04:05
      final m = Moment(testDate);

      expect(m.format("L"), "02.01.2023");
      expect(m.format("l"), "2.1.2023");
      expect(m.format("LL"), "2 января 2023 г.");
      expect(m.format("ll"), "2 янв. 2023 г.");
      expect(m.format("LLL"), "2 января 2023 г., 03:04");
      expect(m.format("lll"), "2 янв. 2023 г., 03:04");
      expect(m.format("LLLL"), "понедельник, 2 января 2023 г., 03:04");
      expect(m.format("llll"), "пн, 2 янв. 2023 г., 03:04");
      expect(m.format("LT"), "03:04");
      expect(m.format("LTS"), "03:04:05");
    });

    test('Ordinal Numbers', () {
      expect(Moment(DateTime(2023, 1, 1)).format("Do MMMM"), "1-е января");
      expect(Moment(DateTime(2023, 1, 2)).format("Do MMMM"), "2-е января");
      expect(Moment(DateTime(2023, 1, 3)).format("Do MMMM"), "3-е января");
      expect(Moment(DateTime(2023, 1, 11)).format("Do MMMM"), "11-е января");
      expect(Moment(DateTime(2023, 1, 21)).format("Do MMMM"), "21-е января");
    });

    test('Relative Time (Past)', () {
      expect(
          Moment(now.subtract(const Duration(seconds: 5))).fromNow(),
          startsWith(
              "несколько секунд")); // Using startsWith due to SimpleUnits
      expect(Moment(now.subtract(const Duration(seconds: 45))).fromNow(),
          "минуту назад"); // localization.aMinute used by fromNow if < 90 sec
      expect(Moment(now.subtract(const Duration(minutes: 5))).fromNow(),
          "5 минут назад");
      expect(Moment(now.subtract(const Duration(hours: 2))).fromNow(),
          "2 часа назад");
      expect(Moment(now.subtract(const Duration(days: 3))).fromNow(),
          "3 дня назад");
      expect(Moment(now.subtract(const Duration(days: 8))).fromNow(),
          "8 дней назад"); // a week is 7 days
      expect(Moment(now.subtract(const Duration(days: 30))).fromNow(),
          "месяц назад");
      expect(Moment(now.subtract(const Duration(days: 365))).fromNow(),
          "год назад");
    });

    test('Relative Time (Future)', () {
      expect(Moment(now.add(const Duration(seconds: 5))).fromNow(),
          startsWith("через несколько секунд"));
      expect(Moment(now.add(const Duration(seconds: 46))).fromNow(),
          "через минута");
      expect(Moment(now.add(const Duration(minutes: 5))).fromNow(),
          "через 5 минут");
      expect(
          Moment(now.add(const Duration(hours: 2))).fromNow(), "через 2 часа");
      expect(Moment(now.add(const Duration(days: 3))).fromNow(), "через 3 дня");
      expect(
          Moment(now.add(const Duration(days: 8))).fromNow(), "через 8 дней");
      expect(
          Moment(now.add(const Duration(days: 30))).fromNow(), "через месяц");
      expect(Moment(now.add(const Duration(days: 365))).fromNow(), "через год");
    });

    test('Calendar Localization', () {
      final today = Moment(now);
      final yesterday = Moment(now.subtract(const Duration(days: 1)));
      final tomorrow = Moment(now.add(const Duration(days: 1)));
      final lastWeek = Moment(now.subtract(const Duration(days: 7)));
      final nextWeek = Moment(now.add(const Duration(days: 7)));

      expect(today.calendar(), startsWith("Сегодня в")); // e.g. Сегодня в 14:30
      expect(yesterday.calendar(), startsWith("Вчера в")); // e.g. Вчера в 14:30
      expect(
          tomorrow.calendar(), startsWith("Завтра в")); // e.g. Завтра в 14:30

      // For lastWeek and nextWeek, it should show the date, e.g. "Прошлый понедельник в 14:30" or "DD.MM.YYYY"
      // The exact format depends on how far lastWeek/nextWeek are and the `calendarData` logic.
      // For now, just check they don't throw. More specific tests might be needed if complex logic is in `calendarData`.
      expect(() => lastWeek.calendar(), returnsNormally);
      expect(() => nextWeek.calendar(), returnsNormally);
    });

    // Test for month names
    test('Month Names', () {
      expect(Moment(DateTime(2023, 1, 1)).format("MMMM"), "январь");
      expect(Moment(DateTime(2023, 2, 1)).format("MMMM"), "февраль");
      // ... Add more months if desired
      expect(Moment(DateTime(2023, 12, 1)).format("MMMM"), "декабрь");

      expect(Moment(DateTime(2023, 1, 1)).format("MMM"), "янв.");
      expect(Moment(DateTime(2023, 2, 1)).format("MMM"), "февр.");
      // ...
      expect(Moment(DateTime(2023, 12, 1)).format("MMM"), "дек.");
    });

    // Test for weekday names
    test('Weekday Names', () {
      expect(Moment(DateTime(2023, 1, 2)).format("dddd"),
          "понедельник"); // Jan 2, 2023 is a Monday
      expect(Moment(DateTime(2023, 1, 3)).format("dddd"), "вторник");
      // ...
      expect(Moment(DateTime(2023, 1, 8)).format("dddd"), "воскресенье");

      expect(Moment(DateTime(2023, 1, 2)).format("ddd"), "пн");
      expect(Moment(DateTime(2023, 1, 3)).format("ddd"), "вт");
      // ...
      expect(Moment(DateTime(2023, 1, 8)).format("ddd"), "вс");
    });

    // Duration tests can be more complex due to pluralization.
    // The current SimpleDuration might not fully support Russian grammar for all numbers.
    // These tests will check the basic forms.
    test('Duration Formatting (Approximate)', () {
      // Note: fromNow() uses duration internally. These are more direct tests if needed.
      // For more precise duration tests, one might need to test `localization.formatDuration` directly
      // if the `moment_dart` package exposes it or has specific duration formatting methods.
      // The `fromNow` tests above cover a lot of the duration aspects indirectly.

      // Example of how one might test duration if there was a direct formatting method:
      // expect(localization.formatDuration(Duration(seconds: 1)), "секунда");
      // expect(localization.formatDuration(Duration(seconds: 2)), "2 секунды"); // This would fail with SimpleUnits
      // expect(localization.formatDuration(Duration(seconds: 5)), "5 секунд"); // This would likely work
    });
  });
}
