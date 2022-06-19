import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  group("General Functions", () {
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

    test("Ordinal date", () {
      expect(DateTime(2022, 3, 28).dayOfYear, 87);
      expect(DateTime(2020, 2, 29).dayOfYear, 60);
      expect(DateTime(2022, 3, 1).dayOfYear, 60);
      expect(DateTime(2020, 3, 1).dayOfYear, 61);
      expect(DateTime.fromMicrosecondsSinceEpoch(0).dayOfYear, 1);
    });

    group("Is At Same _ As Test", () {
      test("Comparison Test #1", () {
        final Moment local = DateTime(2003, 6, 1, 5, 7, 8, 600).toMoment();
        final Moment utc = DateTime(2003, 6, 1, 5, 7, 8, 600, 1).toMoment();

        expect(local.isAtSameYearAs(utc), true); // "same year"
        expect(local.isAtSameMonthAs(utc), true); // "same month"
        expect(local.isAtSameDayAs(utc), true); // "same day"
        expect(local.isAtSameHourAs(utc), true); // "same hour"
        expect(local.isAtSameMinuteAs(utc), true); // "same minute"
        expect(local.isAtSameSecondAs(utc), true); // "same second"
        expect(local.isAtSameMillisecondAs(utc), true); // "same millis"
        expect(local.isAtSameMicrosecondAs(utc), false); // "same microsecond"
        expect(local.isAtSameMomentAs(utc), false); // "same microsecond"
      });

      test("Comparison Test #2", () {
        final Moment local =
            DateTime(1972, 1, 1, 7).toMoment(); // Jan 1, 1972 at 7AM @GMT+8
        final Moment utc = local.toUtc(); // Dec 31, 1971 at 11PM @UTC

        expect(local.isAtSameYearAs(utc), true);
        expect(local.isAtSameMonthAs(utc), true);
        expect(local.isAtSameDayAs(utc), true);
        expect(local.isAtSameHourAs(utc), true);
        expect(local.isAtSameMinuteAs(utc), true);
        expect(local.isAtSameSecondAs(utc), true);
        expect(local.isAtSameMillisecondAs(utc), true);
        expect(local.isAtSameMicrosecondAs(utc), true);
        expect(local.isAtSameMomentAs(utc), true);
      });
    });

    group("Last Weekday", () {
      test("Last weekday: DateTime", () {
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

      test("Last weekday: Moment", () {
        Moment m = Moment.fromMicrosecondsSinceEpoch(86841989);

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

      test("Last weekday: BDay", () {
        DateTime m = DateTime(2003, 6, 1, 5, 33).toMoment();

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
      test("Next weekday: DateTime", () {
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

      test("Next weekday: Moment", () {
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

      test("Next weekday: BDay", () {
        DateTime m = DateTime(2003, 6, 1, 5, 33).toMoment();

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
      test("Start of Unit: DateTime", () {
        DateTime m = DateTime(2022, 6, 19, 21, 9, 33, 1, 1);
        print(m.startOfMillisecond());
        expect(m.startOfMillisecond(), DateTime(2022, 6, 19, 21, 9, 33, 1));
        print(m.startOfSecond());
        expect(m.startOfSecond(), DateTime(2022, 6, 19, 21, 9, 33));
        print(m.startOfMinute());
        expect(m.startOfMinute(), DateTime(2022, 6, 19, 21, 9));
        print(m.startOfHour());
        expect(m.startOfHour(), DateTime(2022, 6, 19, 21));
        print(m.startOfDay());
        expect(m.startOfDay(), DateTime(2022, 6, 19));
        print(m.startOfMonth());
        expect(m.startOfMonth(), DateTime(2022, 6));
        print(m.startOfYear());
        expect(m.startOfYear(), DateTime(2022));
      });
      test("Start of Unit: Moment", () {
        Moment m = DateTime(2003, 6, 1, 21, 9, 33, 1, 1).toMoment().toUtc();
        print(m.startOfMillisecond());
        expect(m.startOfMillisecond(), DateTime(2003, 6, 1, 21, 9, 33, 1));
        print(m.startOfSecond());
        expect(m.startOfSecond(), DateTime(2003, 6, 1, 21, 9, 33));
        print(m.startOfMinute());
        expect(m.startOfMinute(), DateTime(2003, 6, 1, 21, 9));
        print(m.startOfHour());
        expect(m.startOfHour(), DateTime(2003, 6, 1, 21));
        print(m.startOfDay());
        expect(m.startOfDay(), DateTime(2003, 6));
        print(m.startOfMonth());
        expect(m.startOfMonth(), DateTime(2003, 6));
        print(m.startOfYear());
        expect(m.startOfYear(), DateTime(2003));
      });
    });
  });

  group("Localizations", () {
    test('Mongolian', () {
      MomentLocalization localization = LocalizationMongolianCyrillic();
      final moment = Moment.now(localization: localization) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
          localization: localization);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localization.relative(const Duration(seconds: 2)),
          "хэдэн хормын дараа");
      expect(localization.weekdayName(epoch.weekday), "Пүрэв");
      expect(epochPlusFiveDays.from(epoch, true), "5 өдөр");
      expect(epochPlusFiveDays.from(epoch), "5 өдрийн дараа");
      expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true),
          "Өмнөх Пүрэв");
      expect(epochPlusFiveDays.calendar(reference: epoch, omitHours: true),
          "Мягмар");
      expect(epochPlusAYear.from(epoch), "1 жилийн дараа");
      expect(epochPlusAYear.calendar(reference: epoch), "1971/1/1 00:00");

      expect(epochPlusFiveDays.format("L LT"), "1970/01/06 00:00");
    });

    test('English', () {
      MomentLocalization localization = LocalizationEnUs();
      final moment = Moment.now(localization: localization) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
          localization: localization);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localization.relative(const Duration(seconds: 2)),
          "in a few seconds");
      expect(localization.weekdayName(epoch.weekday), "Thursday");
      expect(epochPlusFiveDays.from(epoch, true), "5 days");
      expect(epochPlusFiveDays.from(epoch), "in 5 days");
      expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true),
          "Last Thursday");
      expect(epochPlusFiveDays.calendar(reference: epoch, omitHours: true),
          "Tuesday");
      expect(epochPlusAYear.from(epoch), "in a year");
      expect(epochPlusAYear.calendar(reference: epoch), "1/1/1971 at 12:00 AM");

      expect(epochPlusFiveDays.format("L LT"), "01/06/1970 12:00 AM");
    });

    test('Traditional Mongolian', () {
      MomentLocalization localization = LocalizationMongolianTraditional();

      final moment = Moment.now(localization: localization) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
          localization: localization);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localization.relative(const Duration(seconds: 2)),
          "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ ᠤᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
      expect(localization.weekdayName(epoch.weekday), "ᠭᠠᠳᠠᠰᠤ");
      expect(epochPlusFiveDays.from(epoch, true), "5 ᠡᠳᠦᠷ");
      expect(epochPlusFiveDays.from(epoch), "5 ᠡᠳᠦᠷ ᠦᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
      expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true),
          "ᠡᠮᠦᠨᠡᠬᠢ ᠭᠠᠳᠠᠰᠤ");
      expect(epochPlusFiveDays.calendar(reference: epoch, omitHours: true),
          "ᠤᠯᠠᠭᠠᠨ");
      expect(epochPlusAYear.from(epoch), "1 ᠵᠢᠯ ᠤᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
      expect(epochPlusAYear.calendar(reference: epoch), "1971/1/1 00:00");

      expect(epochPlusFiveDays.format("L LT"), "1970/01/06 00:00");
    });

    test('Korean', () {
      MomentLocalization localization = LocalizationKorean();
      final moment = Moment.now(localization: localization) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
          localization: localization);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localization.relative(const Duration(seconds: 2)), "몇 초 후");
      expect(localization.weekdayName(epoch.weekday), "목"); //~요일
      expect(epochPlusFiveDays.from(epoch, true), "5일");
      expect(epochPlusFiveDays.from(epoch), "5일 후");
      expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true),
          "지난 목요일");
      expect(
          epochPlusFiveDays.calendar(reference: epoch, omitHours: true), "화요일");
      expect(epochPlusAYear.from(epoch), "1년 후");
      expect(epochPlusAYear.calendar(reference: epoch), "1971.1.1 오전 12:00");

      expect(epochPlusFiveDays.format("L LT"), "1970.01.06 오전 12:00");
    });

    test("Text escaping test", () {
      MomentLocalization localization = LocalizationEnUs();
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
          localization: localization);

      expect(epoch.format(r"[hellooo]"), "hellooo");
      expect(epoch.format(r"YYYY [escaped] YYYY"), "1970 escaped 1970");
      expect(epoch.format(r"L [L] LT [LT]"), "01/01/1970 L 12:00 AM LT");
      expect(epoch.format(r"l [L] LT [LT]"), "1/1/1970 L 12:00 AM LT");
      expect(epoch.format(r"YYYY [YYYY] MMMM [MMMM] Do [Do] LT [A]"),
          "1970 YYYY January MMMM 1st Do 12:00 AM A");
    });
  });

  test("Mongolain Number word gender test", () {
    // Powers of 10
    expect(LocalizationMongolianTraditional.isFeminine(1), true);
    expect(LocalizationMongolianTraditional.isFeminine(10), false);
    expect(LocalizationMongolianTraditional.isFeminine(100), false);
    expect(LocalizationMongolianTraditional.isFeminine(1000), false);
    expect(LocalizationMongolianTraditional.isFeminine(10000), false);

    // Units
    expect(LocalizationMongolianTraditional.isFeminine(2), false);
    expect(LocalizationMongolianTraditional.isFeminine(3), false);
    expect(LocalizationMongolianTraditional.isFeminine(4), true);
    expect(LocalizationMongolianTraditional.isFeminine(5), false);
    expect(LocalizationMongolianTraditional.isFeminine(6), false);
    expect(LocalizationMongolianTraditional.isFeminine(7), false);
    expect(LocalizationMongolianTraditional.isFeminine(8), false);
    expect(LocalizationMongolianTraditional.isFeminine(9), true);
    expect(LocalizationMongolianTraditional.isFeminine(10), false);
    expect(LocalizationMongolianTraditional.isFeminine(123452), false);
    expect(LocalizationMongolianTraditional.isFeminine(123453), false);
    expect(LocalizationMongolianTraditional.isFeminine(123454), true);
    expect(LocalizationMongolianTraditional.isFeminine(123455), false);
    expect(LocalizationMongolianTraditional.isFeminine(123456), false);
    expect(LocalizationMongolianTraditional.isFeminine(123457), false);
    expect(LocalizationMongolianTraditional.isFeminine(123458), false);
    expect(LocalizationMongolianTraditional.isFeminine(123459), true);
    expect(LocalizationMongolianTraditional.isFeminine(1234510), false);

    // Tens
    expect(LocalizationMongolianTraditional.isFeminine(123410), false);
    expect(LocalizationMongolianTraditional.isFeminine(123420), false);
    expect(LocalizationMongolianTraditional.isFeminine(123430), false);
    expect(LocalizationMongolianTraditional.isFeminine(123440), true);
    expect(LocalizationMongolianTraditional.isFeminine(123450), false);
    expect(LocalizationMongolianTraditional.isFeminine(123460), false);
    expect(LocalizationMongolianTraditional.isFeminine(123470), false);
    expect(LocalizationMongolianTraditional.isFeminine(123480), false);
    expect(LocalizationMongolianTraditional.isFeminine(123490), true);
  });
}
