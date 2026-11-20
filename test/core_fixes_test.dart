import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

// Local instants sampled around the 2024 DST transitions of both hemispheres
// (US, EU, AU). In zones without DST these are ordinary instants, so every
// invariant below holds in any zone.
List<DateTime> _instantsAroundTransitions() {
  final List<DateTime> result = [];
  for (final DateTime base in [
    DateTime.utc(2024, 3, 10, 0),
    DateTime.utc(2024, 3, 31, 0),
    DateTime.utc(2024, 4, 6, 12),
    DateTime.utc(2024, 10, 5, 12),
    DateTime.utc(2024, 10, 27, 0),
    DateTime.utc(2024, 11, 3, 0),
  ]) {
    for (int k = 0; k < 24 * 4; k++) {
      result.add(DateTime.fromMicrosecondsSinceEpoch(
        base.microsecondsSinceEpoch +
            k * 17 * Duration.microsecondsPerMinute +
            123456789,
      ));
    }
  }
  return result;
}

void main() {
  final List<DateTime> instants = _instantsAroundTransitions();

  // Second occurrence of 01:30 on the US fall-back day; in zones without that
  // transition this is just 02:30.
  final DateTime firstOneThirty = DateTime(2024, 11, 3, 1, 30);
  final DateTime secondOneThirty = firstOneThirty.add(const Duration(hours: 1));
  final bool hasUsFallBack = secondOneThirty.hour == 1;

  // Australia/Lord_Howe shifts by 30 minutes, so one wall-clock hour lasts 90
  // minutes and the "whole hour" invariants below cannot hold there.
  final bool halfHourShift = (DateTime(2024, 1, 1).timeZoneOffset -
                  DateTime(2024, 7, 1).timeZoneOffset)
              .inMinutes %
          60 !=
      0;
  final bool hasUsSpringForward = DateTime(2024, 3, 10, 2, 30).hour == 3;

  group("differenceInDays", () {
    test("consecutive local days differ by exactly one", () {
      for (DateTime d = DateTime(2024, 1, 1);
          d.year == 2024;
          d = DateTime(d.year, d.month, d.day + 1)) {
        final DateTime next = DateTime(d.year, d.month, d.day + 1);
        expect(next.differenceInDays(d), 1, reason: "$d");
        expect(d.differenceInDays(next), -1, reason: "$d");
      }
      expect(DateTime(2024, 3, 11).differenceInDays(DateTime(2024, 3, 10)), 1);
      expect(DateTime(2024, 3, 20).differenceInDays(DateTime(2024, 3, 1)), 19);
    });

    test("calendar uses calendar days", () {
      final MomentLocalization en = MomentLocalizations.enUS();
      expect(
        Moment(DateTime(2024, 3, 11, 0, 30), localization: en)
            .calendar(reference: DateTime(2024, 3, 10, 23)),
        startsWith("Tomorrow"),
      );
      expect(
        Moment(DateTime(2024, 3, 10, 12), localization: en)
            .calendar(reference: DateTime(2024, 3, 11, 12)),
        startsWith("Yesterday"),
      );
    });
  });

  group("weekday finders keep wall-clock time", () {
    test("local", () {
      for (DateTime d = DateTime(2024, 1, 1);
          d.year == 2024;
          d = DateTime(d.year, d.month, d.day + 1)) {
        final DateTime next = d.nextMonday();
        final DateTime last = d.lastFriday();

        expect(next.weekday, DateTime.monday);
        // Where midnight is skipped (America/Santiago) the day starts at 01:00
        expect(next, DateTime(next.year, next.month, next.day, d.hour),
            reason: "$d.nextMonday() = $next");
        expect(next.isAfter(d), true);
        expect(last.weekday, DateTime.friday);
        expect(last, DateTime(last.year, last.month, last.day, d.hour),
            reason: "$d.lastFriday() = $last");
        expect(last.isBefore(d), true);
      }
      expect(DateTime(2024, 3, 8).nextMonday(), DateTime(2024, 3, 11));
      expect(DateTime(2024, 3, 12).lastFriday(), DateTime(2024, 3, 8));
    });

    test("UTC", () {
      final DateTime u = DateTime.utc(2024, 3, 8, 13, 14, 15, 16, 17);
      expect(u.nextMonday(), DateTime.utc(2024, 3, 11, 13, 14, 15, 16, 17));
      expect(u.lastFriday(), DateTime.utc(2024, 3, 1, 13, 14, 15, 16, 17));
      expect(u.nextMonday().isUtc, true);
      expect(Moment(u).nextSunday().isUtc, true);
    });
  });

  test("fromPrecise honours dropPrefixOrSuffix", () {
    final Moment m = Moment(
      DateTime.utc(2024, 1, 1),
      localization: MomentLocalizations.enUS(),
    );

    expect(m.fromPrecise(DateTime.utc(2024, 1, 1, 3)), "3 hours ago");
    expect(
      m.fromPrecise(DateTime.utc(2024, 1, 1, 3), dropPrefixOrSuffix: true),
      "3 hours",
    );
    expect(
      m.fromPrecise(DateTime.utc(2023, 12, 31, 21), dropPrefixOrSuffix: true),
      "3 hours",
    );
  });

  group("repeated and skipped hours", () {
    test("clone keeps the instant", () {
      expect(secondOneThirty.clone().isAtSameMomentAs(secondOneThirty), true);
      expect(Moment(secondOneThirty).clone().isAtSameMomentAs(secondOneThirty),
          true);
      for (final DateTime t in instants) {
        expect(t.clone().microsecondsSinceEpoch, t.microsecondsSinceEpoch);
      }
    });

    test("startOf/endOf contain the instant", () {
      const List<DurationUnit> units = [
        DurationUnit.microsecond,
        DurationUnit.millisecond,
        DurationUnit.second,
        DurationUnit.minute,
        DurationUnit.hour,
        DurationUnit.day,
      ];

      for (final DateTime t in [...instants, secondOneThirty]) {
        for (final DurationUnit unit in units) {
          final DateTime start = t.startOf(unit);
          final DateTime end = t.endOf(unit);

          expect(start.isAfter(t), false, reason: "$t startOf $unit");
          expect(end.isBefore(t), false, reason: "$t endOf $unit");
          expect(start.isUtc, false);
          expect(end.isUtc, false);
        }

        expect(
            t.difference(t.startOfMinute()) < const Duration(minutes: 1), true);
        expect(t.endOfHour().isAfter(t), true);
        if (!halfHourShift) {
          expect(t.startOfHour().minute, 0);
          expect(t.endOfHour().minute, 59);
        }
      }
    });

    test("fall-back second occurrence", () {
      if (!hasUsFallBack) return;

      expect(
          secondOneThirty.startOfHour().toUtc(), DateTime.utc(2024, 11, 3, 6));
      expect(secondOneThirty.startOfMinute().toUtc(),
          DateTime.utc(2024, 11, 3, 6, 30));
      expect(secondOneThirty.endOfHour().toUtc(),
          DateTime.utc(2024, 11, 3, 6, 59, 59, 999, 999));
      expect(firstOneThirty.endOfHour().toUtc(),
          DateTime.utc(2024, 11, 3, 5, 59, 59, 999, 999));
    });

    test("UTC stays UTC", () {
      final DateTime u = DateTime.utc(2024, 11, 3, 1, 30, 15, 250, 7);
      expect(u.startOfHour(), DateTime.utc(2024, 11, 3, 1));
      expect(u.startOfSecond(), DateTime.utc(2024, 11, 3, 1, 30, 15));
      expect(u.endOfMinute(), DateTime.utc(2024, 11, 3, 1, 30, 59, 999, 999));
      expect(
          u.endOfMillisecond(), DateTime.utc(2024, 11, 3, 1, 30, 15, 250, 999));
      expect(u.startOfNextHour(), DateTime.utc(2024, 11, 3, 2));
      expect(
          u.endOfLastMinute(), DateTime.utc(2024, 11, 3, 1, 29, 59, 999, 999));
    });
  });

  group("hour and minute finders", () {
    test("invariants", () {
      for (final DateTime t in [...instants, secondOneThirty]) {
        final DateTime startOfHour = t.startOfHour();
        final DateTime nextHour = t.startOfNextHour();
        final DateTime lastHour = t.startOfLastHour();

        expect(nextHour.isAfter(t), true, reason: "$t");
        if (halfHourShift) continue;
        expect(nextHour.minute, 0);
        expect(
            nextHour.difference(startOfHour) <= const Duration(hours: 1), true,
            reason: "$t");
        expect(lastHour.isBefore(startOfHour), true, reason: "$t");
        expect(lastHour.minute, 0);
        expect(
            startOfHour.difference(lastHour) <= const Duration(hours: 1), true,
            reason: "$t");
        expect(t.endOfLastHour(),
            startOfHour.subtract(const Duration(microseconds: 1)));
        expect(t.endOfNextHour(), nextHour.endOfHour());

        final DateTime nextMinute = t.startOfNextMinute();
        expect(nextMinute.isAfter(t), true);
        expect(nextMinute.difference(t) <= const Duration(minutes: 1), true);
        expect(t.startOfLastMinute(),
            t.startOfMinute().subtract(const Duration(minutes: 1)));
      }
    });

    test("spring forward", () {
      if (!hasUsSpringForward) return;

      final DateTime afterGap = DateTime(2024, 3, 10, 3, 30);
      expect(afterGap.startOfLastHour(), DateTime(2024, 3, 10, 1));
      expect(
          afterGap.endOfLastHour(), DateTime(2024, 3, 10, 1, 59, 59, 999, 999));
      expect(DateTime(2024, 3, 10, 1, 30).startOfNextHour(),
          DateTime(2024, 3, 10, 3));
    });

    test("fall back", () {
      if (!hasUsFallBack) return;

      expect(firstOneThirty.startOfNextHour().toUtc(),
          DateTime.utc(2024, 11, 3, 6));
      expect(secondOneThirty.startOfLastHour().toUtc(),
          DateTime.utc(2024, 11, 3, 5));
      expect(secondOneThirty.startOfNextHour(), DateTime(2024, 11, 3, 2));
    });
  });

  test("maxValue/minValue are the same instants as the UTC ones", () {
    expect(Moment.maxValue.isAtSameMomentAs(Moment.maxValueUtc), true);
    expect(Moment.minValue.isAtSameMomentAs(Moment.minValueUtc), true);
    expect(Moment.maxValue.isUtc, false);
    expect(Moment.minValue.isUtc, false);
  });

  test("startOf(week) on DateTime names startOf", () {
    expect(
      () => DateTime(2024).startOf(DurationUnit.week),
      throwsA(isA<MomentException>().having(
        (e) => e.message,
        "message",
        startsWith("startOf("),
      )),
    );
  });
}
