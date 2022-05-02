import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/en_US.dart';
import 'package:moment_dart/src/localizations/mn_MN.dart';
import 'package:moment_dart/src/localizations/mn_TM.dart';
import 'package:moment_dart/src/moment.dart';
import 'package:test/test.dart';

void main() {
  group("All", () {
    test("Leap Year", () {
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
    });

    test('Mongolian', () {
      MomentLocalization localizationMongolianCyrillic = LocalizationMongolianCyrillic();
      final moment = Moment.now(localization: localizationMongolianCyrillic) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0), localization: localizationMongolianCyrillic);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localizationMongolianCyrillic.relative(const Duration(seconds: 2)), "хэдэн хоромын дараа");
      expect(localizationMongolianCyrillic.weekdayName(epoch.weekday), "Пүрэв");
      expect(epochPlusFiveDays.from(epoch, true), "5 өдөр");
      expect(epochPlusFiveDays.from(epoch), "5 өдрийн дараа");
      expect(epochPlusAYear.from(epoch), "жилийн дараа");
    });

    test('English', () {
      MomentLocalization localization = LocalizationEnUs();
      final moment = Moment.now(localization: localization) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true), localization: localization);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localization.relative(const Duration(seconds: 2)), "in a few seconds");
      expect(localization.weekdayName(epoch.weekday), "Thursday");
      expect(epochPlusFiveDays.from(epoch, true), "5 days");
      expect(epochPlusFiveDays.from(epoch), "in 5 days");
      expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true), "Last Thursday");
      expect(epochPlusFiveDays.calendar(reference: epoch, omitHours: true), "Tuesday");
      expect(epochPlusAYear.from(epoch), "in a year");
      expect(epochPlusAYear.calendar(reference: epoch), "01/01/1971 at 12:00 AM");

      expect(epochPlusFiveDays.format("L LT"), "01/06/1970 12:00 AM");
    });

    test('Traditional Mongolian', () {
      MomentLocalization localization = LocalizationMongolianTraditional();
      final moment = Moment.now(localization: localization) - Duration(days: 1);
      final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0), localization: localization);
      final epochPlusFiveDays = epoch + Duration(days: 5);
      final epochPlusAYear = epoch + Duration(days: 365);

      expect(moment.lastMonday().weekday, 1);
      expect(localization.relative(const Duration(seconds: 2)), "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ ᠤᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
      expect(localization.weekdayName(epoch.weekday), "ᠭᠠᠳᠠᠰᠤ");
      expect(epochPlusFiveDays.from(epoch, true), "5 ᠡᠳᠦᠷ");
      expect(epochPlusFiveDays.from(epoch), "5 ᠡᠳᠦᠷ ᠦᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
      expect(epochPlusAYear.from(epoch), "ᠵᠢᠯ ᠦᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
    });
  });
}
