import 'package:moment_dart/src/localizations/mixins/simple_units.dart';
import 'package:moment_dart/src/localizations/utils/duration_unit.dart';
import 'package:moment_dart/src/localizations/utils/relative_interval.dart';
import 'package:moment_dart/src/localizations/utils/abbreviation.dart';

/// This mixin provides:
///
/// * [srDelta] - string getter;
/// * [units] - map of unit translations that use [srDelta] as unit placeholder
/// * [relativePast] - A function suffixes/prefixes given duration
/// * [relativeFuture] - A function suffixes/prefixes given duration
mixin MnMongMnUnits on SimpleUnits {
  /// This is used as a placeholder for unit in plural expressions
  @override
  String get srDelta => "%";

  String getUnit(
    DurationInterval interval,
    Abbreviation form, {
    bool dropPrefixOrSuffix = false,
  }) {
    final String result =
        units[interval]?.get(form, dropPrefixOrSuffix) ?? "¯\\_(ツ)_/¯";

    if (dropPrefixOrSuffix) return result;

    final useFeminineSuffix = interval != DurationInterval.lessThanASecond &&
        (interval.unit == DurationUnit.minute ||
            interval.unit == DurationUnit.second ||
            interval.unit == DurationUnit.day ||
            interval.unit == DurationUnit.year);

    late final String suffix; // Language specific stuff

    if (form != Abbreviation.none) {
      suffix = "";
    } else if (interval.unit == DurationUnit.month) {
      suffix = "\u180Eᠶᠢᠨ";
    } else {
      suffix = (useFeminineSuffix ? "\u180Eᠦᠨ" : "\u180Eᠤᠨ");
    }

    return result + suffix;
  }

  @override
  String relativePast(String unit) => "$unit ᠡᠮᠦᠨ\u180Eᠡ";
  @override
  String relativeFuture(String unit) => "$unit ᠳᠠᠷᠠᠭ\u180Eᠠ";

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
          "ᠬᠣᠷᠤᠮ",
          "ᠬᠣᠷᠤᠮ",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "1 ᠰᠧᠻᠦ\u180Bᠨ\u180Bᠳ\u180B",
          "1 ᠰᠧᠻ᠊",
          "1ᠰ",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta ᠰᠧᠻᠦ\u180Bᠨ\u180Bᠳ\u180B",
          "$srDelta ᠰᠧᠻ᠊",
          "$srDeltaᠰ",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "1 ᠮᠢᠨᠦ\u180Bᠲ",
          "1 ᠮᠢᠨ\u180B᠊",
          "1ᠮ",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta ᠮᠢᠨᠦ\u180Bᠲ",
          "$srDelta ᠮᠢᠨ\u180B᠊",
          "$srDeltaᠮ",
        ),
        DurationInterval.anHour: UnitString.withForm(
          "1 ᠴᠠᠭ",
          "1 ᠴᠠᠭ",
          "1ᠴ",
        ),
        DurationInterval.hours: UnitString.withForm(
          "$srDelta ᠴᠠᠭ",
          "$srDelta ᠴᠠᠭ",
          "$srDeltaᠴ",
        ),
        DurationInterval.aDay: UnitString.withForm(
          "1 ᠡᠳᠦᠷ",
          "1 ᠡᠳᠦᠷ",
          "1ᠥ",
        ),
        DurationInterval.days: UnitString.withForm(
          "$srDelta ᠡᠳᠦᠷ",
          "$srDelta ᠡᠳᠦᠷ",
          "$srDeltaᠥ",
        ),
        DurationInterval.aWeek: UnitString.withForm(
          "1 ᠳᠣᠯᠤᠭ\u180Eᠠ ᠬᠣᠨᠤᠭ",
          "1 ᠳᠣᠯᠤᠭ\u180Eᠠ ᠬᠣᠨ\u180B᠊",
          "1ᠳᠣ.ᠬᠣᠨ\u180B᠊",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta ᠳᠣᠯᠤᠭ\u180Eᠠ ᠬᠣᠨᠤᠭ",
          "$srDelta ᠳᠣᠯᠤᠭ\u180Eᠠ ᠬᠣᠨ\u180B᠊",
          "$srDeltaᠳᠣ.ᠬᠣᠨ\u180B᠊",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "1 ᠰᠠᠷ\u180Eᠠ",
          "1 ᠰᠠ᠊",
          "1ᠰᠠ᠊",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta ᠰᠠᠷ\u180Eᠠ",
          "$srDelta ᠰᠠ᠊",
          "$srDeltaᠰᠠ᠊",
        ),
        DurationInterval.aYear: UnitString.withForm(
          "1 ᠵᠢᠯ",
          "1 ᠵᠢᠯ",
          "1ᠵᠢᠯ",
        ),
        DurationInterval.years: UnitString.withForm(
          "$srDelta ᠵᠢᠯ",
          "$srDelta ᠵᠢᠯ",
          "$srDeltaᠵᠢᠯ",
        ),
      };
}
