// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  test("ar_PS range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.arPs());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "هذا الأسبوع");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "هذا الشهر");
    expect(thisYear.format(), "هذا العام");
    expect(year.format(), "عام 2021");
    expect(month.format(), "مارس 1205");
    expect(allAfterEpoch.format(), "بعد 1/1/1970");
    expect(allBeforeMyBirthday.format(), "قبل 1/6/2003");
    expect(allTime.format(), "كل الوقت");
  });

  test("de_DE range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.de());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Diese Woche");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Diesen Monat");
    expect(thisYear.format(), "Dieses Jahr");
    expect(year.format(), "Jahr 2021");
    expect(month.format(), "März 1205");
    expect(allAfterEpoch.format(), "Nach 1.1.1970");
    expect(allBeforeMyBirthday.format(), "Vor 1.6.2003");
    expect(allTime.format(), "Allzeit");
  });
  test("it_IT range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.it());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Questa settimana");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Questo mese");
    expect(thisYear.format(), "Quest'anno");
    expect(year.format(), "Anno 2021");
    expect(month.format(), "marzo 1205");
    expect(allAfterEpoch.format(), "Dopo 1/1/1970");
    expect(allBeforeMyBirthday.format(), "Prima di 1/6/2003");
    expect(allTime.format(), "Tutto il tempo");
  });
  test("fr_FR range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.fr());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Cette semaine");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Ce mois-ci");
    expect(thisYear.format(), "Cette année");
    expect(year.format(), "Année 2021");
    expect(month.format(), "mars 1205");
    expect(allAfterEpoch.format(), "Après 1/1/1970");
    expect(allBeforeMyBirthday.format(), "Avant 1/6/2003");
    expect(allTime.format(), "Tout le temps");
  });
  test("pt_PT range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.pt());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Esta semana");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Este mês");
    expect(thisYear.format(), "Este ano");
    expect(year.format(), "Ano 2021");
    expect(month.format(), "março 1205");
    expect(allAfterEpoch.format(), "Após 1/1/1970");
    expect(allBeforeMyBirthday.format(), "Antes de 1/6/2003");
    expect(allTime.format(), "Todo o tempo");
  });
  test("es_ES range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.es());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Esta semana");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Este mes");
    expect(thisYear.format(), "Este año");
    expect(year.format(), "Año 2021");
    expect(month.format(), "marzo 1205");
    expect(allAfterEpoch.format(), "Después 1/1/1970");
    expect(allBeforeMyBirthday.format(), "Antes 1/6/2003");
    expect(allTime.format(), "Todo el tiempo");
  });
  test("en_US range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.enUS());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "This week");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "This month");
    expect(thisYear.format(), "This year");
    expect(year.format(), "Year 2021");
    expect(month.format(), "March 1205");
    expect(allAfterEpoch.format(), "After 1/1/1970");
    expect(allBeforeMyBirthday.format(), "Before 6/1/2003");
    expect(allTime.format(), "All time");
  });
  test("mn_MN range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.mn());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Энэ долоо хоног");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Энэ сар");
    expect(thisYear.format(), "Энэ жил");
    expect(year.format(), "2021 он");
    expect(month.format(), "1205 оны 3 дугаар сар");
    expect(allAfterEpoch.format(), "1970/1/1-с хойш");
    expect(allBeforeMyBirthday.format(), "2003/6/1-с өмнө");
    expect(allTime.format(), "Бүх цаг үе");
  });
  test("mn_Mong_MN range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.mnMong());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "ᠡᠨᠡ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "ᠡᠨᠡ ᠰᠠᠷ᠎ᠠ");
    expect(thisYear.format(), "ᠡᠨᠡ ᠵᠢᠯ");
    expect(year.format(), "2021 ᠣᠨ");
    expect(month.format(), "1205 ᠣᠨ ᠤ 3 ᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ");
    expect(allAfterEpoch.format(), "1970/1/1 ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ");
    expect(allBeforeMyBirthday.format(), "2003/6/1 ᠡᠴᠡ ᠡᠮᠥᠨ᠎ᠡ");
    expect(allTime.format(), "ᠪᠦᠬᠦ ᠴᠠᠭ ᠦᠢ᠎ᠡ");
  });
  test("mn_Qaaq_MN range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.mnMongtn());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "ᠡᠨᠡ ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "ᠡᠨᠡ ᠰᠠᠷ᠎ᠠ");
    expect(thisYear.format(), "ᠡᠨᠡ ᠵᠢᠯ");
    expect(year.format(), "2021 ᠣᠨ");
    expect(month.format(), "᠑᠒᠐᠕ ᠣᠨ ᠤ ᠓ ᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ");
    expect(allAfterEpoch.format(), "᠑᠙᠗᠐/᠑/᠑ ᠡᠴᠡ ᠬᠣᠢᠢᠰᠢ");
    expect(allBeforeMyBirthday.format(), "᠒᠐᠐᠓/᠖/᠑ ᠡᠴᠡ ᠡᠮᠥᠨ᠎ᠡ");
    expect(allTime.format(), "ᠪᠦᠬᠦ ᠴᠠᠭ ᠦᠢ᠎ᠡ");
  });
  test("ko_KO range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.koKr());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "이번 주");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "이번 달");
    expect(thisYear.format(), "올해");
    expect(year.format(), "2021년");
    expect(month.format(), "1205년 3월");
    expect(allAfterEpoch.format(), "1970.1.1. 이후");
    expect(allBeforeMyBirthday.format(), "2003.6.1. 이전");
    expect(allTime.format(), "전체 시간");
  });
  test("zh_CN range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.zhCn());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "本周");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "本月");
    expect(thisYear.format(), "今年");
    expect(year.format(), "2021年");
    expect(month.format(), "1205年三月");
    expect(allAfterEpoch.format(), "1970/1/1之后");
    expect(allBeforeMyBirthday.format(), "2003/6/1之前");
    expect(allTime.format(), "全部时间");
  });
  test("ja_JP range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.jaJp());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "今週");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "今月");
    expect(thisYear.format(), "今年");
    expect(year.format(), "2021年");
    expect(month.format(), "1205年3月");
    expect(allAfterEpoch.format(), "1970/01/01以降");
    expect(allBeforeMyBirthday.format(), "2003/06/01以前");
    expect(allTime.format(), "全ての時間");
  });
  test("tr_TR range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.tr());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Bu hafta");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "Bu ay");
    expect(thisYear.format(), "Bu yıl");
    expect(year.format(), "2021 yılı");
    expect(month.format(), "Mart 1205");
    expect(allAfterEpoch.format(), "1.1.1970 tarihinden sonra");
    expect(allBeforeMyBirthday.format(), "1.6.2003 tarihinden önce");
    expect(allTime.format(), "Tüm zamanlar");
  });

  test("ru_RU range test", () {
    Moment.setGlobalLocalization(MomentLocalizations.ru());

    final thisWeek = TimeRange.thisLocalWeek();
    final thisWeekISO = TimeRange.thisIsoWeek();
    final thisMonth = TimeRange.thisMonth();
    final thisYear = TimeRange.thisYear();
    final year = YearTimeRange(2021);
    final month = MonthTimeRange(1205, 3);
    final allAfterEpoch = CustomTimeRange(Moment.epoch, Moment.maxValue);
    final allBeforeMyBirthday =
        CustomTimeRange(Moment.minValue, DateTime(2003, 6, 1));
    final allTime = TimeRange.allTime();

    expect(thisWeek.format(), "Эта неделя");
    expect(
      thisWeekISO.format(),
      "${thisWeekISO.from.toMoment().calendar(omitHours: true)} - ${thisWeekISO.to.toMoment().calendar(omitHours: true)}",
    );
    expect(thisMonth.format(), "В этом месяце");
    expect(thisYear.format(), "В этом году");
    expect(year.format(), "2021 год");
    expect(month.format(), "Март 1205");
    expect(allAfterEpoch.format(), "После 1.1.1970");
    expect(allBeforeMyBirthday.format(), "До 1.6.2003");
    expect(allTime.format(), "За все время");
  });
}
