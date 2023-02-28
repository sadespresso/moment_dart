import 'package:moment_dart/moment_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // A
  var today = Moment.parse("2003-06-01T05:33:00.000Z"); // Sunday
  var tomorrow = today.add(const Duration(days: 1));
  var tueOrDayAfterTomorrow = today.add(const Duration(days: 2));
  var yesterday = today.subtract(const Duration(days: 1));
  var friOrdayBeforeYesterday = today.subtract(const Duration(days: 2));

  // B
  var lastMonday = today.lastMonday();
  var lastTuesday = today.lastTuesday();
  var lastWednesday = today.lastWednesday();
  var nextWednesday = today.nextWednesday();
  var nextThursday = today.nextThursday();
  var nextFriday = today.nextFriday();

  // C
  var epoch = Moment.fromMillisecondsSinceEpoch(0, isUtc: true);

  void ssetLocalization(MomentLocalization localization) {
    // A
    today = today.copyWith(localization: localization);
    tomorrow = tomorrow.copyWith(localization: localization);
    tueOrDayAfterTomorrow =
        tueOrDayAfterTomorrow.copyWith(localization: localization);
    yesterday = yesterday.copyWith(localization: localization);
    friOrdayBeforeYesterday =
        friOrdayBeforeYesterday.copyWith(localization: localization);
    // B
    lastMonday = lastMonday.copyWith(localization: localization);
    lastTuesday = lastTuesday.copyWith(localization: localization);
    lastWednesday = lastWednesday.copyWith(localization: localization);
    nextWednesday = nextWednesday.copyWith(localization: localization);
    nextThursday = nextThursday.copyWith(localization: localization);
    nextFriday = nextFriday.copyWith(localization: localization);
    // C
    epoch = epoch.copyWith(localization: localization);
  }

  test("de_DE localization calendar test", () {
    ssetLocalization(MomentLocalizations.de());

    // A
    expect(today.calendar(reference: today), "heute um 5:33");
    expect(tomorrow.calendar(reference: today), "morgen um 5:33");
    expect(
        tueOrDayAfterTomorrow.calendar(reference: today), "übermorgen um 5:33");
    expect(yesterday.calendar(reference: today), "gestern um 5:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today),
        "vorgestern um 5:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true),
        "letzten Montag");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "letzten Dienstag");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "letzten Mittwoch");
    expect(
        nextWednesday.calendar(reference: today, omitHours: true), "Mittwoch");
    expect(
        nextThursday.calendar(reference: today, omitHours: true), "Donnerstag");
    expect(nextFriday.calendar(reference: today, omitHours: true), "Freitag");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "Donnerstag, 1. Januar 1970 00:00");
  });

  test("it localization calendar test", () {
    ssetLocalization(MomentLocalizations.it());

    // A
    expect(today.calendar(reference: today), "oggi alle 05:33");
    expect(tomorrow.calendar(reference: today), "domani alle 05:33");
    expect(
        tueOrDayAfterTomorrow.calendar(reference: today), "martedì alle 05:33");
    expect(yesterday.calendar(reference: today), "ieri alle 05:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today),
        "Lo scorso venerdì alle 05:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true),
        "Lo scorso lunedì");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "Lo scorso martedì");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "Lo scorso mercoledì");
    expect(
        nextWednesday.calendar(reference: today, omitHours: true), "mercoledì");
    expect(nextThursday.calendar(reference: today, omitHours: true), "giovedì");
    expect(nextFriday.calendar(reference: today, omitHours: true), "venerdì");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "giovedì 1 gennaio 1970 00:00");

    // Sunday
    expect(
      lastMonday.subtract(const Duration(days: 1)).calendar(
            reference: today,
            omitHours: true,
          ),
      "La scorsa domenica",
    );

    // at zero
    expect(
      today.startOfDay().calendar(
            reference: today,
          ),
      "oggi a 00:00",
    );
    // at 1
    expect(
      today.startOfDay().add(const Duration(hours: 1)).calendar(
            reference: today,
          ),
      "oggi all'01:00",
    );
  });

  test("fr localization calendar test", () {
    ssetLocalization(MomentLocalizations.fr());

    // A
    expect(today.calendar(reference: today), "Aujourd'hui à 05:33");
    expect(tomorrow.calendar(reference: today), "Demain à 05:33");
    expect(tueOrDayAfterTomorrow.calendar(reference: today), "mardi à 05:33");
    expect(yesterday.calendar(reference: today), "Hier à 05:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today),
        "vendredi dernier à 05:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true),
        "lundi dernier");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "mardi dernier");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "mercredi dernier");
    expect(
        nextWednesday.calendar(reference: today, omitHours: true), "mercredi");
    expect(nextThursday.calendar(reference: today, omitHours: true), "jeudi");
    expect(nextFriday.calendar(reference: today, omitHours: true), "vendredi");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "jeudi 1 janvier 1970 00:00");
  });

  test("es localization calendar test", () {
    ssetLocalization(MomentLocalizations.es());

    // A
    expect(today.calendar(reference: today), "hoy a las 5:33");
    expect(tomorrow.calendar(reference: today), "mañana a las 5:33");
    expect(
        tueOrDayAfterTomorrow.calendar(reference: today), "martes a las 5:33");
    expect(yesterday.calendar(reference: today), "ayer a las 5:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today),
        "el viernes a las 5:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true), "el lunes");
    expect(
        lastTuesday.calendar(reference: today, omitHours: true), "el martes");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "el miércoles");
    expect(
        nextWednesday.calendar(reference: today, omitHours: true), "miércoles");
    expect(nextThursday.calendar(reference: today, omitHours: true), "jueves");
    expect(nextFriday.calendar(reference: today, omitHours: true), "viernes");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "jueves, 1 de enero de 1970 0:00");
  });

  test("en_US localization calendar test", () {
    ssetLocalization(MomentLocalizations.enUS());

    // A
    expect(today.calendar(reference: today), "Today at 5:33 AM");
    expect(tomorrow.calendar(reference: today), "Tomorrow at 5:33 AM");
    expect(
        tueOrDayAfterTomorrow.calendar(reference: today), "Tuesday at 5:33 AM");
    expect(yesterday.calendar(reference: today), "Yesterday at 5:33 AM");
    expect(friOrdayBeforeYesterday.calendar(reference: today),
        "Last Friday at 5:33 AM");
    // B
    expect(
        lastMonday.calendar(reference: today, omitHours: true), "Last Monday");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "Last Tuesday");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "Last Wednesday");
    expect(
        nextWednesday.calendar(reference: today, omitHours: true), "Wednesday");
    expect(
        nextThursday.calendar(reference: today, omitHours: true), "Thursday");
    expect(nextFriday.calendar(reference: today, omitHours: true), "Friday");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "Thursday, January 1 1970 12:00 AM");
  });

  test("mn localization calendar test", () {
    ssetLocalization(MomentLocalizations.mn());

    // A
    expect(today.calendar(reference: today), "Өнөөдөр 05:33");
    expect(tomorrow.calendar(reference: today), "Маргааш 05:33");
    expect(tueOrDayAfterTomorrow.calendar(reference: today), "Нөгөөдөр 05:33");
    expect(yesterday.calendar(reference: today), "Өчигдөр 05:33");
    expect(
        friOrdayBeforeYesterday.calendar(reference: today), "Уржигдар 05:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true),
        "Өнгөрсөн Даваа");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "Өнгөрсөн Мягмар");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "Өнгөрсөн Лхагва");
    expect(nextWednesday.calendar(reference: today, omitHours: true), "Лхагва");
    expect(nextThursday.calendar(reference: today, omitHours: true), "Пүрэв");
    expect(nextFriday.calendar(reference: today, omitHours: true), "Баасан");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(
        epoch.format("LLLL"), "Пүрэв гараг, 1970 оны 1 дүгээр сарын 1, 00:00");
  });

  test("mn (Traditional) localization calendar test", () {
    ssetLocalization(MomentLocalizations.mnMong());

    // A
    expect(today.calendar(reference: today), "ᠥᠨᠦᠳᠦᠷ 05:33");
    expect(tomorrow.calendar(reference: today), "ᠮᠠᠷᠭᠠᠰᠢ 05:33");
    expect(tueOrDayAfterTomorrow.calendar(reference: today), "ᠨᠥᠭᠦᠭᠡᠳᠦᠷ 05:33");
    expect(yesterday.calendar(reference: today), "ᠦᠴᠦᠭᠡᠳᠦᠷ 05:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today), "ᠤᠷᠵᠢᠳᠤᠷ 05:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠰᠠᠷᠠᠨ");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠤᠯᠠᠭᠠᠨ");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠥᠯᠡᠮᠵᠢ");
    expect(nextWednesday.calendar(reference: today, omitHours: true), "ᠥᠯᠡᠮᠵᠢ");
    expect(nextThursday.calendar(reference: today, omitHours: true), "ᠭᠠᠳᠠᠰᠤ");
    expect(nextFriday.calendar(reference: today, omitHours: true), "ᠴᠣᠯᠮᠤᠨ");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"),
        "ᠭᠠᠳᠠᠰᠤ ᠡᠳᠦᠷ, 1970 ᠣᠨ ᠤ 1 ᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ ᠶᠢᠨ 1᠂ 00:00");
  });

  test("mn (Traditional with numbers) localization calendar test", () {
    ssetLocalization(MomentLocalizations.mnMongtn());

    // A
    expect(today.calendar(reference: today), "ᠥᠨᠦᠳᠦᠷ ᠐᠕:᠓᠓");
    expect(tomorrow.calendar(reference: today), "ᠮᠠᠷᠭᠠᠰᠢ ᠐᠕:᠓᠓");
    expect(tueOrDayAfterTomorrow.calendar(reference: today), "ᠨᠥᠭᠦᠭᠡᠳᠦᠷ ᠐᠕:᠓᠓");
    expect(yesterday.calendar(reference: today), "ᠦᠴᠦᠭᠡᠳᠦᠷ ᠐᠕:᠓᠓");
    expect(friOrdayBeforeYesterday.calendar(reference: today), "ᠤᠷᠵᠢᠳᠤᠷ ᠐᠕:᠓᠓");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠰᠠᠷᠠᠨ");
    expect(lastTuesday.calendar(reference: today, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠤᠯᠠᠭᠠᠨ");
    expect(lastWednesday.calendar(reference: today, omitHours: true),
        "ᠥᠩᠭᠡᠷᠡᠭᠰᠡᠨ ᠥᠯᠡᠮᠵᠢ");
    expect(nextWednesday.calendar(reference: today, omitHours: true), "ᠥᠯᠡᠮᠵᠢ");
    expect(nextThursday.calendar(reference: today, omitHours: true), "ᠭᠠᠳᠠᠰᠤ");
    expect(nextFriday.calendar(reference: today, omitHours: true), "ᠴᠣᠯᠮᠤᠨ");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"),
        "ᠭᠠᠳᠠᠰᠤ ᠡᠳᠦᠷ, ᠑᠙᠗᠐ ᠣᠨ ᠤ ᠑ ᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ ᠶᠢᠨ ᠑᠂ ᠐᠐:᠐᠐");
  });

  test("ko localization calendar test", () {
    ssetLocalization(MomentLocalizations.ko());

    // A
    expect(today.calendar(reference: today), "오늘 오전 5:33");
    expect(tomorrow.calendar(reference: today), "내일 오전 5:33");
    expect(tueOrDayAfterTomorrow.calendar(reference: today), "모레 오전 5:33");
    expect(yesterday.calendar(reference: today), "어제 오전 5:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today), "그저께 오전 5:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true), "지난 월요일");
    expect(lastTuesday.calendar(reference: today, omitHours: true), "지난 화요일");
    expect(lastWednesday.calendar(reference: today, omitHours: true), "지난 수요일");
    expect(nextWednesday.calendar(reference: today, omitHours: true), "수요일");
    expect(nextThursday.calendar(reference: today, omitHours: true), "목요일");
    expect(nextFriday.calendar(reference: today, omitHours: true), "금요일");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "1970년 1월 1일 목요일 오전 12:00");
  });

  test("zh_CN localization calendar test", () {
    ssetLocalization(MomentLocalizations.zhCn());

    // A
    expect(today.calendar(reference: today), "今天 05:33");
    expect(tomorrow.calendar(reference: today), "明天 05:33");
    expect(tueOrDayAfterTomorrow.calendar(reference: today), "后天 05:33");
    expect(yesterday.calendar(reference: today), "昨天 05:33");
    expect(friOrdayBeforeYesterday.calendar(reference: today), "前天 05:33");
    // B
    expect(lastMonday.calendar(reference: today, omitHours: true), "上星期一");
    expect(lastTuesday.calendar(reference: today, omitHours: true), "上星期二");
    expect(lastWednesday.calendar(reference: today, omitHours: true), "上星期三");
    expect(nextWednesday.calendar(reference: today, omitHours: true), "下星期三");
    expect(nextThursday.calendar(reference: today, omitHours: true), "下星期四");
    expect(nextFriday.calendar(reference: today, omitHours: true), "下星期五");
    // C
    expect(epoch.calendar(reference: today, omitHours: true), epoch.format());
    expect(epoch.format("LLLL"), "1970年1月1日星期四凌晨12点00分");
  });
}
