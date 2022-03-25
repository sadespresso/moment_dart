import 'package:moment_dart/src/localizations.dart';
import 'package:moment_dart/src/localizations/en_US.dart';
import 'package:moment_dart/src/localizations/mn_MN.dart';
import 'package:moment_dart/src/localizations/mn_TM.dart';
import 'package:moment_dart/src/moment.dart';
import 'package:test/test.dart';

void main() {
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
    expect(epochPlusAYear.calendar(reference: epoch), "01/01/1971 at 12:00AM");
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
}
