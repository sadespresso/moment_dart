import 'package:moment_dart/moment_dart.dart';
import 'package:test/test.dart';

void main() {
  group("Moment.copyWith", () {
    final Moment moment = Moment(
      DateTime(2024, 3, 14, 9, 5, 7, 8, 9),
      localization: MomentLocalizations.fr(),
    );

    test("takes DateTime fields and keeps the localization", () {
      final Moment copy = moment.copyWith(year: 2020, minute: 30);

      expect(copy, DateTime(2020, 3, 14, 9, 30, 7, 8, 9));
      expect(copy.localization.locale, "fr_FR");
    });

    test("applies fields on top of dateTime", () {
      final Moment copy = moment.copyWith(
        dateTime: DateTime(2000, 1, 1),
        day: 5,
        localization: MomentLocalizations.de(),
      );

      expect(copy, DateTime(2000, 1, 5));
      expect(copy.localization.locale, "de_DE");
    });

    test("isUtc", () {
      final Moment copy = moment.copyWith(isUtc: true);

      expect(copy.isUtc, true);
      expect(copy.hour, 9);
    });
  });

  group("isAtSame*As converts other to this timezone", () {
    test("same instant, different zones", () {
      final DateTime local = DateTime(2024, 6, 1, 12, 30);
      final DateTime utc = local.toUtc();

      expect(local.isAtSameDayAs(utc), true);
      expect(local.isAtSameHourAs(utc), true);
      expect(local.isAtSameMinuteAs(utc), true);
      expect(utc.isAtSameHourAs(local), true);
    });

    test("repeated DST hour", () {
      final DateTime first = DateTime(2024, 11, 3, 1, 30);
      final DateTime second = first.add(const Duration(hours: 1));

      // Only meaningful where this is the US fall-back night
      if (second.hour != 1) return;

      expect(first.isAtSameHourAs(second), false);
      expect(first.isAtSameDayAs(second), true);
    });
  });

  group("CustomTimeRange", () {
    test("throws when to is before from", () {
      expect(
        () => CustomTimeRange(DateTime(2024, 2), DateTime(2024, 1)),
        throwsArgumentError,
      );
    });

    test("allows an empty range", () {
      final DateTime t = DateTime(2024, 1, 1);
      expect(CustomTimeRange(t, t).duration, Duration.zero);
    });
  });

  test("types.dart is exported", () {
    final FormatSetOptional formats = {FormatterToken.A: null};
    expect(formats.length, 1);
  });
}
