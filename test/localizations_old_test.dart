import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  test('Mongolian', () {
    MomentLocalization localization = LocalizationMnMn();
    final moment = Moment.now(localization: localization) - Duration(days: 1);
    final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
        localization: localization);
    final epochPlusFiveDays = epoch + Duration(days: 5);
    final epochPlusAYear = epoch + Duration(days: 365);

    expect(moment.lastMonday().weekday, 1);
    expect(localization.relative(const Duration(seconds: 2)),
        "хэдэн хормын дараа");
    expect(localization.weekdayName[epoch.weekday], "Пүрэв");
    expect(epochPlusFiveDays.from(epoch, true), "5 өдөр");
    expect(epochPlusFiveDays.from(epoch), "5 өдрийн дараа");
    expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true),
        "Өнгөрсөн Пүрэв");
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
    expect(
        localization.relative(const Duration(seconds: 2)), "in a few seconds");
    expect(localization.weekdayName[epoch.weekday], "Thursday");
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
    MomentLocalization localization = LocalizationMnMongMn();

    final moment = Moment.now(localization: localization) - Duration(days: 1);
    final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
        localization: localization);
    final epochPlusFiveDays = epoch + Duration(days: 5);
    final epochPlusAYear = epoch + Duration(days: 365);

    expect(moment.lastMonday().weekday, 1);
    expect(localization.relative(const Duration(seconds: 2)),
        "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ ᠤᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
    expect(localization.weekdayName[epoch.weekday], "ᠭᠠᠳᠠᠰᠤ");
    expect(epochPlusFiveDays.from(epoch, true), "5 ᠡᠳᠦᠷ");
    expect(epochPlusFiveDays.from(epoch), "5 ᠡᠳᠦᠷ ᠦᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
    expect(epoch.calendar(reference: epochPlusFiveDays, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠭᠠᠳᠠᠰᠤ");
    expect(epochPlusFiveDays.calendar(reference: epoch, omitHours: true),
        "ᠤᠯᠠᠭᠠᠨ");
    expect(epochPlusAYear.from(epoch), "1 ᠵᠢᠯ ᠤᠨ ᠳᠠᠷᠠᠭ᠎ᠠ");
    expect(epochPlusAYear.calendar(reference: epoch), "1971/1/1 00:00");

    expect(epochPlusFiveDays.format("L LT"), "1970/01/06 00:00");
  });

  test('Korean', () {
    MomentLocalization localization = LocalizationKo();
    final moment = Moment.now(localization: localization) - Duration(days: 1);
    final epoch = Moment(DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true),
        localization: localization);
    final epochPlusFiveDays = epoch + Duration(days: 5);
    final epochPlusAYear = epoch + Duration(days: 365);

    expect(moment.lastMonday().weekday, 1);
    expect(localization.relative(const Duration(seconds: 2)), "몇 초 후");
    expect(localization.weekdayName[epoch.weekday], "목요일");
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
}
