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
    if (!dropPrefixOrSuffix) {
      final bool useMasculineSuffix =
          interval == DurationInterval.lessThanASecond ||
              interval.unit == DurationUnit.minute ||
              interval.unit == DurationUnit.month;

      final String suffix = form != UnitStringForm.full
          ? ""
          : (useMasculineSuffix ? "ын" : "ийн");

      return unitsWithSuffixConsidered[interval]!
              .get(form, dropPrefixOrSuffix) +
          suffix;
    }

    return units[interval]?.get(form, dropPrefixOrSuffix) ?? "¯\\_(ツ)_/¯";
  }

  @override
  String relativePast(String unit) => "$unit өмнө";
  @override
  String relativeFuture(String unit) => "$unit дараа";

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "хэдэн хором",
          "хором",
          "хором",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "1 секунд",
          "1 сек",
          "1с",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta секунд",
          "$srDelta сек",
          "$srDeltaс",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "1 минут",
          "1 мин",
          "1м",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta минут",
          "$srDelta мин",
          "$srDeltaм",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "1 цаг",
          "1 цаг",
          "1ц",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta цаг",
          "$srDelta цаг",
          "$srDeltaц",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "1 өдөр",
          "1 өдөр",
          "1ө",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta өдөр",
          "$srDelta өдөр",
          "$srDeltaө",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "1 долоо хоног",
          "1 долоо хон",
          "1дол.хон",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta долоо хоног",
          "$srDelta долоо хон",
          "$srDeltaдол.хон",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "1 сар",
          "1 сар",
          "1сар",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta сар",
          "$srDelta сар",
          "$srDeltaсар",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "1 жил",
          "1 жил",
          "1жил",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta жил",
          "$srDelta жил",
          "$srDeltaжил",
        ),
      };

  Map<DurationInterval, UnitString> get unitsWithSuffixConsidered => {
        ...units,
        DurationInterval.lessThanASecond: UnitString.withForm(
          "хэдэн хорм",
          "хорм",
          "хорм",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "1 өдр",
          "1 өдөр",
          "1ө",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta өдр",
          "$srDelta өдөр",
          "$srDeltaө",
        ),
      };
}
