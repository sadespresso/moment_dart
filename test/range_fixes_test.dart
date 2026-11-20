import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

const Duration _aMicrosecond = Duration(microseconds: 1);

int _calendarDays(DateTime a, DateTime b) =>
    DateTime.utc(a.year, a.month, a.day)
        .difference(DateTime.utc(b.year, b.month, b.day))
        .inDays;

/// Uses [MomentLocalization]'s own calendar() and range(), with no mixins.
class _BaseLocalization extends MomentLocalization {
  final LocalizationEnUs _en = LocalizationEnUs();

  @override
  String relative(
    Duration duration, {
    bool dropPrefixOrSuffix = false,
    Abbreviation form = Abbreviation.none,
  }) =>
      _en.relative(duration, dropPrefixOrSuffix: dropPrefixOrSuffix);

  @override
  String duration(
    Duration duration, {
    bool round = true,
    bool omitZeros = true,
    bool includeWeeks = false,
    Abbreviation form = Abbreviation.none,
    String? delimiter,
    DurationFormat format = DurationFormat.auto,
    bool dropPrefixOrSuffix = false,
  }) =>
      _en.duration(duration);

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() => {
        FormatterToken.MMMM: (dateTime) => _en.monthNames[dateTime.month]!,
        FormatterToken.l: (dateTime) => reformat(dateTime, "M/D/YYYY"),
        FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
      };

  @override
  CalendarLocalizationData? get calendarData => const CalendarLocalizationData(
        relativeDayNames: {-1: "Yesterday", 0: "Today", 1: "Tomorrow"},
        keywords: CalendarLocalizationKeywords(),
      );

  @override
  Map<int, String> get weekdayName => _en.weekdayName;

  @override
  String get languageCode => "xx";

  @override
  String? get countryCode => null;

  @override
  String get endonym => "Test";

  @override
  String get languageNameInEnglish => "Test";
}

void main() {
  setUp(() => Moment.setGlobalLocalization(MomentLocalizations.enUS()));

  group("Week paging", () {
    test("IsoWeekTimeRange.next/last move by exactly one week", () {
      // Includes the 2025 DST transitions of most zones that have DST
      for (final DateTime start in [
        DateTime(2025, 3, 11),
        DateTime(2025, 3, 31),
        DateTime(2025, 10, 28),
        DateTime(2025, 11, 4),
        DateTime.utc(2025, 10, 28),
      ]) {
        final IsoWeekTimeRange week = IsoWeekTimeRange(start);

        expect(_calendarDays(week.next.from, week.from), 7);
        expect(_calendarDays(week.from, week.last.from), 7);
        expect(week.next.from.weekday, DateTime.monday);
        expect(week.last.from.weekday, DateTime.monday);
        expect(week.next.isUtc, start.isUtc);
        expect(week.next.last, week);
      }
    });

    test("LocalWeekTimeRange.next/last keep weekStart", () {
      final LocalWeekTimeRange week =
          LocalWeekTimeRange(DateTime(2025, 6, 4), DateTime.wednesday);

      expect(week.next.weekStart, DateTime.wednesday);
      expect(week.last.weekStart, DateTime.wednesday);
      expect(week.next.from, DateTime(2025, 6, 11));
      expect(week.last.from, DateTime(2025, 5, 28));

      final LocalWeekTimeRange fallBack =
          LocalWeekTimeRange(DateTime(2025, 10, 30), DateTime.sunday);
      expect(fallBack.next.from, DateTime(2025, 11, 2));
      expect(fallBack.next.next.from, DateTime(2025, 11, 9));
    });
  });

  group("HourTimeRange around DST", () {
    void expectContiguous(HourTimeRange start, int steps) {
      HourTimeRange current = start;
      for (int i = 0; i < steps; i++) {
        final HourTimeRange next = current.next;
        expect(next.from, current.to.add(_aMicrosecond));
        expect(next.last, current);
        current = next;
      }
    }

    test("next/last never get stuck", () {
      expectContiguous(HourTimeRange(2025, 3, 8, 20), 12);
      expectContiguous(HourTimeRange(2025, 11, 1, 20), 12);
      expectContiguous(HourTimeRange(2025, 3, 29, 20), 12);
      expectContiguous(HourTimeRange(2025, 10, 25, 20), 12);

      final HourTimeRange afterSpring = HourTimeRange(2025, 3, 9, 3);
      expect(afterSpring.last.from.isBefore(afterSpring.from), true);
      expect(afterSpring.last.to.add(_aMicrosecond), afterSpring.from);
    });

    test("fromDateTime contains its own instant", () {
      for (final DateTime instant in [
        DateTime.utc(2025, 11, 2, 5, 30),
        DateTime.utc(2025, 11, 2, 6, 30),
        DateTime.utc(2025, 10, 26, 0, 30),
        DateTime.utc(2025, 10, 26, 1, 30),
        DateTime.utc(2025, 6, 4, 12, 30),
      ]) {
        final DateTime local = instant.toLocal();
        final HourTimeRange range = HourTimeRange.fromDateTime(local);

        expect(range.contains(local), true, reason: "$local");
        expect(range.duration, const Duration(hours: 1) - _aMicrosecond);
        expect(range.hour, local.hour);
      }
    });
  });

  group("Calendar", () {
    test("ComplexCalendar uses the moment's timezone for the reference", () {
      final DateTime moment = DateTime.utc(2025, 6, 4, 23);
      final DateTime reference = DateTime.utc(2025, 6, 5, 0, 30).toLocal();

      expect(
        moment
            .toMoment(localization: MomentLocalizations.enUS())
            .calendar(reference: reference),
        "Yesterday at 11:00 PM",
      );
      expect(
        moment
            .toMoment(localization: MomentLocalizations.jaJp())
            .calendar(reference: reference),
        "昨日 23:00",
      );
      expect(
        moment
            .toMoment(localization: MomentLocalizations.it())
            .calendar(reference: reference),
        "ieri alle 23:00",
      );
      expect(
        moment
            .toMoment(localization: MomentLocalizations.pt())
            .calendar(reference: reference),
        "Ontem às 23:00",
      );
      expect(
        moment
            .toMoment(localization: MomentLocalizations.zhCn())
            .calendar(reference: reference),
        "昨天 23:00",
      );
    });

    test("weekday window is -6..6 calendar days, regardless of time", () {
      final DateTime friday = DateTime(2025, 6, 13, 10);
      String cal(DateTime dt) => dt.toMoment().calendar(reference: friday);

      expect(cal(DateTime(2025, 6, 6, 12)), "6/6/2025");
      expect(cal(DateTime(2025, 6, 6, 9)), "6/6/2025");
      expect(cal(DateTime(2025, 6, 7, 9)), "Last Saturday at 9:00 AM");
      expect(cal(DateTime(2025, 6, 7, 23)), "Last Saturday at 11:00 PM");
      expect(cal(DateTime(2025, 6, 19, 11)), "Thursday at 11:00 AM");
      expect(cal(DateTime(2025, 6, 19, 9)), "Thursday at 9:00 AM");
      expect(cal(DateTime(2025, 6, 20, 9)), "6/20/2025");
      expect(cal(DateTime(2025, 6, 20, 11)), "6/20/2025");

      final it = MomentLocalizations.it();
      final Moment sunday =
          DateTime(2025, 6, 15, 10).toMoment(localization: it);
      final Moment lastSunday =
          DateTime(2025, 6, 8, 10).toMoment(localization: it);
      final Moment monday = DateTime(2025, 6, 9, 10).toMoment(localization: it);

      expect(
        it.calendar(lastSunday, reference: DateTime(2025, 6, 14, 10)),
        "La scorsa domenica alle 10:00",
      );
      expect(
        it.calendar(lastSunday, reference: sunday, omitHours: true),
        "8/6/2025",
      );
      expect(
        it.calendar(monday, reference: sunday, omitHours: true),
        "Lo scorso lunedì",
      );
    });

    test("relative days across DST transitions", () {
      String cal(DateTime dt, DateTime ref) =>
          dt.toMoment().calendar(reference: ref, omitHours: true);

      for (final List<int> day in [
        [2025, 3, 9],
        [2025, 3, 30],
        [2025, 11, 2],
        [2025, 10, 26],
      ]) {
        final DateTime transition = DateTime(day[0], day[1], day[2], 10);
        final DateTime after = DateTime(day[0], day[1], day[2] + 1, 10);
        final DateTime before = DateTime(day[0], day[1], day[2] - 1, 10);

        expect(cal(transition, after), "Yesterday");
        expect(cal(after, transition), "Tomorrow");
        expect(cal(before, transition), "Yesterday");
        expect(cal(transition, before), "Tomorrow");
        expect(cal(transition, transition), "Today");
      }
    });

    test("base calendar() follows the same window", () {
      final _BaseLocalization base = _BaseLocalization();
      final DateTime friday = DateTime(2025, 6, 13, 10);

      expect(
        base.calendar(DateTime(2025, 6, 6, 12).toMoment(localization: base),
            reference: friday),
        "6/6/2025",
      );
      expect(
        base.calendar(DateTime(2025, 6, 19, 9).toMoment(localization: base),
            reference: friday),
        "Thursday 09:00",
      );
    });
  });

  group("Range formatting", () {
    test("custom range respects anchor and useRelative", () {
      final CustomTimeRange range =
          CustomTimeRange(DateTime(2020, 1, 1), DateTime(2020, 1, 2));

      expect(
          range.format(anchor: DateTime(2020, 1, 1, 12)), "Today - Tomorrow");
      expect(
        range.format(anchor: DateTime(2020, 1, 1, 12), useRelative: false),
        "Jan 1, 2020 12:00 AM - Jan 2, 2020 12:00 AM",
      );
    });

    test("this week uses the range's weekStart", () {
      final LocalWeekTimeRange wednesday =
          LocalWeekTimeRange(DateTime(2025, 6, 4), DateTime.wednesday);

      expect(wednesday.format(anchor: DateTime(2025, 6, 5)), "This week");
      expect(
        wednesday.format(anchor: DateTime(2025, 6, 3)),
        isNot("This week"),
      );
    });

    test("base range() prints months once", () {
      expect(
        MonthTimeRange(2025, 6).format(localization: _BaseLocalization()),
        "June 2025",
      );
    });
  });

  group("relative thresholds compare rounded values", () {
    final LocalizationEnUs en = MomentLocalizations.enUS();

    final Map<Duration, String> cases = {
      const Duration(seconds: 44): "a few seconds",
      const Duration(seconds: 45): "a minute",
      const Duration(seconds: 89): "a minute",
      const Duration(seconds: 90): "2 minutes",
      const Duration(minutes: 44, seconds: 29): "44 minutes",
      const Duration(minutes: 44, seconds: 30): "an hour",
      const Duration(minutes: 89): "an hour",
      const Duration(minutes: 90): "2 hours",
      const Duration(hours: 21, minutes: 29): "21 hours",
      const Duration(hours: 21, minutes: 30): "a day",
      const Duration(hours: 35): "a day",
      const Duration(hours: 36): "2 days",
      const Duration(days: 25, hours: 11): "25 days",
      const Duration(days: 25, hours: 12): "a month",
      const Duration(days: 44): "a month",
      const Duration(days: 45): "2 months",
      const Duration(days: 314): "10 months",
      const Duration(days: 315): "a year",
      const Duration(days: 547): "a year",
      const Duration(days: 548): "2 years",
    };

    for (final MapEntry<Duration, String> entry in cases.entries) {
      test("${entry.key}", () {
        expect(en.relative(entry.key, dropPrefixOrSuffix: true), entry.value);
        expect(en.relative(-entry.key, dropPrefixOrSuffix: true), entry.value);
      });
    }
  });

  group("TimeRange encode/parse", () {
    final List<TimeRange> ranges = [
      HourTimeRange(2025, 6, 4, 13),
      HourTimeRange(2025, 6, 4, 13, isUtc: true),
      DayTimeRange(2025, 6, 4),
      DayTimeRange(2025, 6, 4, isUtc: true),
      IsoWeekTimeRange(DateTime(2025, 6, 4)),
      IsoWeekTimeRange(DateTime.utc(2025, 6, 4)),
      LocalWeekTimeRange(DateTime(2025, 6, 4)),
      LocalWeekTimeRange(DateTime(2025, 6, 4), DateTime.wednesday),
      LocalWeekTimeRange(DateTime.utc(2025, 6, 4), DateTime.sunday),
      MonthTimeRange(2025, 6),
      MonthTimeRange(2025, 6, isUtc: true),
      YearTimeRange(2025),
      YearTimeRange(2025, isUtc: true),
      CustomTimeRange(DateTime(2025, 1, 1), DateTime(2025, 1, 2)),
      CustomTimeRange(DateTime.utc(2025, 1, 1), DateTime.utc(2025, 1, 2)),
    ];

    test("round-trips timezone and weekStart", () {
      for (final TimeRange range in ranges) {
        for (final String encoded in [range.encode(), range.encodeShort()]) {
          final TimeRange parsed = TimeRange.parse(encoded);

          expect(parsed, range, reason: encoded);
          expect(parsed.runtimeType, range.runtimeType, reason: encoded);
          expect(parsed.isUtc, range.isUtc, reason: encoded);
          if (range is LocalWeekTimeRange) {
            expect((parsed as LocalWeekTimeRange).weekStart, range.weekStart);
          }
        }
      }
    });

    test("local ranges encode exactly as before", () {
      final DateTime from = DateTime(2025, 6, 4);
      final String tag = from.microsecondsSinceEpoch.toRadixString(36);

      expect(DayTimeRange(2025, 6, 4).encodeShort(), "D#$tag");
      expect(LocalWeekTimeRange(from, DateTime.wednesday).encodeShort(),
          "W#$tag#3");
      expect(LocalWeekTimeRange(DateTime(2025, 6, 2), DateTime.monday).encode(),
          "LocalWeekTimeRange@2025-06-02T00:00:00.000@1");
      expect(
        LocalWeekTimeRange(DateTime(2025, 6, 2)).encode(),
        "LocalWeekTimeRange@${LocalWeekTimeRange(DateTime(2025, 6, 2)).from.toIso8601String()}",
      );
    });

    test("strings from older versions parse as before", () {
      final DateTime utcMidnight = DateTime.utc(2025, 6, 4);
      final int micros = utcMidnight.microsecondsSinceEpoch;
      final String tag = micros.toRadixString(36);
      final DateTime asLocal = DateTime.fromMicrosecondsSinceEpoch(micros);

      expect(TimeRange.parse("D#$tag"), DayTimeRange.fromDateTime(asLocal));
      expect(TimeRange.parse("H#$tag"), HourTimeRange.fromDateTime(asLocal));
      expect(TimeRange.parse("K#$tag"), IsoWeekTimeRange(asLocal));
      expect(TimeRange.parse("W#$tag"), LocalWeekTimeRange(asLocal));
      expect(TimeRange.parse("M#$tag"), MonthTimeRange.fromDateTime(asLocal));
      expect(TimeRange.parse("Y#$tag"), YearTimeRange.fromDateTime(asLocal));
      expect(
        TimeRange.parse("C#$tag#$tag"),
        CustomTimeRange(asLocal, asLocal),
      );
      expect(TimeRange.tryParse("C#$tag"), null);
      expect(
        TimeRange.parse("DayTimeRange@2025-06-04T00:00:00.000Z"),
        DayTimeRange(2025, 6, 4, isUtc: true),
      );
    });

    test("rejects malformed flags", () {
      final String tag =
          DateTime(2025).microsecondsSinceEpoch.toRadixString(36);

      expect(TimeRange.tryParse("D#$tag#x"), null);
      expect(TimeRange.tryParse("D#$tag#3"), null);
      expect(TimeRange.tryParse("W#$tag#8"), null);
      expect(TimeRange.tryParse("W#$tag#u#u"), null);
      expect(TimeRange.tryParse("LocalWeekTimeRange@2025-06-02@9"), null);
    });
  });

  group("Format tokens", () {
    test("y uses era years", () {
      final Moment yearZero = DateTime.utc(0, 6, 1).toMoment();
      final Moment twoBc = DateTime.utc(-1, 6, 1).toMoment();

      expect(yearZero.format("y NNNNN"), "1 BC");
      expect(twoBc.format("y NNNNN"), "2 BC");
      expect(DateTime.utc(2025).toMoment().format("y NNNNN"), "2025 AD");
    });

    test("X floors negative timestamps", () {
      String x(int ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true)
          .toMoment()
          .format("X");

      expect(x(-1500), "-2");
      expect(x(-1000), "-1");
      expect(x(-1), "-1");
      expect(x(0), "0");
      expect(x(1500), "1");
    });

    test("DDDo fallback uses the day of year", () {
      expect(
        Moment(DateTime(2025, 2, 3), localization: _BaseLocalization())
            .format("DDDo"),
        "Day 34 of the year (ordered)",
      );
    });

    test("formatters are cached and subclass overrides still apply", () {
      final LocalizationEnUs en = MomentLocalizations.enUS();
      expect(identical(en.formatters, en.formatters), true);

      final LocalizationMnQaaqMn traditional = MomentLocalizations.mnMongtn();
      expect(
        DateTime(2025, 6, 4).toMoment(localization: traditional).format("YYYY"),
        "᠒᠐᠒᠕",
      );
    });
  });

  group("Localization lookup", () {
    test("byLocale is case-insensitive and accepts hyphens", () {
      for (final String code in [
        "en_US",
        "en-US",
        "en_us",
        "EN-US",
        "En_Us",
      ]) {
        expect(MomentLocalizations.byLocale(code)?.locale, "en_US");
      }
      expect(MomentLocalizations.byLocale("mn-mong-mn")?.locale, "mn_Mong_MN");
      expect(MomentLocalizations.byLocale("ES")?.locale, "es_ES");
      expect(MomentLocalizations.byLocale("en")?.locale, "en_US");
      expect(MomentLocalizations.byLocale("en", strict: true), null);
      expect(MomentLocalizations.byLocale("en_GB")?.locale, "en_US");
      expect(MomentLocalizations.byLocale("pt-BR")?.locale, "pt_PT");
      expect(MomentLocalizations.byLocale("mn_Mong_CN")?.locale, "mn_Mong_MN");
      expect(MomentLocalizations.byLocale("xx_YY"), null);
    });

    test("byLanguage matches whole subtags", () {
      expect(MomentLocalizations.byLanguage("e"), null);
      expect(MomentLocalizations.byLanguage("m"), null);
      expect(MomentLocalizations.byLanguage("en")?.locale, "en_US");
      expect(MomentLocalizations.byLanguage("EN")?.locale, "en_US");
      expect(
        MomentLocalizations.byLanguage("mn", scriptCode: "Mong")?.locale,
        "mn_Mong_MN",
      );
      expect(MomentLocalizations.byLanguage("mn", countryCode: "MN")?.locale,
          "mn_MN");
      expect(
        MomentLocalizations.byLanguage("mn", scriptCode: "Mon", strict: true),
        null,
      );
    });
  });
}
