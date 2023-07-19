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
            interval.unit == DurationUnit.day);

    late final String suffix; // Language specific stuff

    if (form != Abbreviation.none) {
      suffix = "";
    } else if (interval.unit == DurationUnit.month) {
      suffix = " ᠶᠢᠨ";
    } else {
      suffix = (useFeminineSuffix ? " ᠦᠨ" : " ᠤᠨ");
    }

    return result + suffix;
  }

  @override
  String relativePast(String unit) => "$unit ᠡᠮᠦᠨ᠎ᠡ";
  @override
  String relativeFuture(String unit) => "$unit ᠳᠠᠷᠠᠭ᠎ᠠ";

  @override
  Map<DurationInterval, UnitString> get units => {
        DurationInterval.lessThanASecond: UnitString.withForm(
          "ᠬᠡᠳᠦᠨ ᠬᠣᠷᠤᠮ",
          "ᠬᠣᠷᠤᠮ",
          "ᠬᠣᠷᠤᠮ",
        ),
        DurationInterval.aSecond: UnitString.withForm(
          "1 ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
          "1 ᠰᠧᠻ᠊᠍",
          "1ᠰ",
        ),
        DurationInterval.seconds: UnitString.withForm(
          "$srDelta ᠰᠧᠻᠦ᠋ᠨ᠍ᠳ᠋",
          "$srDelta ᠰᠧᠻ᠍᠊᠍",
          "$srDeltaᠰ",
        ),
        DurationInterval.aMinute: UnitString.withForm(
          "1 ᠮᠢᠨᠦᠢᠲ",
          "1 ᠮᠢᠨ᠊᠍",
          "1ᠮ",
        ),
        DurationInterval.minutes: UnitString.withForm(
          "$srDelta ᠮᠢᠨᠦᠢᠲ",
          "$srDelta ᠮᠢᠨ᠊᠍",
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
          "1 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ",
          "1 ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍",
          "1ᠳᠣ.ᠬᠣᠨ᠍᠊᠍",
        ),
        DurationInterval.weeks: UnitString.withForm(
          "$srDelta ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨᠤᠭ",
          "$srDelta ᠳᠣᠯᠤᠭ᠎ᠠ ᠬᠣᠨ᠍᠊᠍",
          "$srDeltaᠳᠣ.ᠬᠣᠨ᠍᠊᠍",
        ),
        DurationInterval.aMonth: UnitString.withForm(
          "1 ᠰᠠᠷ᠎ᠠ",
          "1 ᠰᠠ᠊᠍",
          "1ᠰᠠ᠊᠍",
        ),
        DurationInterval.months: UnitString.withForm(
          "$srDelta ᠰᠠᠷ᠎ᠠ",
          "$srDelta ᠰᠠ᠊᠍",
          "$srDeltaᠰᠠ᠊᠍",
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
