import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  group("mn_MN", () {
    final MomentLocalization l10n = LocalizationMnMn();

    test("duration puts the genitive on the last printed unit", () {
      expect(l10n.duration(const Duration(days: 1, hours: 3)),
          "1 өдөр 3 цагийн дараа");
      expect(l10n.duration(-const Duration(days: 1, hours: 3)),
          "1 өдөр 3 цагийн өмнө");
      expect(l10n.duration(const Duration(days: 150)), "5 сарын дараа");
      expect(l10n.duration(-const Duration(days: 150)), "5 сарын өмнө");
      expect(l10n.duration(const Duration(minutes: 5)), "5 минутын дараа");
      expect(l10n.duration(const Duration(hours: 1)), "1 цагийн дараа");
      expect(l10n.duration(const Duration(days: 5)), "5 өдрийн дараа");
      expect(l10n.duration(const Duration(days: 365 * 3)), "3 жилийн дараа");
      expect(l10n.duration(const Duration(days: 14), includeWeeks: true),
          "2 долоо хоногийн дараа");
      expect(l10n.duration(const Duration(seconds: 30)), "30 секундын дараа");
      expect(l10n.duration(Duration.zero), "хэдэн хормын дараа");
    });

    test("duration without prefix/suffix stays in base form", () {
      expect(
        l10n.duration(const Duration(days: 1, hours: 3),
            dropPrefixOrSuffix: true),
        "1 өдөр 3 цаг",
      );
      expect(l10n.duration(Duration.zero, dropPrefixOrSuffix: true),
          "хэдэн хором");
    });

    test("abbreviated forms take no suffix and keep the full stem", () {
      expect(l10n.duration(const Duration(minutes: 5), form: Abbreviation.semi),
          "5 мин дараа");
      expect(l10n.duration(const Duration(minutes: 5), form: Abbreviation.full),
          "5м дараа");
      expect(
          l10n.duration(Duration.zero, form: Abbreviation.semi), "хором дараа");
      expect(l10n.relative(const Duration(seconds: 2), form: Abbreviation.semi),
          "хором дараа");
      expect(
          l10n.relative(-const Duration(seconds: 2), form: Abbreviation.full),
          "хором өмнө");
    });

    test("duration agrees with relative", () {
      for (final Duration d in const [
        Duration(minutes: 5),
        Duration(hours: 6),
        Duration(days: 2),
        Duration(days: 365 * 3),
      ]) {
        expect(l10n.duration(d), l10n.relative(d));
        expect(l10n.duration(-d), l10n.relative(-d));
      }
    });
  });

  group("ar_PS", () {
    final MomentLocalization l10n = LocalizationArPs();

    test("relative uses Arabic plural categories", () {
      expect(l10n.relative(-const Duration(minutes: 1)), "منذ دقيقة");
      expect(l10n.relative(-const Duration(minutes: 2)), "منذ دقيقتين");
      expect(
        l10n.relative(const Duration(minutes: 2), dropPrefixOrSuffix: true),
        "دقيقتان",
      );
      expect(l10n.relative(-const Duration(minutes: 3)), "منذ 3 دقائق");
      expect(l10n.relative(-const Duration(minutes: 10)), "منذ 10 دقائق");
      expect(l10n.relative(-const Duration(minutes: 11)), "منذ 11 دقيقة");
      expect(l10n.relative(-const Duration(days: 2)), "منذ يومين");
      expect(l10n.relative(-const Duration(days: 11)), "منذ 11 يومًا");
    });

    test("duration uses Arabic plural categories", () {
      Duration years(int n) => Duration(days: 365 * n);

      expect(l10n.duration(-years(2)), "منذ عامين");
      expect(l10n.duration(-years(5)), "منذ 5 أعوام");
      expect(l10n.duration(-years(11)), "منذ 11 عامًا");
      expect(l10n.duration(-years(100)), "منذ 100 عام");
      expect(l10n.duration(-years(101)), "منذ 101 عام");
      expect(l10n.duration(-years(103)), "منذ 103 أعوام");
      expect(l10n.duration(-years(111)), "منذ 111 عامًا");
    });

    test("duration joins units with و", () {
      expect(
        l10n.duration(const Duration(hours: 1, minutes: 5),
            dropPrefixOrSuffix: true),
        "ساعة و5 دقائق",
      );
      expect(
        l10n.duration(const Duration(hours: 2, minutes: 2),
            dropPrefixOrSuffix: true),
        "ساعتان ودقيقتان",
      );
      expect(
        l10n.duration(const Duration(hours: 2, minutes: 2)),
        "خلال ساعتين ودقيقتين",
      );
    });

    test("Levantine month names", () {
      final List<String> months = [
        for (int i = 1; i <= 12; i++)
          Moment(DateTime(2024, i, 2), localization: l10n).format("MMMM"),
      ];
      expect(months, [
        "كانون الثاني",
        "شباط",
        "آذار",
        "نيسان",
        "أيار",
        "حزيران",
        "تموز",
        "آب",
        "أيلول",
        "تشرين الأول",
        "تشرين الثاني",
        "كانون الأول",
      ]);
      expect(
          Moment(DateTime(2024, 8, 2), localization: l10n).format("MMM"), "آب");
    });

    test("weekday short and min forms", () {
      // 2024-01-01 is a Monday
      final List<String> short = [];
      final List<String> min = [];
      for (int i = 0; i < 7; i++) {
        final Moment m = Moment(DateTime(2024, 1, 1 + i), localization: l10n);
        short.add(m.format("ddd"));
        min.add(m.format("dd"));
      }
      expect(
          short, ["إثنين", "ثلاثاء", "أربعاء", "خميس", "جمعة", "سبت", "أحد"]);
      expect(min, ["ن", "ث", "ر", "خ", "ج", "س", "ح"]);
    });
  });

  test("ja_JP ordinals for quarter and week", () {
    final Moment m =
        Moment(DateTime(2024, 1, 5), localization: LocalizationJaJp());
    expect(m.format("Qo"), "第1四半期");
    expect(m.format("wo"), "第${m.week}週");
    expect(
      Moment(DateTime(2024, 6, 2), localization: LocalizationJaJp())
          .format("Qo"),
      "第2四半期",
    );
  });

  test("zh_CN week ordinal", () {
    final Moment m =
        Moment(DateTime(2024, 1, 5), localization: LocalizationZhCn());
    expect(m.format("wo"), "第${m.week}周");
  });

  test("ko_KR long formats use unpadded 12-hour time like LT", () {
    final MomentLocalization ko = LocalizationKoKr();
    final Moment m = Moment(DateTime(2024, 1, 5, 9, 5), localization: ko);
    expect(m.format("LT"), "오전 9:05");
    expect(m.format("LLL"), "2024년 1월 5일 오전 9:05");
    expect(m.format("LLLL"), "2024년 1월 5일 금요일 오전 9:05");
    final Moment pm = Moment(DateTime(2024, 1, 5, 21, 5), localization: ko);
    expect(pm.format("LLL"), "2024년 1월 5일 오후 9:05");
  });

  test("all-time range labels", () {
    expect(LocalizationJaJp().range(TimeRange.allTime()), "全期間");
    expect(LocalizationKoKr().range(TimeRange.allTime()), "전체 기간");
  });
}
