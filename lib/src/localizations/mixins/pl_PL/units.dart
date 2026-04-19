import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/pl_PL/unit_string.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

abstract class CountDependentUnitString extends UnitString {
  const CountDependentUnitString();

  @override
  String get(Abbreviation form, bool dropPrefixOrSuffix, [int count = 1]);
}

mixin PlPlUnits on SimpleUnits {
  @override
  String relativePast(String unit) {
    return "$unit temu";
  }

  @override
  String relativeFuture(String unit) {
    return "za $unit";
  }

  @override
  Map<DurationInterval, CountDependentUnitString> get units => {
        DurationInterval.lessThanASecond: PolishSingularUnitString(
          "kilka sekund",
          "kilka sekund",
          "kilka sek.",
        ),
        DurationInterval.aSecond: PolishSingularUnitString(
          "sekunda",
          "sekundę",
          "sek.",
        ),
        DurationInterval.seconds: PolishPluralUnitString(
          singular: "$srDelta sekunda",
          few: "$srDelta sekundy",
          many: "$srDelta sekund",
          short: "$srDelta sek.",
        ),
        DurationInterval.aMinute: PolishSingularUnitString(
          "1 minuta",
          "minutę",
          "min",
        ),
        DurationInterval.minutes: PolishPluralUnitString(
          singular: "$srDelta minuta",
          few: "$srDelta minuty",
          many: "$srDelta minut",
          short: "$srDelta min",
        ),
        DurationInterval.anHour: PolishSingularUnitString(
          "godzina",
          "godzinę",
          "godz.",
        ),
        DurationInterval.hours: PolishPluralUnitString(
          singular: "$srDelta godzina",
          few: "$srDelta godziny",
          many: "$srDelta godzin",
          short: "$srDelta godz.",
        ),
        DurationInterval.aDay: PolishSingularUnitString(
          "dzień",
          "dzień",
          "dz.",
        ),
        DurationInterval.days: PolishPluralUnitString(
          singular: "$srDelta dzień",
          few: "$srDelta dni",
          many: "$srDelta dni",
          short: "$srDelta dn.",
        ),
        DurationInterval.aWeek: PolishSingularUnitString(
          "1 tydzień",
          "tydzień",
          "1 tydz.",
        ),
        DurationInterval.weeks: PolishPluralUnitString(
          singular: "$srDelta tydzień",
          few: "$srDelta tygodnie",
          many: "$srDelta tygodni",
          short: "$srDelta tyg.",
        ),
        DurationInterval.aMonth: PolishSingularUnitString(
          "miesiąc",
          "miesiąc",
          "1 mies.",
        ),
        DurationInterval.months: PolishPluralUnitString(
          singular: "$srDelta miesiąc",
          few: "$srDelta miesiące",
          many: "$srDelta miesięcy",
          short: "$srDelta mies.",
        ),
        DurationInterval.aYear: PolishSingularUnitString(
          "rok",
          "rok",
          "1 r.",
        ),
        DurationInterval.years: PolishPluralUnitString(
          singular: "$srDelta rok",
          few: "$srDelta lata",
          many: "$srDelta lat",
          short: "$srDelta l.",
        ),
      };
}
