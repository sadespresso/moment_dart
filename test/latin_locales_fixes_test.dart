import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  final friday = DateTime(2024, 1, 5, 9, 5, 7);
  final reference = DateTime(2024, 6, 12, 12); // Wednesday

  String fmt(MomentLocalization l10n, DateTime dateTime, String format) =>
      Moment(dateTime, localization: l10n).format(format);

  group("es_ES", () {
    final l10n = MomentLocalizations.es();

    test("endonym has no country", () {
      expect(l10n.endonym, "Español");
    });

    test("last weekday is spelled 'pasado'", () {
      final lastThursday = DateTime(2024, 6, 6, 13, 5);

      expect(
        Moment(lastThursday, localization: l10n).calendar(reference: reference),
        "el jueves pasado a las 13:05",
      );
    });

    test("an hour is feminine", () {
      expect(l10n.relative(const Duration(hours: -1)), "hace una hora");
      expect(l10n.relative(const Duration(hours: 1)), "en una hora");
      expect(
        l10n.duration(const Duration(hours: 1, minutes: 41),
            dropPrefixOrSuffix: true),
        "1 hora 41 minutos",
      );
    });

    test("open-ended ranges", () {
      expect(
        l10n.range(CustomTimeRange(DateTime(2024, 3, 1), Moment.maxValue)),
        "Desde el 1/3/2024",
      );
      expect(
        l10n.range(CustomTimeRange(Moment.minValue, DateTime(2024, 3, 1))),
        "Hasta el 1/3/2024",
      );

      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final inThreeDays = DateTime(now.year, now.month, now.day + 3);

      expect(
        l10n.range(CustomTimeRange(yesterday, Moment.maxValue)),
        "Desde ayer",
      );
      expect(
        l10n.range(CustomTimeRange(Moment.minValue, inThreeDays)),
        "Hasta el ${l10n.weekdayName[inThreeDays.weekday]}",
      );
    });
  });

  group("pt_PT", () {
    final l10n = MomentLocalizations.pt();

    test("endonym is the language name", () {
      expect(l10n.endonym, "Português");
    });

    test("long date formats use a cardinal day", () {
      expect(fmt(l10n, friday, "LL"), "5 de janeiro de 2024");
      expect(fmt(l10n, friday, "ll"), "5 de jan de 2024");
      expect(fmt(l10n, friday, "LLL"), "5 de janeiro de 2024 09:05");
      expect(
        fmt(l10n, friday, "LLLL"),
        "sexta-feira, 5 de janeiro de 2024 09:05",
      );
      expect(fmt(l10n, friday, "llll"), "sex, 5 de jan de 2024 09:05");
      expect(fmt(l10n, friday, "Do"), "5º");
    });

    test("weekday min forms are unambiguous", () {
      final List<String> mins = [
        for (int i = 0; i < 7; i++) fmt(l10n, DateTime(2024, 1, 1 + i), "dd"),
      ];

      expect(mins, ["2ª", "3ª", "4ª", "5ª", "6ª", "Sá", "Do"]);
      expect(fmt(l10n, friday, "ddd"), "sex");
    });

    test("months are spelled 'meses'", () {
      const fourMonths = Duration(days: 122);
      final months = DurationFormat([DurationUnit.month]);

      expect(l10n.relative(-fourMonths), "há 4 meses");
      expect(
        l10n.duration(fourMonths,
            format: months, form: Abbreviation.semi, dropPrefixOrSuffix: true),
        "4 meses",
      );
      expect(
        l10n.duration(fourMonths,
            format: months, form: Abbreviation.full, dropPrefixOrSuffix: true),
        "4 meses",
      );
      expect(
        l10n.duration(const Duration(days: 30),
            format: months, form: Abbreviation.full, dropPrefixOrSuffix: true),
        "1 mês",
      );
    });

    test("weekdays are lowercase except at sentence start", () {
      String cal(DateTime dateTime) =>
          Moment(dateTime, localization: l10n).calendar(reference: reference);

      expect(cal(DateTime(2024, 6, 6, 13, 5)), "Última quinta-feira às 13:05");
      expect(cal(DateTime(2024, 6, 9, 13, 5)), "Último domingo às 13:05");
      expect(cal(DateTime(2024, 6, 14, 13, 5)), "Sexta-feira às 13:05");
      expect(fmt(l10n, friday, "dddd"), "sexta-feira");
    });
  });

  group("en_US", () {
    final l10n = MomentLocalizations.enUS();

    test("long date formats", () {
      expect(fmt(l10n, friday, "LL"), "January 5, 2024");
      expect(fmt(l10n, friday, "ll"), "Jan 5, 2024");
      expect(fmt(l10n, friday, "LLL"), "January 5, 2024 9:05 AM");
      expect(fmt(l10n, friday, "lll"), "Jan 5, 2024 9:05 AM");
      expect(fmt(l10n, friday, "LLLL"), "Friday, January 5, 2024 9:05 AM");
      expect(fmt(l10n, friday, "llll"), "Fri, Jan 5, 2024 9:05 AM");
      expect(fmt(l10n, friday, "LT"), "9:05 AM");
    });

    test("semi-abbreviated days are plural", () {
      expect(
        l10n.duration(const Duration(days: 3),
            form: Abbreviation.semi, dropPrefixOrSuffix: true),
        "3 days",
      );
      expect(
        l10n.duration(const Duration(days: 1),
            form: Abbreviation.semi, dropPrefixOrSuffix: true),
        "1 day",
      );
    });
  });

  group("de_DE", () {
    final l10n = MomentLocalizations.de();

    test("times are zero-padded", () {
      expect(fmt(l10n, friday, "LT"), "09:05");
      expect(fmt(l10n, friday, "LTS"), "09:05:07");
      expect(fmt(l10n, friday, "lll"), "5. Jan. 2024 09:05");
      expect(fmt(l10n, friday, "llll"), "Fr., 5. Jan. 2024 09:05");
      expect(fmt(l10n, friday, "LLL"), "5. Januar 2024 09:05");
    });

    test("this month", () {
      expect(
        l10n.range(MonthTimeRange(2024, 6), anchor: reference),
        "Dieser Monat",
      );
    });
  });

  group("fr_FR", () {
    final l10n = MomentLocalizations.fr();

    test("short April", () {
      expect(fmt(l10n, DateTime(2024, 4, 5), "MMM"), "avr.");
      expect(fmt(l10n, DateTime(2024, 4, 5), "ll"), "5 avr. 2024");
    });

    test("day of month ordinal", () {
      expect(fmt(l10n, DateTime(2024, 4, 1), "Do MMMM"), "1er avril");
      expect(fmt(l10n, DateTime(2024, 4, 2), "Do MMMM"), "2 avril");
      expect(fmt(l10n, DateTime(2024, 4, 21), "Do"), "21");
    });

    test("other ordinals", () {
      expect(fmt(l10n, DateTime(2024, 1, 5), "Mo"), "1er");
      expect(fmt(l10n, DateTime(2024, 2, 5), "Mo"), "2e");
      expect(fmt(l10n, DateTime(2024, 1, 3), "wo"), "1re");
      expect(fmt(l10n, DateTime(2024, 1, 10), "wo"), "2e");
      expect(fmt(l10n, DateTime(2024, 1, 2), "DDDo"), "2e");
    });
  });

  group("tr_TR", () {
    final l10n = MomentLocalizations.tr();

    test("short formats pad the hour like LT", () {
      expect(fmt(l10n, friday, "LT"), "09:05");
      expect(fmt(l10n, friday, "lll"), "5 Oca 2024 09:05");
      expect(fmt(l10n, friday, "llll"), "Cum, 5 Oca 2024 09:05");
    });
  });
}
