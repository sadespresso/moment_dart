import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  group('ClampedSetters on DateTime', () {
    test('setClampedSecond clamps seconds between 0 and 59', () {
      final date = DateTime(2024, 1, 1, 12, 0, 0);

      expect(date.setClampedSecond(-1).second, 0);
      expect(date.setClampedSecond(0).second, 0);
      expect(date.setClampedSecond(30).second, 30);
      expect(date.setClampedSecond(59).second, 59);
      expect(date.setClampedSecond(60).second, 59);
    });

    test('setClampedMinute clamps minutes between 0 and 59', () {
      final date = DateTime(2024, 1, 1, 12, 0, 0);

      expect(date.setClampedMinute(-1).minute, 0);
      expect(date.setClampedMinute(0).minute, 0);
      expect(date.setClampedMinute(30).minute, 30);
      expect(date.setClampedMinute(59).minute, 59);
      expect(date.setClampedMinute(60).minute, 59);
    });

    test('setClampedHour clamps hours between 0 and 23', () {
      final date = DateTime(2024, 1, 1, 12, 0, 0);

      expect(date.setClampedHour(-1).hour, 0);
      expect(date.setClampedHour(0).hour, 0);
      expect(date.setClampedHour(12).hour, 12);
      expect(date.setClampedHour(23).hour, 23);
      expect(date.setClampedHour(24).hour, 23);
    });

    test('setClampedDay clamps days based on month length', () {
      // Test February in non-leap year
      final feb2023 = DateTime(2023, 2, 1);
      expect(feb2023.setClampedDay(0).day, 1);
      expect(feb2023.setClampedDay(1).day, 1);
      expect(feb2023.setClampedDay(15).day, 15);
      expect(feb2023.setClampedDay(28).day, 28);
      expect(feb2023.setClampedDay(29).day, 28);

      // Test February in leap year
      final feb2024 = DateTime(2024, 2, 1);
      expect(feb2024.setClampedDay(29).day, 29);
      expect(feb2024.setClampedDay(30).day, 29);

      // Test month with 31 days
      final jan2024 = DateTime(2024, 1, 1);
      expect(jan2024.setClampedDay(31).day, 31);
      expect(jan2024.setClampedDay(32).day, 31);
    });

    test(
        'setClampedMonth clamps months between 1 and 12 and adjusts day if needed',
        () {
      final date = DateTime(2024, 1, 31);

      expect(date.setClampedMonth(0).month, 1);
      expect(date.setClampedMonth(1).month, 1);
      expect(date.setClampedMonth(6).month, 6);
      expect(date.setClampedMonth(12).month, 12);
      expect(date.setClampedMonth(13).month, 12);

      // Test day adjustment when changing to month with fewer days
      expect(date.setClampedMonth(2).day, 29); // 2024 is leap year
      expect(DateTime(2023, 1, 31).setClampedMonth(2).day,
          28); // 2023 is not leap year
    });
  });

  group('ClampedSettersPlus on Moment', () {
    test('setClampedSecond clamps seconds between 0 and 59', () {
      final moment = Moment(DateTime(2024, 1, 1, 12, 0, 0));

      expect(moment.setClampedSecond(-1).second, 0);
      expect(moment.setClampedSecond(0).second, 0);
      expect(moment.setClampedSecond(30).second, 30);
      expect(moment.setClampedSecond(59).second, 59);
      expect(moment.setClampedSecond(60).second, 59);
    });

    test('setClampedMinute clamps minutes between 0 and 59', () {
      final moment = Moment(DateTime(2024, 1, 1, 12, 0, 0));

      expect(moment.setClampedMinute(-1).minute, 0);
      expect(moment.setClampedMinute(0).minute, 0);
      expect(moment.setClampedMinute(30).minute, 30);
      expect(moment.setClampedMinute(59).minute, 59);
      expect(moment.setClampedMinute(60).minute, 59);
    });

    test('setClampedHour clamps hours between 0 and 23', () {
      final moment = Moment(DateTime(2024, 1, 1, 12, 0, 0));

      expect(moment.setClampedHour(-1).hour, 0);
      expect(moment.setClampedHour(0).hour, 0);
      expect(moment.setClampedHour(12).hour, 12);
      expect(moment.setClampedHour(23).hour, 23);
      expect(moment.setClampedHour(24).hour, 23);
    });

    test('setClampedDay clamps days based on month length', () {
      // Test February in non-leap year
      final feb2023 = Moment(DateTime(2023, 2, 1));
      expect(feb2023.setClampedDay(0).day, 1);
      expect(feb2023.setClampedDay(1).day, 1);
      expect(feb2023.setClampedDay(15).day, 15);
      expect(feb2023.setClampedDay(28).day, 28);
      expect(feb2023.setClampedDay(29).day, 28);

      // Test February in leap year
      final feb2024 = Moment(DateTime(2024, 2, 1));
      expect(feb2024.setClampedDay(29).day, 29);
      expect(feb2024.setClampedDay(30).day, 29);

      // Test month with 31 days
      final jan2024 = Moment(DateTime(2024, 1, 1));
      expect(jan2024.setClampedDay(31).day, 31);
      expect(jan2024.setClampedDay(32).day, 31);
    });

    test(
        'setClampedMonth clamps months between 1 and 12 and adjusts day if needed',
        () {
      final moment = Moment(DateTime(2024, 1, 31));

      expect(moment.setClampedMonth(0).month, 1);
      expect(moment.setClampedMonth(1).month, 1);
      expect(moment.setClampedMonth(6).month, 6);
      expect(moment.setClampedMonth(12).month, 12);
      expect(moment.setClampedMonth(13).month, 12);

      // Test day adjustment when changing to month with fewer days
      expect(moment.setClampedMonth(2).day, 29); // 2024 is leap year
      expect(Moment(DateTime(2023, 1, 31)).setClampedMonth(2).day,
          28); // 2023 is not leap year
    });
  });
}
