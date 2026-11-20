import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  const DurationFormat hms = DurationFormat([
    DurationUnit.hour,
    DurationUnit.minute,
    DurationUnit.second,
  ]);

  // Wednesday, away from any DST transition
  final DateTime reference = DateTime(2024, 1, 10, 12);
  Moment day(int offset, MomentLocalization l10n) =>
      Moment(DateTime(2024, 1, 10 + offset, 13, 5), localization: l10n);

  group("ru_RU", () {
    final MomentLocalization ru = LocalizationRuRu();

    test("month names in dates are genitive and lowercase", () {
      final Moment m = Moment(DateTime(2024, 1, 5, 9, 5), localization: ru);

      expect(m.format("LL"), "5 января 2024");
      expect(m.format("LLL"), "5 января 2024 09:05");
      expect(m.format("LLLL"), "пятница, 5 января 2024 09:05");
      expect(m.format("ll"), "5 янв. 2024");
      expect(m.format("llll"), "Пт, 5 янв. 2024 9:05");
      expect(m.format("MMMM"), "январь");
      expect(m.format("MMM"), "янв.");
      expect(m.format("dddd"), "пятница");

      final Moment may = Moment(DateTime(2024, 5, 9), localization: ru);
      expect(may.format("LL"), "9 мая 2024");
      expect(may.format("ll"), "9 мая 2024");
      expect(may.format("MMMM"), "май");
    });

    test("short Monday is Пн", () {
      final Moment monday = Moment(DateTime(2024, 1, 1), localization: ru);

      expect(monday.format("ddd"), "Пн");
      expect(monday.format("dd"), "Пн");
    });

    test("numbers ending in 1 take the accusative after через/назад", () {
      expect(ru.relative(const Duration(minutes: -21)), "21 минуту назад");
      expect(ru.relative(const Duration(minutes: -31)), "31 минуту назад");
      expect(ru.relative(const Duration(minutes: -11)), "11 минут назад");
      expect(
        ru.relative(const Duration(minutes: -21), dropPrefixOrSuffix: true),
        "21 минута",
      );
      expect(
        ru.duration(const Duration(seconds: 21), format: DurationFormat.s),
        "через 21 секунду",
      );
      expect(
        ru.duration(const Duration(minutes: 101), format: DurationFormat.ms),
        "через 101 минуту",
      );
      expect(
        ru.duration(
          const Duration(days: -21 * 7),
          format: DurationFormat.wd,
          includeWeeks: true,
        ),
        "21 неделю назад",
      );
      expect(ru.relative(const Duration(minutes: 1)), "через минуту");
      expect(ru.relative(const Duration(minutes: -1)), "минуту назад");
      expect(
        ru.duration(const Duration(hours: 21), format: DurationFormat.hm),
        "через 21 час",
      );
    });

    test("short forms keep the number and a space", () {
      expect(
        ru.relative(const Duration(minutes: -1), form: Abbreviation.semi),
        "1 мин назад",
      );
      expect(
        ru.duration(
          const Duration(hours: 1, minutes: 5),
          form: Abbreviation.semi,
          dropPrefixOrSuffix: true,
        ),
        "1 ч 5 мин",
      );
    });

    test("full durations show 1 and join with commas", () {
      expect(
        ru.duration(
          const Duration(hours: 1, minutes: 41),
          dropPrefixOrSuffix: true,
        ),
        "1 час и 41 минута",
      );
      expect(
        ru.duration(const Duration(hours: 1, minutes: 41)),
        "через 1 час и 41 минуту",
      );
      expect(
        ru.duration(
          const Duration(hours: 2, minutes: 3, seconds: 4),
          format: hms,
          dropPrefixOrSuffix: true,
        ),
        "2 часа, 3 минуты и 4 секунды",
      );
      expect(
        ru.duration(
          const Duration(hours: -1, minutes: -1, seconds: -1),
          format: hms,
        ),
        "1 час, 1 минуту и 1 секунду назад",
      );
      expect(
        ru.duration(
          const Duration(hours: 2, minutes: 3, seconds: 4),
          format: hms,
          delimiter: " / ",
          dropPrefixOrSuffix: true,
        ),
        "2 часа / 3 минуты / 4 секунды",
      );
      expect(ru.relative(const Duration(hours: -1)), "час назад");
    });

    test("calendar weekdays with a time use the accusative phrase", () {
      // A full week back is outside the 1..6-day window, so it is a date
      expect(day(-7, ru).calendar(reference: reference), "3.1.2024");
      expect(day(-6, ru).calendar(reference: reference),
          "В прошлый четверг в 13:05");
      expect(day(-5, ru).calendar(reference: reference),
          "В прошлую пятницу в 13:05");
      expect(day(-4, ru).calendar(reference: reference),
          "В прошлую субботу в 13:05");
      expect(day(-3, ru).calendar(reference: reference),
          "В прошлое воскресенье в 13:05");
      expect(day(3, ru).calendar(reference: reference), "В субботу в 13:05");
      expect(
          day(5, ru).calendar(reference: reference), "В понедельник в 13:05");
      expect(day(6, ru).calendar(reference: reference), "Во вторник в 13:05");
      expect(day(0, ru).calendar(reference: reference), "Сегодня в 13:05");

      expect(
        day(-5, ru).calendar(reference: reference, omitHours: true),
        "Прошлая пятница",
      );
      expect(
        day(6, ru).calendar(reference: reference, omitHours: true),
        "Вторник",
      );
    });

    test("range labels share one style", () {
      final DateTime anchor = DateTime(2024, 3, 15);

      expect(ru.range(MonthTimeRange(2024, 3), anchor: anchor), "Этот месяц");
      expect(ru.range(YearTimeRange(2024), anchor: anchor), "Этот год");
      expect(ru.range(MonthTimeRange(2024, 1), anchor: anchor), "Январь");
    });
  });

  group("pl_PL", () {
    final MomentLocalization pl = LocalizationPlPl();

    test("weekday and month names in dates are lowercase", () {
      final Moment m = Moment(DateTime(2024, 1, 5, 9, 5), localization: pl);

      expect(m.format("LLLL"), "piątek, 5 stycznia 2024 09:05");
      expect(m.format("ll"), "5 sty 2024");
      expect(m.format("llll"), "Pt, 5 sty 2024 9:05");
      expect(m.format("dddd"), "piątek");
      expect(m.format("MMMM"), "styczeń");
    });

    test("short forms keep the number", () {
      expect(
        pl.relative(const Duration(minutes: -1), form: Abbreviation.semi),
        "1 min temu",
      );
      expect(
        pl.duration(
          const Duration(hours: 1, minutes: 5),
          form: Abbreviation.semi,
          dropPrefixOrSuffix: true,
        ),
        "1 godz. 5 min",
      );
      expect(
        pl.duration(
          const Duration(days: 365 + 60),
          form: Abbreviation.semi,
          dropPrefixOrSuffix: true,
        ),
        "1 r. 2 mies.",
      );
    });

    test("full durations show 1, use the accusative and join with commas", () {
      expect(
        pl.duration(
          const Duration(hours: -1, minutes: -1, seconds: -1),
          format: hms,
        ),
        "1 godzinę, 1 minutę i 1 sekundę temu",
      );
      expect(
        pl.duration(
          const Duration(hours: 1, minutes: 1, seconds: 1),
          format: hms,
          dropPrefixOrSuffix: true,
        ),
        "1 godzina, 1 minuta i 1 sekunda",
      );
      expect(
        pl.duration(
          const Duration(hours: 2, minutes: 3, seconds: 4),
          format: hms,
        ),
        "za 2 godziny, 3 minuty i 4 sekundy",
      );
      expect(
        pl.duration(const Duration(hours: 1, minutes: 21)),
        "za 1 godzinę i 21 minut",
      );
      expect(pl.relative(const Duration(minutes: -1)), "minutę temu");
    });

    test("calendar uses zeszły/zeszłą and accusative weekdays", () {
      expect(day(-7, pl).calendar(reference: reference), "3.1.2024");
      expect(day(-6, pl).calendar(reference: reference),
          "W zeszły czwartek o 13:05");
      expect(day(-5, pl).calendar(reference: reference),
          "W zeszły piątek o 13:05");
      expect(day(-4, pl).calendar(reference: reference),
          "W zeszłą sobotę o 13:05");
      expect(day(-3, pl).calendar(reference: reference),
          "W zeszłą niedzielę o 13:05");
      expect(day(3, pl).calendar(reference: reference), "W sobotę o 13:05");
      expect(day(4, pl).calendar(reference: reference), "W niedzielę o 13:05");
      expect(day(6, pl).calendar(reference: reference), "We wtorek o 13:05");

      expect(
        day(-6, pl).calendar(reference: reference, omitHours: true),
        "Zeszły czwartek",
      );
      expect(
        day(4, pl).calendar(reference: reference, omitHours: true),
        "Niedziela",
      );
    });

    test("range labels share one style", () {
      final DateTime anchor = DateTime(2024, 3, 15);

      expect(pl.range(MonthTimeRange(2024, 3), anchor: anchor), "Ten miesiąc");
      expect(pl.range(YearTimeRange(2024), anchor: anchor), "Ten rok");
      expect(pl.range(TimeRange.allTime()), "Cały okres");
    });
  });
}
