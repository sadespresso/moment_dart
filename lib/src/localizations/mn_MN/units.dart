import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/utils/duration_unit.dart';
import 'package:moment_dart/src/localizations/utils/relative_interval.dart';
import 'package:moment_dart/src/localizations/utils/unit_form.dart';

/// This mixin provides:
///
/// * [srDelta] - string getter;
/// * [units] - map of unit translations that use [srDelta] as unit placeholder
/// * [relativePast] - A function suffixes/prefixes given duration
/// * [relativeFuture] - A function suffixes/prefixes given duration
mixin MnMnUnits on SimpleUnits {
  /// This is used as a placeholder for unit in plural expressions
  @override
  String get srDelta => "%";

  String getUnit(DurationInterval interval, UnitStringForm form,
      {bool dropPrefixOrSuffix = false}) {
    late final String unit;

    late final bool aFewSec;

    if (interval == DurationInterval.fewSeconds) {
      aFewSec = true;
      unit = "хэдэн";
    } else if (interval.singular) {
      aFewSec = false;
      unit = "1";
    } else {
      aFewSec = false;
      unit = srDelta;
    }

    if (!dropPrefixOrSuffix || aFewSec) {
      final bool useMasculineSuffix = aFewSec ||
          interval.unit == DurationUnit.minute ||
          interval.unit == DurationUnit.month;

      final String suffix = useMasculineSuffix ? "ын" : "ийн";

      return (interval.singular
              ? unitsWithSuffixConsidered[interval]![form]
              : unitsWithSuffixConsidered[interval]![form]
                  .replaceAll(srDelta, unit)) +
          suffix;
    }

    return interval.singular
        ? units[interval]![form]
        : units[interval]![form].replaceAll(srDelta, unit);
  }

  @override
  String relativePast(String unit) => "$unit өмнө";
  @override
  String relativeFuture(String unit) => "$unit дараа";

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.fewSeconds: UnitString(
          "хэдэн хором",
          "хором",
          "хором",
        ),
        DurationInterval.aSecond: UnitString(
          "1 секунд",
          "1 сек",
          "1с",
        ),
        DurationInterval.seconds: UnitString(
          "$srDelta секунд",
          "$srDelta сек",
          "$srDeltaс",
        ),
        DurationInterval.aMinute: UnitString(
          "1 минут",
          "1 мин",
          "1м",
        ),
        DurationInterval.minutes: UnitString(
          "$srDelta минут",
          "$srDelta мин",
          "$srDeltaм",
        ),
        DurationInterval.anHour: UnitString(
          "1 цаг",
          "1 цаг",
          "1ц",
        ),
        DurationInterval.hours: UnitString(
          "$srDelta цаг",
          "$srDelta цаг",
          "$srDeltaц",
        ),
        DurationInterval.aDay: UnitString(
          "1 өдөр",
          "1 өдөр",
          "1ө",
        ),
        DurationInterval.days: UnitString(
          "$srDelta өдөр",
          "$srDelta өдөр",
          "$srDeltaө",
        ),
        DurationInterval.aWeek: UnitString(
          "1 долоо хоног",
          "1 долоо хон",
          "1дол.хон",
        ),
        DurationInterval.weeks: UnitString(
          "$srDelta долоо хоног",
          "$srDelta долоо хон",
          "$srDeltaдол.хон",
        ),
        DurationInterval.aMonth: UnitString(
          "1 сар",
          "1 сар",
          "1сар",
        ),
        DurationInterval.months: UnitString(
          "$srDelta сар",
          "$srDelta сар",
          "$srDeltaсар",
        ),
        DurationInterval.aYear: UnitString(
          "1 жил",
          "1 жил",
          "1жил",
        ),
        DurationInterval.years: UnitString(
          "$srDelta жил",
          "$srDelta жил",
          "$srDeltaжил",
        ),
      };

  Map<DurationInterval, UnitString> get unitsWithSuffixConsidered => {
        ...units,
        DurationInterval.fewSeconds: UnitString(
          "хэдэн хорм",
          "хорм",
          "хорм",
        ),
        DurationInterval.aDay: UnitString(
          "1 өдр",
          "1 өдөр",
          "1ө",
        ),
        DurationInterval.days: UnitString(
          "$srDelta өдр",
          "$srDelta өдөр",
          "$srDeltaө",
        ),
      };
}
