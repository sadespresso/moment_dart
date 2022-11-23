import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  test("Leap Year", () {
    expect(DateTime(1700).isLeapYear, false);
    expect(DateTime(2000).isLeapYear, true);
    expect(DateTime(2004).isLeapYear, true);
    expect(DateTime(2020).isLeapYear, true);
    expect(DateTime(1900).isLeapYear, false);
    expect(DateTime(1904).isLeapYear, true);
    expect(DateTime(0).isLeapYear, true);
    expect(DateTime(400).isLeapYear, true);
    expect(DateTime(300).isLeapYear, false);
    expect(DateTime(2024).isLeapYear, true);
    expect(DateTime(2100).isLeapYear, false);
  });

  test("Quarter", () {
    expect(DateTime(2022, 1).quarter, 1);
    expect(DateTime(2022, 2).quarter, 1);
    expect(DateTime(2022, 3).quarter, 1);
    expect(DateTime(2022, 4).quarter, 2);
    expect(DateTime(2022, 5).quarter, 2);
    expect(DateTime(2022, 6).quarter, 2);
    expect(DateTime(2022, 7).quarter, 3);
    expect(DateTime(2022, 8).quarter, 3);
    expect(DateTime(2022, 9).quarter, 3);
    expect(DateTime(2022, 10).quarter, 4);
    expect(DateTime(2022, 11).quarter, 4);
    expect(DateTime(2022, 12).quarter, 4);
    expect(DateTime(2022, 13).quarter, 1);
  });

  test("Week ISO", () {
    expect(DateTime(2022, 7, 26).week, 30);
    expect(DateTime(2022, 7, 26).weekYear, 2022);
    expect(DateTime(2022, 8, 16).week, 33);
    expect(DateTime(2023).week, 52);
    expect(DateTime(2023).weekYear, 2022);
    expect(DateTime(2023, 1, 2).week, 1);
    expect(DateTime(2023, 1, 2).weekYear, 2023);

    expect(DateTime(1977).week, 53);
    expect(DateTime(1977).weekYear, 1976);
    expect(DateTime(1979, 12, 30).week, 52);
    expect(DateTime(1979, 12, 30).weekYear, 1979);
  });

  test("Ordinal day of year", () {
    expect(DateTime(2022, 3, 28).dayOfYear, 87);
    expect(DateTime(2020, 2, 29).dayOfYear, 60);
    expect(DateTime(2022, 3, 1).dayOfYear, 60);
    expect(DateTime(2020, 3, 1).dayOfYear, 61);
    expect(
      DateTime(1970).dayOfYear,
      1,
    );
  });

  group("Is At Same _ As Test", () {
    test("#1", () {
      final int hour = 5;
      final int minute = 7;

      final Duration delta = Duration(hours: hour, minutes: minute);

      final Moment local = DateTime(2003, 6, 1, hour, minute, 8, 600)
          .toMoment(); // June 1 2003 05:07 AM
      final Moment utc = DateTime(2003, 6, 1, hour, minute, 8, 600, 1)
          .toMoment()
          .toUtc(); // May 31 2003 09:07 PM

      expect(local.isAtSameYearAs(utc), true); // "same year"
      expect(local.isAtSameMonthAs(utc),
          local.timeZoneOffset < delta); // "same month"
      expect(
          local.isAtSameDayAs(utc), local.timeZoneOffset < delta); // "same day"
      expect(local.isAtSameHourAs(utc), false); // "same hour"
      expect(local.isAtSameMinuteAs(utc), false); // "same minute"
      expect(local.isAtSameSecondAs(utc), false); // "same second"
      expect(local.isAtSameMillisecondAs(utc), false); // "same millis"
      expect(local.isAtSameMicrosecondAs(utc), false); // "same microsecond"
      expect(local.isAtSameMomentAs(utc), false); // "same microsecond"
    });

    test("#2", () {
      final Moment local =
          DateTime(2003, 6, 1, 5, 7, 8, 600).toMoment(); // June 1 2003 05:07 AM
      final Moment utc = DateTime(2003, 6, 1, 5, 7, 8, 600, 1)
          .toMoment()
          .toUtc(); // May 31 2003 09:07 PM

      expect(
        local.isAtSameYearAs(utc, enforceUTC: true),
        true,
      ); // "same year"
      expect(
        local.isAtSameMonthAs(utc, enforceUTC: true),
        true,
      ); // "same month"
      expect(local.isAtSameDayAs(utc, enforceUTC: true), true); // "same day"
      expect(local.isAtSameHourAs(utc, enforceUTC: true), true); // "same hour"
      expect(
        local.isAtSameMinuteAs(utc, enforceUTC: true),
        true,
      ); // "same minute"
      expect(
        local.isAtSameSecondAs(utc, enforceUTC: true),
        true,
      ); // "same second"
      expect(
        local.isAtSameMillisecondAs(utc, enforceUTC: true),
        true,
      ); // "same millis"
      expect(
        local.isAtSameMicrosecondAs(utc, enforceUTC: true),
        false,
      ); // "same microsecond"
      expect(
        local.isAtSameMomentAs(utc),
        false,
      ); // "same microsecond"
    });

    test("#3", () {
      final Moment local =
          DateTime(1972, 1, 1, 7).toMoment(); // Jan 1, 1972 at 7AM @GMT+8
      final Moment utc = local.toUtc(); // Dec 31, 1971 at 11PM @UTC

      expect(local.isAtSameYearAs(utc, enforceUTC: true), true);
      expect(local.isAtSameMonthAs(utc, enforceUTC: true), true);
      expect(local.isAtSameDayAs(utc, enforceUTC: true), true);
      expect(local.isAtSameHourAs(utc, enforceUTC: true), true);
      expect(local.isAtSameMinuteAs(utc, enforceUTC: true), true);
      expect(local.isAtSameSecondAs(utc, enforceUTC: true), true);
      expect(local.isAtSameMillisecondAs(utc, enforceUTC: true), true);
      expect(local.isAtSameMicrosecondAs(utc, enforceUTC: true), true);
      expect(local.isAtSameMomentAs(utc), true);
    });
  });

  group("Last Weekday", () {
    test("DateTime", () {
      DateTime m = DateTime(2022, 6, 19, 21, 9).toUtc();

      expect(m.lastMonday() < m, true);
      expect(m.lastMonday().weekday, 1);

      expect(m.lastTuesday() < m, true);
      expect(m.lastTuesday().weekday, 2);

      expect(m.lastWednesday() < m, true);
      expect(m.lastWednesday().weekday, 3);

      expect(m.lastThursday() < m, true);
      expect(m.lastThursday().weekday, 4);

      expect(m.lastFriday() < m, true);
      expect(m.lastFriday().weekday, 5);

      expect(m.lastSaturday() < m, true);
      expect(m.lastSaturday().weekday, 6);

      expect(m.lastSunday() < m, true);
      expect(m.lastSunday().weekday, 7);
    });

    test("Moment", () {
      Moment m = Moment.fromMicrosecondsSinceEpoch(86841989) -
          DateTime.now().timeZoneOffset;

      expect(m.lastMonday() < m, true);
      expect(m.lastMonday().weekday, 1);

      expect(m.lastTuesday() < m, true);
      expect(m.lastTuesday().weekday, 2);

      expect(m.lastWednesday() < m, true);
      expect(m.lastWednesday().weekday, 3);

      expect(m.lastThursday() < m, true);
      expect(m.lastThursday().weekday, 4);

      expect(m.lastFriday() < m, true);
      expect(m.lastFriday().weekday, 5);

      expect(m.lastSaturday() < m, true);
      expect(m.lastSaturday().weekday, 6);

      expect(m.lastSunday() < m, true);
      expect(m.lastSunday().weekday, 7);
    });

    test("Mendee's Birthday", () {
      Moment m = DateTime(2003, 6, 1, 5, 33).toMoment();

      expect(m.lastMonday() < m, true);
      expect(m.lastMonday().weekday, 1);

      expect(m.lastTuesday() < m, true);
      expect(m.lastTuesday().weekday, 2);

      expect(m.lastWednesday() < m, true);
      expect(m.lastWednesday().weekday, 3);

      expect(m.lastThursday() < m, true);
      expect(m.lastThursday().weekday, 4);

      expect(m.lastFriday() < m, true);
      expect(m.lastFriday().weekday, 5);

      expect(m.lastSaturday() < m, true);
      expect(m.lastSaturday().weekday, 6);

      expect(m.lastSunday() < m, true);
      expect(m.lastSunday().weekday, 7);
    });
  });

  group("Next Weekday", () {
    test("DateTime", () {
      DateTime m = DateTime(2022, 6, 19, 21, 9);

      expect(m.nextMonday() > m, true);
      expect(m.nextMonday().weekday, 1);

      expect(m.nextTuesday() > m, true);
      expect(m.nextTuesday().weekday, 2);

      expect(m.nextWednesday() > m, true);
      expect(m.nextWednesday().weekday, 3);

      expect(m.nextThursday() > m, true);
      expect(m.nextThursday().weekday, 4);

      expect(m.nextFriday() > m, true);
      expect(m.nextFriday().weekday, 5);

      expect(m.nextSaturday() > m, true);
      expect(m.nextSaturday().weekday, 6);

      expect(m.nextSunday() > m, true);
      expect(m.nextSunday().weekday, 7);
    });

    test("Moment", () {
      Moment m = Moment.fromMicrosecondsSinceEpoch(86841989);

      expect(m.nextMonday() > m, true);
      expect(m.nextMonday().weekday, 1);

      expect(m.nextTuesday() > m, true);
      expect(m.nextTuesday().weekday, 2);

      expect(m.nextWednesday() > m, true);
      expect(m.nextWednesday().weekday, 3);

      expect(m.nextThursday() > m, true);
      expect(m.nextThursday().weekday, 4);

      expect(m.nextFriday() > m, true);
      expect(m.nextFriday().weekday, 5);

      expect(m.nextSaturday() > m, true);
      expect(m.nextSaturday().weekday, 6);

      expect(m.nextSunday() > m, true);
      expect(m.nextSunday().weekday, 7);
    });

    test("Mendee's Birthday", () {
      Moment m = DateTime(2003, 6, 1, 5, 33).toMoment();

      expect(m.nextMonday() > m, true);
      expect(m.nextMonday().weekday, 1);

      expect(m.nextTuesday() > m, true);
      expect(m.nextTuesday().weekday, 2);

      expect(m.nextWednesday() > m, true);
      expect(m.nextWednesday().weekday, 3);

      expect(m.nextThursday() > m, true);
      expect(m.nextThursday().weekday, 4);

      expect(m.nextFriday() > m, true);
      expect(m.nextFriday().weekday, 5);

      expect(m.nextSaturday() > m, true);
      expect(m.nextSaturday().weekday, 6);

      expect(m.nextSunday() > m, true);
      expect(m.nextSunday().weekday, 7);
    });
  });

  group("Start of unit", () {
    test("DateTime", () {
      DateTime m = DateTime(2022, 6, 19, 21, 9, 33, 1, 1);
      expect(m.startOfMillisecond(), DateTime(2022, 6, 19, 21, 9, 33, 1));
      expect(m.startOfSecond(), DateTime(2022, 6, 19, 21, 9, 33));
      expect(m.startOfMinute(), DateTime(2022, 6, 19, 21, 9));
      expect(m.startOfHour(), DateTime(2022, 6, 19, 21));
      expect(m.startOfDay(), DateTime(2022, 6, 19));
      expect(
        m.startOfLocalWeek(),
        DateTime(2022, 6, 13),
      ); // Monday as start of week
      expect(m.startOfMonth(), DateTime(2022, 6));
      expect(m.startOfYear(), DateTime(2022));

      expect(m.startOf(DurationUnit.microsecond),
          m.toLocal()); // Must check local value since .startOf returns local DateTime
    });
    test("Moment", () {
      Moment m = DateTime(2003, 6, 1, 21, 9, 33, 1, 1).toMoment();
      expect(m.startOfMillisecond(),
          DateTime(2003, 6, 1, 21, 9, 33, 1).toMoment());
      expect(m.startOfSecond(), DateTime(2003, 6, 1, 21, 9, 33).toMoment());
      expect(m.startOfMinute(), DateTime(2003, 6, 1, 21, 9).toMoment());
      expect(m.startOfHour(), DateTime(2003, 6, 1, 21).toMoment());
      expect(m.startOfDay(), DateTime(2003, 6).toMoment());
      expect(
        m.startOfLocalWeek(),
        DateTime(2003, 6, 1).toMoment(),
      ); // Sunday as start of week, dervied from en_US locale
      expect(m.startOfMonth(), DateTime(2003, 6).toMoment());
      expect(m.startOfYear(), DateTime(2003).toMoment());

      expect(m.startOf(DurationUnit.microsecond), m.toLocal());
    });
  });

  group("End of unit", () {
    test("DateTime", () {
      DateTime m = DateTime(2022, 6, 19, 21, 9, 33, 1, 1);
      expect(m.endOfMillisecond(), DateTime(2022, 6, 19, 21, 9, 33, 1, 999));
      expect(m.endOfSecond(), DateTime(2022, 6, 19, 21, 9, 33, 999, 999));
      expect(m.endOfMinute(), DateTime(2022, 6, 19, 21, 9, 59, 999, 999));
      expect(m.endOfHour(), DateTime(2022, 6, 19, 21, 59, 59, 999, 999));
      expect(m.endOfDay(), DateTime(2022, 6, 19, 23, 59, 59, 999, 999));
      expect(
        m.endOfLocalWeek(),
        DateTime(2022, 6, 19, 23, 59, 59, 999, 999),
      ); // Week start on Monday by default
      expect(m.endOfMonth(), DateTime(2022, 6, 30, 23, 59, 59, 999, 999));
      expect(m.endOfYear(), DateTime(2022, 12, 31, 23, 59, 59, 999, 999));

      expect(() => m.endOf(DurationUnit.microsecond),
          throwsA(isA<MomentException>()));
    });
    test("Moment", () {
      Moment m = DateTime(2003, 6, 1, 21, 9, 33, 247, 1).toMoment();
      expect(m.endOfMillisecond(),
          DateTime(2003, 6, 1, 21, 9, 33, 247, 999).toMoment());
      expect(m.endOfSecond(),
          DateTime(2003, 6, 1, 21, 9, 33, 999, 999).toMoment());
      expect(m.endOfMinute(),
          DateTime(2003, 6, 1, 21, 9, 59, 999, 999).toMoment());
      expect(
          m.endOfHour(), DateTime(2003, 6, 1, 21, 59, 59, 999, 999).toMoment());
      expect(
          m.endOfDay(), DateTime(2003, 6, 1, 23, 59, 59, 999, 999).toMoment());
      expect(
        m.endOfLocalWeek(),
        DateTime(2003, 6, 7, 23, 59, 59, 999, 999).toMoment(),
      ); // Week start on Sunday, derived from en_US locale
      expect(m.endOfMonth(),
          DateTime(2003, 6, 30, 23, 59, 59, 999, 999).toMoment());
      expect(m.endOfYear(),
          DateTime(2003, 12, 31, 23, 59, 59, 999, 999).toMoment());

      expect(() => m.endOf(DurationUnit.microsecond),
          throwsA(isA<MomentException>()));
    });
  });

  test("Is same local week as", () {
    expect(
      DateTime(2022, DateTime.november, 23).isSameLocalWeekAs(
        DateTime(2022, DateTime.november, 27),
        DateTime.sunday,
      ),
      false,
    );

    expect(
      DateTime(2022, DateTime.november, 23).isSameLocalWeekAs(
        DateTime(2022, DateTime.november, 19),
        DateTime.sunday,
      ),
      false,
    );

    expect(
      DateTime(2022, DateTime.november, 23).isSameLocalWeekAs(
        DateTime(2022, DateTime.november, 27),
        DateTime.monday,
      ),
      true,
    );

    expect(
      DateTime(2022, DateTime.november, 23).isSameLocalWeekAs(
        DateTime(2022, DateTime.november, 19),
        DateTime.monday,
      ),
      false,
    );
    expect(
      DateTime(2022, DateTime.november, 23).isSameLocalWeekAs(
        DateTime(2022, DateTime.november, 20),
        DateTime.monday,
      ),
      false,
    );
    expect(
      DateTime(2022, DateTime.november, 23).isSameLocalWeekAs(
        DateTime(2022, DateTime.november, 21),
        DateTime.monday,
      ),
      true,
    );
  });
}
